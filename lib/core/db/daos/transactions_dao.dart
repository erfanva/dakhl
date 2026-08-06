import 'package:drift/drift.dart';

import '../../persian/jalali_utils.dart';
import '../database.dart';

part 'transactions_dao.g.dart';

/// A transaction joined with its account and category for display —
/// almost every list/detail screen wants this instead of the raw row.
class TransactionWithRefs {
  const TransactionWithRefs({
    required this.transaction,
    this.account,
    this.category,
  });

  final Transaction transaction;
  final Account? account;
  final Category? category;
}

@DriftAccessor(tables: [Transactions, Accounts, Categories])
class TransactionsDao extends DatabaseAccessor<AppDatabase>
    with _$TransactionsDaoMixin {
  TransactionsDao(super.db);

  /// Reactive stream of transactions for [month] (or all time if null),
  /// optionally filtered by account/category/status, newest first.
  Stream<List<TransactionWithRefs>> watchTransactions({
    JalaliMonth? month,
    int? accountId,
    int? categoryId,
    TxnStatus? status,
  }) {
    final query = select(transactions).join([
      leftOuterJoin(accounts, accounts.id.equalsExp(transactions.accountId)),
      leftOuterJoin(
          categories, categories.id.equalsExp(transactions.categoryId)),
    ]);

    if (month != null) {
      query.where(transactions.jYear.equals(month.year) &
          transactions.jMonth.equals(month.month));
    }
    if (accountId != null) {
      query.where(transactions.accountId.equals(accountId));
    }
    if (categoryId != null) {
      query.where(transactions.categoryId.equals(categoryId));
    }
    if (status != null) {
      query.where(transactions.status.equalsValue(status));
    } else {
      query.where(transactions.status.equalsValue(TxnStatus.dismissed).not());
    }
    query.orderBy([OrderingTerm.desc(transactions.occurredAt)]);

    return query.watch().map((rows) => rows
        .map((row) => TransactionWithRefs(
              transaction: row.readTable(transactions),
              account: row.readTableOrNull(accounts),
              category: row.readTableOrNull(categories),
            ))
        .toList());
  }

  Stream<int> watchPendingCount() {
    final query = selectOnly(transactions)
      ..addColumns([transactions.id.count()])
      ..where(transactions.status.equalsValue(TxnStatus.pending));
    return query
        .map((row) => row.read(transactions.id.count()) ?? 0)
        .watchSingle();
  }

  Future<TransactionWithRefs?> findById(int id) async {
    final query = select(transactions).join([
      leftOuterJoin(accounts, accounts.id.equalsExp(transactions.accountId)),
      leftOuterJoin(
          categories, categories.id.equalsExp(transactions.categoryId)),
    ])
      ..where(transactions.id.equals(id));
    final row = await query.getSingleOrNull();
    if (row == null) return null;
    return TransactionWithRefs(
      transaction: row.readTable(transactions),
      account: row.readTableOrNull(accounts),
      category: row.readTableOrNull(categories),
    );
  }

  Future<int> insertTransaction(TransactionsCompanion entry) =>
      into(transactions).insert(entry);

  Future<bool> updateTransaction(Transaction entry) =>
      update(transactions).replace(entry);

  Future<int> deleteTransaction(int id) =>
      (delete(transactions)..where((t) => t.id.equals(id))).go();

  /// Confirms a pending row with the user's chosen category/note/amount.
  Future<void> confirmTransaction({
    required int id,
    required int categoryId,
    int? accountId,
    int? amountRial,
    String? note,
  }) {
    return (update(transactions)..where((t) => t.id.equals(id))).write(
      TransactionsCompanion(
        categoryId: Value(categoryId),
        accountId: Value.absentIfNull(accountId),
        amountRial: Value.absentIfNull(amountRial),
        note: Value.absentIfNull(note),
        status: const Value(TxnStatus.confirmed),
        confirmedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> dismissTransaction(int id) {
    return (update(transactions)..where((t) => t.id.equals(id))).write(
      const TransactionsCompanion(status: Value(TxnStatus.dismissed)),
    );
  }

  /// Sum of confirmed deposits minus withdrawals for [accountId], used to
  /// derive the account's current balance on top of its initial balance.
  Future<int> netConfirmedAmount(int accountId) async {
    final deposits = selectOnly(transactions)
      ..addColumns([transactions.amountRial.sum()])
      ..where(transactions.accountId.equals(accountId) &
          transactions.status.equalsValue(TxnStatus.confirmed) &
          transactions.type.equalsValue(TxnType.deposit));
    final withdrawals = selectOnly(transactions)
      ..addColumns([transactions.amountRial.sum()])
      ..where(transactions.accountId.equals(accountId) &
          transactions.status.equalsValue(TxnStatus.confirmed) &
          transactions.type.equalsValue(TxnType.withdrawal));

    final depositSum =
        (await deposits.getSingle()).read(transactions.amountRial.sum()) ?? 0;
    final withdrawalSum = (await withdrawals.getSingle())
            .read(transactions.amountRial.sum()) ??
        0;
    return depositSum - withdrawalSum;
  }

  /// Total income/expense for [month], for report screens.
  Future<({int incomeRial, int expenseRial})> monthTotals(JalaliMonth month) async {
    final income = selectOnly(transactions)
      ..addColumns([transactions.amountRial.sum()])
      ..where(transactions.jYear.equals(month.year) &
          transactions.jMonth.equals(month.month) &
          transactions.status.equalsValue(TxnStatus.confirmed) &
          transactions.type.equalsValue(TxnType.deposit));
    final expense = selectOnly(transactions)
      ..addColumns([transactions.amountRial.sum()])
      ..where(transactions.jYear.equals(month.year) &
          transactions.jMonth.equals(month.month) &
          transactions.status.equalsValue(TxnStatus.confirmed) &
          transactions.type.equalsValue(TxnType.withdrawal));

    final incomeRial =
        (await income.getSingle()).read(transactions.amountRial.sum()) ?? 0;
    final expenseRial =
        (await expense.getSingle()).read(transactions.amountRial.sum()) ?? 0;
    return (incomeRial: incomeRial, expenseRial: expenseRial);
  }
}
