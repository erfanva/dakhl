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

  /// Reactive [monthTotals], for report screens that should follow edits.
  Stream<MonthTotals> watchMonthTotals(JalaliMonth month) {
    // Any write to `transactions` invalidates the aggregate, so drive the
    // recompute off the table itself rather than a hand-rolled join.
    return _tableChanges().asyncMap((_) async {
      final totals = await monthTotals(month);
      return MonthTotals(
        month: month,
        incomeRial: totals.incomeRial,
        expenseRial: totals.expenseRial,
      );
    });
  }

  /// Income and expense per month across [months], oldest first — the
  /// trend chart's data source.
  Stream<List<MonthTotals>> watchMonthlyTotals(List<JalaliMonth> months) {
    return _tableChanges().asyncMap((_) async {
      final result = <MonthTotals>[];
      for (final month in months) {
        final totals = await monthTotals(month);
        result.add(MonthTotals(
          month: month,
          incomeRial: totals.incomeRial,
          expenseRial: totals.expenseRial,
        ));
      }
      return result;
    });
  }

  /// Confirmed totals per category for [month] and [type], largest first.
  /// Uncategorized rows collapse into a single entry with a null category.
  Stream<List<CategoryTotal>> watchCategoryTotals({
    required JalaliMonth month,
    required TxnType type,
  }) {
    final sum = transactions.amountRial.sum();
    // Aggregate over transactions alone, then attach the Category rows in
    // Dart: a joined table can't be read back off a grouped `selectOnly`
    // result, since the group key rather than the join drives the row.
    final query = selectOnly(transactions)
      ..addColumns([sum, transactions.categoryId])
      ..where(transactions.jYear.equals(month.year) &
          transactions.jMonth.equals(month.month) &
          transactions.status.equalsValue(TxnStatus.confirmed) &
          transactions.type.equalsValue(type))
      ..groupBy([transactions.categoryId])
      ..orderBy([OrderingTerm.desc(sum)]);

    return query.watch().asyncMap((rows) async {
      final byId = {
        for (final category in await select(categories).get())
          category.id: category,
      };
      return rows
          .map((row) {
            final categoryId = row.read(transactions.categoryId);
            return CategoryTotal(
              category: categoryId == null ? null : byId[categoryId],
              totalRial: row.read(sum) ?? 0,
            );
          })
          .where((entry) => entry.totalRial > 0)
          .toList();
    });
  }

  /// Emits once immediately and again on every write to `transactions`.
  Stream<void> _tableChanges() {
    final query = selectOnly(transactions)
      ..addColumns([transactions.id.count()]);
    return query.watch();
  }
}

/// Income/expense totals for one Jalali month.
class MonthTotals {
  const MonthTotals({
    required this.month,
    required this.incomeRial,
    required this.expenseRial,
  });

  final JalaliMonth month;
  final int incomeRial;
  final int expenseRial;

  int get netRial => incomeRial - expenseRial;
}

/// One slice of the category breakdown. [category] is null for
/// transactions that were never categorized.
class CategoryTotal {
  const CategoryTotal({required this.category, required this.totalRial});

  final Category? category;
  final int totalRial;
}
