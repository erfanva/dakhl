// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'debts_dao.dart';

// ignore_for_file: type=lint
mixin _$DebtsDaoMixin on DatabaseAccessor<AppDatabase> {
  $DebtsTable get debts => attachedDatabase.debts;
  $AccountsTable get accounts => attachedDatabase.accounts;
  $CategoriesTable get categories => attachedDatabase.categories;
  $RawSmsTable get rawSms => attachedDatabase.rawSms;
  $TransactionsTable get transactions => attachedDatabase.transactions;
  $DebtPaymentsTable get debtPayments => attachedDatabase.debtPayments;
  DebtsDaoManager get managers => DebtsDaoManager(this);
}

class DebtsDaoManager {
  final _$DebtsDaoMixin _db;
  DebtsDaoManager(this._db);
  $$DebtsTableTableManager get debts =>
      $$DebtsTableTableManager(_db.attachedDatabase, _db.debts);
  $$AccountsTableTableManager get accounts =>
      $$AccountsTableTableManager(_db.attachedDatabase, _db.accounts);
  $$CategoriesTableTableManager get categories =>
      $$CategoriesTableTableManager(_db.attachedDatabase, _db.categories);
  $$RawSmsTableTableManager get rawSms =>
      $$RawSmsTableTableManager(_db.attachedDatabase, _db.rawSms);
  $$TransactionsTableTableManager get transactions =>
      $$TransactionsTableTableManager(_db.attachedDatabase, _db.transactions);
  $$DebtPaymentsTableTableManager get debtPayments =>
      $$DebtPaymentsTableTableManager(_db.attachedDatabase, _db.debtPayments);
}
