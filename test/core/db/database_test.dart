import 'package:dakhl/core/db/database.dart';
import 'package:dakhl/core/db/seed_categories.dart';
import 'package:dakhl/core/persian/jalali_utils.dart';
// `show Value` avoids drift's isNull/isNotNull column helpers colliding with
// the matchers of the same name.
import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
  });

  tearDown(() => db.close());

  group('seeding', () {
    test('creates system categories with stable keys', () async {
      final uncategorized = await db.categoriesDao
          .findBySystemKey(SystemCategoryKeys.uncategorized);
      final debtPayment =
          await db.categoriesDao.findBySystemKey(SystemCategoryKeys.debtPayment);

      expect(uncategorized, isNotNull);
      expect(uncategorized!.isSystem, isTrue);
      expect(debtPayment, isNotNull);
      expect(debtPayment!.name, 'پرداخت بدهی');
    });

    test('creates editable default categories', () async {
      final expenses =
          await db.categoriesDao.watchCategories(kind: CategoryKind.expense).first;
      final everyday = expenses.where((c) => !c.isSystem).toList();

      expect(everyday, isNotEmpty);
      expect(everyday.map((c) => c.name), contains('خوراک'));
    });

    test('income filter includes income and both-kind categories', () async {
      final income =
          await db.categoriesDao.watchCategories(kind: CategoryKind.income).first;

      expect(income.map((c) => c.name), contains('حقوق'));
      expect(income.every((c) => c.kind != CategoryKind.expense), isTrue);
    });
  });

  group('category CRUD', () {
    Future<int> addCategory(String name, {CategoryKind? kind}) async {
      return db.categoriesDao.insertCategory(
        CategoriesCompanion.insert(
          name: name,
          kind: kind ?? CategoryKind.expense,
          sortOrder: Value(await db.categoriesDao.nextSortOrder()),
          createdAt: DateTime.now(),
        ),
      );
    }

    test('inserts a user category that shows up in the stream', () async {
      await addCategory('سفر');
      final expenses = await db.categoriesDao
          .watchCategories(kind: CategoryKind.expense)
          .first;
      expect(expenses.map((c) => c.name), contains('سفر'));
    });

    test('nextSortOrder places new categories last', () async {
      final firstOrder = await db.categoriesDao.nextSortOrder();
      await addCategory('سفر');
      expect(await db.categoriesDao.nextSortOrder(), firstOrder + 1);
    });

    test('renames and re-kinds an existing category', () async {
      final id = await addCategory('سفر');
      final category = await db.categoriesDao.findById(id);

      await db.categoriesDao.updateCategory(
        category!.copyWith(name: 'سفر و تفریح', kind: CategoryKind.both),
      );

      final updated = await db.categoriesDao.findById(id);
      expect(updated!.name, 'سفر و تفریح');
      expect(updated.kind, CategoryKind.both);
    });

    test('deletes a user category', () async {
      final id = await addCategory('سفر');
      expect(await db.categoriesDao.deleteCategory(id), 1);
      expect(await db.categoriesDao.findById(id), isNull);
    });

    test('refuses to delete a system category', () async {
      final system = await db.categoriesDao
          .findBySystemKey(SystemCategoryKeys.debtPayment);

      expect(await db.categoriesDao.deleteCategory(system!.id), 0);
      expect(await db.categoriesDao.findById(system.id), isNotNull);
    });

    test('deleting a category leaves its transactions uncategorized',
        () async {
      final id = await addCategory('سفر');
      final txnId =
          await db.transactionsDao.insertTransaction(buildTransactionCompanion(
        type: TxnType.withdrawal,
        amountRial: 100000,
        occurredAt: DateTime.now(),
        status: TxnStatus.confirmed,
        source: TxnSource.manual,
        categoryId: id,
      ));

      expect(await db.categoriesDao.transactionCount(id), 1);
      await db.categoriesDao.deleteCategory(id);

      final row = await db.transactionsDao.findById(txnId);
      expect(row, isNotNull, reason: 'the transaction must survive');
      expect(row!.transaction.categoryId, isNull);
      expect(row.category, isNull);
    });

    test('transactionCount is zero for an unused category', () async {
      final id = await addCategory('سفر');
      expect(await db.categoriesDao.transactionCount(id), 0);
    });

    test('applyOrder rewrites sortOrder to match the given sequence',
        () async {
      final a = await addCategory('الف');
      final b = await addCategory('ب');
      final c = await addCategory('ج');

      await db.categoriesDao.applyOrder([c, a, b]);

      expect((await db.categoriesDao.findById(c))!.sortOrder, 0);
      expect((await db.categoriesDao.findById(a))!.sortOrder, 1);
      expect((await db.categoriesDao.findById(b))!.sortOrder, 2);
    });
  });

  group('buildTransactionCompanion', () {
    test('derives the Jalali month columns from occurredAt', () async {
      final occurredAt = const JalaliMonth(1405, 5).start;
      final id = await db.transactionsDao.insertTransaction(
        buildTransactionCompanion(
          type: TxnType.withdrawal,
          amountRial: 250000,
          occurredAt: occurredAt,
          status: TxnStatus.confirmed,
          source: TxnSource.manual,
        ),
      );

      final row = await db.transactionsDao.findById(id);
      expect(row!.transaction.jYear, 1405);
      expect(row.transaction.jMonth, 5);
    });
  });

  group('account balances', () {
    late int accountId;

    setUp(() async {
      accountId = await db.accountsDao.insertAccount(
        AccountsCompanion.insert(
          name: 'بانک ملت',
          initialBalanceRial: const Value(1000000),
          createdAt: DateTime.now(),
        ),
      );
    });

    Future<void> addTxn(TxnType type, int amountRial, TxnStatus status) {
      return db.transactionsDao.insertTransaction(
        buildTransactionCompanion(
          type: type,
          amountRial: amountRial,
          occurredAt: DateTime.now(),
          status: status,
          source: TxnSource.manual,
          accountId: accountId,
        ),
      );
    }

    test('starts at the initial balance', () async {
      final balances = await db.accountsDao.watchAccountsWithBalances().first;
      expect(balances.single.balanceRial, 1000000);
    });

    test('adds deposits and subtracts withdrawals', () async {
      await addTxn(TxnType.deposit, 500000, TxnStatus.confirmed);
      await addTxn(TxnType.withdrawal, 200000, TxnStatus.confirmed);

      final balances = await db.accountsDao.watchAccountsWithBalances().first;
      expect(balances.single.balanceRial, 1300000);
    });

    test('ignores pending and dismissed transactions', () async {
      await addTxn(TxnType.deposit, 900000, TxnStatus.pending);
      await addTxn(TxnType.deposit, 700000, TxnStatus.dismissed);

      final balances = await db.accountsDao.watchAccountsWithBalances().first;
      expect(balances.single.balanceRial, 1000000);
    });

    test('matches an account by SMS suffix', () async {
      await db.accountsDao.insertAccount(
        AccountsCompanion.insert(
          name: 'کارت سامان',
          accountNoSuffix: const Value('4321'),
          createdAt: DateTime.now(),
        ),
      );

      final matched = await db.accountsDao.findBySuffix('6219861012344321');
      expect(matched?.name, 'کارت سامان');
      expect(await db.accountsDao.findBySuffix('6219861012340000'), isNull);
    });
  });

  group('transaction queries', () {
    test('filters by month', () async {
      const target = JalaliMonth(1405, 5);
      await db.transactionsDao.insertTransaction(buildTransactionCompanion(
        type: TxnType.withdrawal,
        amountRial: 100000,
        occurredAt: target.start,
        status: TxnStatus.confirmed,
        source: TxnSource.manual,
      ));
      await db.transactionsDao.insertTransaction(buildTransactionCompanion(
        type: TxnType.withdrawal,
        amountRial: 200000,
        occurredAt: (target + 1).start,
        status: TxnStatus.confirmed,
        source: TxnSource.manual,
      ));

      final rows =
          await db.transactionsDao.watchTransactions(month: target).first;
      expect(rows, hasLength(1));
      expect(rows.single.transaction.amountRial, 100000);
    });

    test('hides dismissed rows unless explicitly requested', () async {
      await db.transactionsDao.insertTransaction(buildTransactionCompanion(
        type: TxnType.withdrawal,
        amountRial: 100000,
        occurredAt: DateTime.now(),
        status: TxnStatus.dismissed,
        source: TxnSource.sms,
      ));

      expect(await db.transactionsDao.watchTransactions().first, isEmpty);
      expect(
        await db.transactionsDao
            .watchTransactions(status: TxnStatus.dismissed)
            .first,
        hasLength(1),
      );
    });

    test('counts pending rows', () async {
      await db.transactionsDao.insertTransaction(buildTransactionCompanion(
        type: TxnType.deposit,
        amountRial: 100000,
        occurredAt: DateTime.now(),
        status: TxnStatus.pending,
        source: TxnSource.sms,
      ));

      expect(await db.transactionsDao.watchPendingCount().first, 1);
    });

    test('confirming a pending row sets category and timestamp', () async {
      final id =
          await db.transactionsDao.insertTransaction(buildTransactionCompanion(
        type: TxnType.withdrawal,
        amountRial: 250000,
        occurredAt: DateTime.now(),
        status: TxnStatus.pending,
        source: TxnSource.sms,
      ));
      final category = await db.categoriesDao
          .findBySystemKey(SystemCategoryKeys.debtPayment);

      await db.transactionsDao.confirmTransaction(
        id: id,
        categoryId: category!.id,
        note: 'قسط وام',
      );

      final row = await db.transactionsDao.findById(id);
      expect(row!.transaction.status, TxnStatus.confirmed);
      expect(row.transaction.confirmedAt, isNotNull);
      expect(row.category?.name, 'پرداخت بدهی');
      expect(row.transaction.note, 'قسط وام');
    });

    test('monthTotals sums income and expense separately', () async {
      const month = JalaliMonth(1405, 5);
      await db.transactionsDao.insertTransaction(buildTransactionCompanion(
        type: TxnType.deposit,
        amountRial: 900000,
        occurredAt: month.start,
        status: TxnStatus.confirmed,
        source: TxnSource.manual,
      ));
      await db.transactionsDao.insertTransaction(buildTransactionCompanion(
        type: TxnType.withdrawal,
        amountRial: 350000,
        occurredAt: month.start,
        status: TxnStatus.confirmed,
        source: TxnSource.manual,
      ));

      final totals = await db.transactionsDao.monthTotals(month);
      expect(totals.incomeRial, 900000);
      expect(totals.expenseRial, 350000);
    });
  });
}
