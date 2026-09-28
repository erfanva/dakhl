import 'package:drift/drift.dart';

import '../database.dart';
import '../seed_categories.dart';

part 'debts_dao.g.dart';

/// A debt with what has been paid against it so far.
class DebtWithProgress {
  const DebtWithProgress({required this.debt, required this.paidRial});

  final Debt debt;
  final int paidRial;

  /// Never negative: overpaying settles the debt rather than turning it
  /// around into a credit.
  int get remainingRial {
    final remaining = debt.totalAmountRial - paidRial;
    return remaining < 0 ? 0 : remaining;
  }

  /// 0…1, for the progress bar. A zero-total debt counts as fully paid.
  double get progress => debt.totalAmountRial <= 0
      ? 1
      : (paidRial / debt.totalAmountRial).clamp(0, 1).toDouble();

  bool get isSettled => debt.status == DebtStatus.settled;
  bool get iOwe => debt.direction == DebtDirection.iOwe;

  /// A due date that has passed with money still outstanding.
  bool isOverdue(DateTime now) {
    final dueAt = debt.dueAt;
    return !isSettled && dueAt != null && dueAt.isBefore(now);
  }
}

/// A payment with the ledger transaction it produced, if it produced one.
class DebtPaymentWithTxn {
  const DebtPaymentWithTxn({required this.payment, this.transaction});

  final DebtPayment payment;
  final Transaction? transaction;
}

/// Outstanding totals in both directions, for the header on the debts tab.
class DebtTotals {
  const DebtTotals({required this.iOweRial, required this.owedToMeRial});

  final int iOweRial;
  final int owedToMeRial;

  int get netRial => owedToMeRial - iOweRial;
}

@DriftAccessor(tables: [Debts, DebtPayments, Transactions, Categories])
class DebtsDao extends DatabaseAccessor<AppDatabase> with _$DebtsDaoMixin {
  DebtsDao(super.db);

  /// Open debts first, then settled ones, each newest first.
  ///
  /// Driven off [_debtChanges] rather than the `debts` query alone: a partial
  /// payment doesn't touch the debt row, and the list still has to move.
  Stream<List<DebtWithProgress>> watchDebts({
    DebtDirection? direction,
    bool includeSettled = true,
  }) {
    return _debtChanges().asyncMap((_) =>
        readDebts(direction: direction, includeSettled: includeSettled));
  }

  Future<List<DebtWithProgress>> readDebts({
    DebtDirection? direction,
    bool includeSettled = true,
  }) async {
    final query = select(debts)
      ..orderBy([
        (d) => OrderingTerm.asc(d.status),
        (d) => OrderingTerm.desc(d.createdAt),
      ]);
    if (direction != null) {
      query.where((d) => d.direction.equalsValue(direction));
    }
    if (!includeSettled) {
      query.where((d) => d.status.equalsValue(DebtStatus.open));
    }
    return _withProgress(await query.get());
  }

  Stream<DebtWithProgress?> watchDebt(int id) =>
      _debtChanges().asyncMap((_) => findDebt(id));

  Future<DebtWithProgress?> findDebt(int id) async {
    final row =
        await (select(debts)..where((d) => d.id.equals(id))).getSingleOrNull();
    if (row == null) return null;
    return (await _withProgress([row])).single;
  }

  /// Payments against [debtId], newest first.
  Stream<List<DebtPaymentWithTxn>> watchPayments(int debtId) {
    final query = select(debtPayments).join([
      leftOuterJoin(
          transactions, transactions.id.equalsExp(debtPayments.transactionId)),
    ])
      ..where(debtPayments.debtId.equals(debtId))
      ..orderBy([OrderingTerm.desc(debtPayments.paidAt)]);

    return query.watch().map((rows) => rows
        .map((row) => DebtPaymentWithTxn(
              payment: row.readTable(debtPayments),
              transaction: row.readTableOrNull(transactions),
            ))
        .toList());
  }

  /// Outstanding amounts per direction, ignoring settled debts.
  Stream<DebtTotals> watchTotals() {
    return watchDebts(includeSettled: false).map<DebtTotals>((rows) {
      var iOwe = 0;
      var owedToMe = 0;
      for (final row in rows) {
        if (row.iOwe) {
          iOwe += row.remainingRial;
        } else {
          owedToMe += row.remainingRial;
        }
      }
      return DebtTotals(iOweRial: iOwe, owedToMeRial: owedToMe);
    });
  }

  Future<int> insertDebt(DebtsCompanion entry) => into(debts).insert(entry);

  Future<bool> updateDebt(Debt entry) => update(debts).replace(entry);

  /// Deletes a debt and its payment rows (the foreign key cascades), plus its
  /// reminder rules, which reference it by (kind, id) rather than a key.
  ///
  /// The transactions those payments generated stay in the ledger: the money
  /// left the account whether or not the debt is still on the books.
  Future<void> deleteDebt(int id) {
    return transaction(() async {
      await attachedDatabase.remindersDao
          .deleteRulesFor(OwnerKind.debt, id);
      await (delete(debts)..where((d) => d.id.equals(id))).go();
    });
  }

