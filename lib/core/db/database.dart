import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import '../persian/jalali_utils.dart';
import 'daos/accounts_dao.dart';
import 'daos/categories_dao.dart';
import 'daos/debts_dao.dart';
import 'daos/recurring_dao.dart';
import 'daos/reminders_dao.dart';
import 'daos/sms_patterns_dao.dart';
import 'daos/transactions_dao.dart';
import '../sms/parser/seed_patterns.dart';
import 'seed_categories.dart';
import 'tables.dart';

export 'daos/accounts_dao.dart';
export 'daos/categories_dao.dart';
export 'daos/debts_dao.dart';
export 'daos/recurring_dao.dart';
export 'daos/reminders_dao.dart';
export 'daos/sms_patterns_dao.dart';
export 'daos/transactions_dao.dart';
export 'tables.dart';

part 'database.g.dart';

/// The app database.
///
/// Opened both from the UI isolate and from the background SMS isolate, so
/// the connection uses WAL (drift_flutter's default) and every write goes
/// through short transactions.
@DriftDatabase(
  tables: [
    Accounts,
    Categories,
    Transactions,
    RawSms,
    SmsPatterns,
    RecurringIncomes,
    RecurringExpenses,
    RecurringOccurrences,
    ReminderRules,
    ScheduledNotifications,
    Debts,
    DebtPayments,
    Budgets,
    Wishes,
    WishLinks,
    WishImages,
  ],
  daos: [
    TransactionsDao,
    AccountsDao,
    CategoriesDao,
    SmsPatternsDao,
    RecurringDao,
    DebtsDao,
    RemindersDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.forTesting(super.connection);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          await _createIndexes();
          await seedSystemCategories(this);
          await seedSmsPatterns(this);
        },
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON');
          // Re-run on every open so an app update that adds a bank reaches
          // existing installs. Banks the user already has are left alone,
          // including any edits they made.
          await seedSmsPatterns(this);
        },
      );

  Future<void> _createIndexes() async {
    await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_txn_status ON transactions (status)');
    await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_txn_month ON transactions (j_year, j_month)');
    await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_txn_account ON transactions (account_id)');
    await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_txn_category ON transactions (category_id)');
    await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_txn_occurred ON transactions (occurred_at)');
    await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_occurrence_owner ON recurring_occurrences (owner_kind, owner_id)');
    await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_debt_payment_debt ON debt_payments (debt_id)');
  }

  static QueryExecutor _openConnection() =>
      driftDatabase(name: 'dakhl', native: const DriftNativeOptions());
}

/// Convenience for building a transaction companion with the Jalali
/// month columns derived from [occurredAt] — every insert path needs it.
TransactionsCompanion buildTransactionCompanion({
  required TxnType type,
  required int amountRial,
  required DateTime occurredAt,
  required TxnStatus status,
  required TxnSource source,
  int? accountId,
  int? categoryId,
  String? note,
  int? rawSmsId,
  int? balanceAfterRial,
  DateTime? confirmedAt,
  DateTime? createdAt,
}) {
  final month = JalaliMonth.fromDateTime(occurredAt);
  return TransactionsCompanion.insert(
    type: type,
    amountRial: amountRial,
    occurredAt: occurredAt,
    jYear: month.year,
    jMonth: month.month,
    status: status,
    source: source,
    accountId: Value.absentIfNull(accountId),
    categoryId: Value.absentIfNull(categoryId),
    note: Value.absentIfNull(note),
    rawSmsId: Value.absentIfNull(rawSmsId),
    balanceAfterRial: Value.absentIfNull(balanceAfterRial),
    confirmedAt: Value.absentIfNull(confirmedAt),
    createdAt: createdAt ?? DateTime.now(),
  );
}
