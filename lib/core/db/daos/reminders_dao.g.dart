// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminders_dao.dart';

// ignore_for_file: type=lint
mixin _$RemindersDaoMixin on DatabaseAccessor<AppDatabase> {
  $ReminderRulesTable get reminderRules => attachedDatabase.reminderRules;
  $ScheduledNotificationsTable get scheduledNotifications =>
      attachedDatabase.scheduledNotifications;
  $CategoriesTable get categories => attachedDatabase.categories;
  $AccountsTable get accounts => attachedDatabase.accounts;
  $RecurringIncomesTable get recurringIncomes =>
      attachedDatabase.recurringIncomes;
  $RecurringExpensesTable get recurringExpenses =>
      attachedDatabase.recurringExpenses;
  $RawSmsTable get rawSms => attachedDatabase.rawSms;
  $TransactionsTable get transactions => attachedDatabase.transactions;
  $RecurringOccurrencesTable get recurringOccurrences =>
      attachedDatabase.recurringOccurrences;
  $DebtsTable get debts => attachedDatabase.debts;
  $DebtPaymentsTable get debtPayments => attachedDatabase.debtPayments;
  RemindersDaoManager get managers => RemindersDaoManager(this);
}

class RemindersDaoManager {
  final _$RemindersDaoMixin _db;
  RemindersDaoManager(this._db);
  $$ReminderRulesTableTableManager get reminderRules =>
      $$ReminderRulesTableTableManager(_db.attachedDatabase, _db.reminderRules);
  $$ScheduledNotificationsTableTableManager get scheduledNotifications =>
      $$ScheduledNotificationsTableTableManager(
        _db.attachedDatabase,
        _db.scheduledNotifications,
      );
  $$CategoriesTableTableManager get categories =>
      $$CategoriesTableTableManager(_db.attachedDatabase, _db.categories);
  $$AccountsTableTableManager get accounts =>
      $$AccountsTableTableManager(_db.attachedDatabase, _db.accounts);
  $$RecurringIncomesTableTableManager get recurringIncomes =>
      $$RecurringIncomesTableTableManager(
        _db.attachedDatabase,
        _db.recurringIncomes,
      );
  $$RecurringExpensesTableTableManager get recurringExpenses =>
      $$RecurringExpensesTableTableManager(
        _db.attachedDatabase,
        _db.recurringExpenses,
      );
  $$RawSmsTableTableManager get rawSms =>
      $$RawSmsTableTableManager(_db.attachedDatabase, _db.rawSms);
  $$TransactionsTableTableManager get transactions =>
      $$TransactionsTableTableManager(_db.attachedDatabase, _db.transactions);
  $$RecurringOccurrencesTableTableManager get recurringOccurrences =>
      $$RecurringOccurrencesTableTableManager(
        _db.attachedDatabase,
        _db.recurringOccurrences,
      );
  $$DebtsTableTableManager get debts =>
      $$DebtsTableTableManager(_db.attachedDatabase, _db.debts);
  $$DebtPaymentsTableTableManager get debtPayments =>
      $$DebtPaymentsTableTableManager(_db.attachedDatabase, _db.debtPayments);
}