  /// Records a payment against [debtId] and, unless [recordTransaction] is
  /// false, the ledger transaction that goes with it.
  ///
  /// Both writes and the settled check happen in one database transaction, so
  /// a debt can never show as paid off without the payment behind it.
  Future<int> addPayment({
    required int debtId,
    required int amountRial,
    DateTime? paidAt,
    int? accountId,
    String? note,
    bool recordTransaction = true,
  }) async {
    final when = paidAt ?? DateTime.now();

    return transaction(() async {
      final debt = await (select(debts)..where((d) => d.id.equals(debtId)))
          .getSingleOrNull();
      if (debt == null) {
        throw StateError('debt $debtId no longer exists');
      }

      int? transactionId;
      if (recordTransaction) {
        final iOwe = debt.direction == DebtDirection.iOwe;
        final category = await attachedDatabase.categoriesDao.findBySystemKey(
          iOwe
              ? SystemCategoryKeys.debtPayment
              : SystemCategoryKeys.creditReceived,
        );
        transactionId = await into(transactions).insert(
          buildTransactionCompanion(
            // Paying what I owe is money out; collecting what I'm owed is
            // money in.
            type: iOwe ? TxnType.withdrawal : TxnType.deposit,
            amountRial: amountRial,
            occurredAt: when,
            status: TxnStatus.confirmed,
            source: TxnSource.debtPayment,
            accountId: accountId,
            categoryId: category?.id,
            note: note?.isNotEmpty ?? false
                ? note
                : '${iOwe ? 'پرداخت به' : 'دریافت از'} ${debt.personName}',
            confirmedAt: when,
          ),
        );
      }

      final paymentId = await into(debtPayments).insert(
        DebtPaymentsCompanion.insert(
          debtId: debtId,
          amountRial: amountRial,
          paidAt: when,
          transactionId: Value(transactionId),
          note: Value(note?.isEmpty ?? true ? null : note),
        ),
      );

      await _syncStatus(debt, settledAt: when);
      return paymentId;
    });
  }

  /// Removes a payment along with the transaction it generated, and reopens
  /// the debt if that drops it back below its total.
  Future<void> deletePayment(int paymentId) {
    return transaction(() async {
      final payment = await (select(debtPayments)
            ..where((p) => p.id.equals(paymentId)))
          .getSingleOrNull();
      if (payment == null) return;

      final transactionId = payment.transactionId;
      if (transactionId != null) {
        await (delete(transactions)..where((t) => t.id.equals(transactionId)))
            .go();
      }
      await (delete(debtPayments)..where((p) => p.id.equals(paymentId))).go();

      final debt = await (select(debts)..where((d) => d.id.equals(payment.debtId)))
          .getSingleOrNull();
      if (debt != null) await _syncStatus(debt);
    });
  }

  /// Marks a debt settled (or open again) by hand — for the rounding-error
  /// case where the last few Rial will never be paid.
  Future<void> setSettled(int debtId, bool settled) {
    return (update(debts)..where((d) => d.id.equals(debtId))).write(
      DebtsCompanion(
        status: Value(settled ? DebtStatus.settled : DebtStatus.open),
        settledAt: Value(settled ? DateTime.now() : null),
      ),
    );
  }

  Future<int> paidAmount(int debtId) async {
    final sum = debtPayments.amountRial.sum();
    final query = selectOnly(debtPayments)
      ..addColumns([sum])
      ..where(debtPayments.debtId.equals(debtId));
    return await query.map((row) => row.read(sum)).getSingle() ?? 0;
  }

  /// Flips a debt's status when payments cross (or fall back under) its
  /// total. Writes nothing when the status is already right, so it doesn't
  /// churn the stream on every payment.
  Future<void> _syncStatus(Debt debt, {DateTime? settledAt}) async {
    final paid = await paidAmount(debt.id);
    final shouldBeSettled = paid >= debt.totalAmountRial;
    if (shouldBeSettled == (debt.status == DebtStatus.settled)) return;

    await (update(debts)..where((d) => d.id.equals(debt.id))).write(
      DebtsCompanion(
        status: Value(shouldBeSettled ? DebtStatus.settled : DebtStatus.open),
        settledAt:
            Value(shouldBeSettled ? (settledAt ?? DateTime.now()) : null),
      ),
    );
  }

  /// Emits once immediately and again whenever a debt or a payment changes.
  Stream<void> _debtChanges() =>
      customSelect('SELECT 1', readsFrom: {debts, debtPayments}).watch();

  Future<List<DebtWithProgress>> _withProgress(List<Debt> rows) async {
    final result = <DebtWithProgress>[];
    for (final debt in rows) {
      result.add(
          DebtWithProgress(debt: debt, paidRial: await paidAmount(debt.id)));
    }
    return result;
  }
}
