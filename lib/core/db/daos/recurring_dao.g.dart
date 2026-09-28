// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recurring_dao.dart';

// ignore_for_file: type=lint
mixin _$RecurringDaoMixin on DatabaseAccessor<AppDatabase> {
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
  $ReminderRulesTable get reminderRules => attachedDatabase.reminderRules;
  RecurringDaoManager get managers => RecurringDaoManager(this);
}

class RecurringDaoManager {
  final _$RecurringDaoMixin _db;
  RecurringDaoManager(this._db);
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
  $$ReminderRulesTableTableManager get reminderRules =>
      $$ReminderRulesTableTableManager(_db.attachedDatabase, _db.reminderRules);
}
