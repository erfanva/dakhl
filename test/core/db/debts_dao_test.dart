import 'package:dakhl/core/db/database.dart';
import 'package:dakhl/core/db/seed_categories.dart';
import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late DebtsDao dao;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    dao = db.debtsDao;
  });

  tearDown(() => db.close());

  Future<int> addDebt({
    DebtDirection direction = DebtDirection.iOwe,
    String personName = 'رضا',
    int totalAmountRial = 10000000,
    DateTime? dueAt,
  }) {
    return dao.insertDebt(DebtsCompanion.insert(
      direction: direction,
      personName: personName,
      totalAmountRial: totalAmountRial,
      dueAt: Value(dueAt),
      status: DebtStatus.open,
      createdAt: DateTime.now(),
    ));
  }

  group('progress', () {
    test('a fresh debt owes the whole amount', () async {
      final id = await addDebt(totalAmountRial: 10000000);
      final entry = await dao.findDebt(id);

      expect(entry!.paidRial, 0);
      expect(entry.remainingRial, 10000000);
      expect(entry.progress, 0);
      expect(entry.isSettled, isFalse);
    });

    test('payments reduce the remainder', () async {
      final id = await addDebt(totalAmountRial: 10000000);
      await dao.addPayment(debtId: id, amountRial: 4000000);

      final entry = await dao.findDebt(id);
      expect(entry!.paidRial, 4000000);
      expect(entry.remainingRial, 6000000);
      expect(entry.progress, closeTo(0.4, 0.001));
      expect(entry.isSettled, isFalse);
    });

    test('paying in full settles the debt', () async {
      final id = await addDebt(totalAmountRial: 10000000);
      await dao.addPayment(debtId: id, amountRial: 10000000);

      final entry = await dao.findDebt(id);
      expect(entry!.isSettled, isTrue);
      expect(entry.debt.settledAt, isNotNull);
      expect(entry.remainingRial, 0);
    });

    test('overpaying settles rather than flipping the sign', () async {
      final id = await addDebt(totalAmountRial: 10000000);
      await dao.addPayment(debtId: id, amountRial: 12000000);

      final entry = await dao.findDebt(id);
      expect(entry!.remainingRial, 0);
      expect(entry.progress, 1);
      expect(entry.isSettled, isTrue);
    });

    test('an overdue debt is one with a passed due date and money left',
        () async {
      final yesterday = DateTime.now().subtract(const Duration(days: 1));
      final id = await addDebt(dueAt: yesterday);
      expect((await dao.findDebt(id))!.isOverdue(DateTime.now()), isTrue);

      await dao.addPayment(debtId: id, amountRial: 10000000);
      expect((await dao.findDebt(id))!.isOverdue(DateTime.now()), isFalse,
          reason: 'a settled debt is never overdue');
    });
  });

  group('payments and the ledger', () {
    test('paying what I owe writes a withdrawal against debt_payment',
        () async {
      final id = await addDebt(direction: DebtDirection.iOwe);
      await dao.addPayment(debtId: id, amountRial: 4000000);

      final payment = (await dao.watchPayments(id).first).single;
      expect(payment.transaction, isNotNull);
      expect(payment.transaction!.type, TxnType.withdrawal);
      expect(payment.transaction!.source, TxnSource.debtPayment);
      expect(payment.transaction!.amountRial, 4000000);
      expect(payment.transaction!.status, TxnStatus.confirmed);

      final category = await db.categoriesDao
          .findBySystemKey(SystemCategoryKeys.debtPayment);
      expect(payment.transaction!.categoryId, category!.id);
      expect(payment.transaction!.note, contains('رضا'));
    });

    test('collecting what I am owed writes a deposit against credit_received',
        () async {
      final id = await addDebt(direction: DebtDirection.owedToMe);
      await dao.addPayment(debtId: id, amountRial: 4000000);

      final payment = (await dao.watchPayments(id).first).single;
      expect(payment.transaction!.type, TxnType.deposit);

      final category = await db.categoriesDao
          .findBySystemKey(SystemCategoryKeys.creditReceived);
      expect(payment.transaction!.categoryId, category!.id);
    });

    test('recordTransaction: false leaves the ledger alone', () async {
      final id = await addDebt();
      await dao.addPayment(
          debtId: id, amountRial: 4000000, recordTransaction: false);

      final payment = (await dao.watchPayments(id).first).single;
      expect(payment.transaction, isNull);
      expect(payment.payment.amountRial, 4000000);
      expect(await db.transactionsDao.watchTransactions().first, isEmpty);
      expect((await dao.findDebt(id))!.paidRial, 4000000);
    });

    test('the payment lands on the chosen account', () async {
      final accountId = await db.accountsDao.insertAccount(
        AccountsCompanion.insert(name: 'کارت ملت', createdAt: DateTime.now()),
      );
      final id = await addDebt();
      await dao.addPayment(
          debtId: id, amountRial: 4000000, accountId: accountId);

      final payment = (await dao.watchPayments(id).first).single;
      expect(payment.transaction!.accountId, accountId);
    });

    test('deleting a payment removes its transaction and reopens the debt',
        () async {
      final id = await addDebt(totalAmountRial: 10000000);
      await dao.addPayment(debtId: id, amountRial: 10000000);
      expect((await dao.findDebt(id))!.isSettled, isTrue);

      final payment = (await dao.watchPayments(id).first).single;
      final txnId = payment.transaction!.id;
      await dao.deletePayment(payment.payment.id);

      final entry = await dao.findDebt(id);
      expect(entry!.paidRial, 0);
      expect(entry.isSettled, isFalse);
      expect(entry.debt.settledAt, isNull);
      expect(await db.transactionsDao.findById(txnId), isNull);
    });

    test('payments come back newest first', () async {
      final id = await addDebt(totalAmountRial: 30000000);
      final now = DateTime.now();
      await dao.addPayment(
          debtId: id,
          amountRial: 1000000,
          paidAt: now.subtract(const Duration(days: 2)));
      await dao.addPayment(debtId: id, amountRial: 2000000, paidAt: now);

      final payments = await dao.watchPayments(id).first;
      expect(payments.map((p) => p.payment.amountRial), [2000000, 1000000]);
    });
  });

  group('listing', () {
    test('splits by direction and hides settled rows on request', () async {
      await addDebt(direction: DebtDirection.iOwe, personName: 'رضا');
      final credit = await addDebt(
          direction: DebtDirection.owedToMe, personName: 'مینا');
      await dao.addPayment(debtId: credit, amountRial: 10000000);

      final owed = await dao.readDebts(direction: DebtDirection.iOwe);
      expect(owed.map((d) => d.debt.personName), ['رضا']);

      final open = await dao.readDebts(includeSettled: false);
      expect(open.map((d) => d.debt.personName), ['رضا']);

      final all = await dao.readDebts();
      expect(all, hasLength(2));
      expect(all.first.isSettled, isFalse,
          reason: 'open debts sort before settled ones');
    });

    test('totals count only what is still outstanding', () async {
      final owed = await addDebt(
          direction: DebtDirection.iOwe, totalAmountRial: 10000000);
      await dao.addPayment(debtId: owed, amountRial: 4000000);
      await addDebt(
          direction: DebtDirection.owedToMe, totalAmountRial: 25000000);

      final totals = await dao.watchTotals().first;
      expect(totals.iOweRial, 6000000);
      expect(totals.owedToMeRial, 25000000);
      expect(totals.netRial, 19000000);
    });

    test('a settled debt drops out of the totals', () async {
      final id = await addDebt(totalAmountRial: 10000000);
      await dao.addPayment(debtId: id, amountRial: 10000000);

      final totals = await dao.watchTotals().first;
      expect(totals.iOweRial, 0);
    });
  });

  group('manual settle', () {
    test('marks a partially paid debt as done', () async {
      final id = await addDebt(totalAmountRial: 10000000);
      await dao.addPayment(debtId: id, amountRial: 9999000);

      await dao.setSettled(id, true);
      expect((await dao.findDebt(id))!.isSettled, isTrue);

      await dao.setSettled(id, false);
      final entry = await dao.findDebt(id);
      expect(entry!.isSettled, isFalse);
      expect(entry.debt.settledAt, isNull);
    });
  });

  group('delete', () {
    test('takes the payment rows with it and leaves the ledger', () async {
      final id = await addDebt();
      await dao.addPayment(debtId: id, amountRial: 4000000);
      final txnId =
          (await dao.watchPayments(id).first).single.transaction!.id;

      await dao.deleteDebt(id);

      expect(await dao.findDebt(id), isNull);
      expect(await dao.watchPayments(id).first, isEmpty);
      expect(await db.transactionsDao.findById(txnId), isNotNull,
          reason: 'the money really did move');
    });
  });

  group('streams', () {
    test('a partial payment moves the list even though the debt row is '
        'untouched', () async {
      final id = await addDebt(totalAmountRial: 10000000);

      final updated = dao
          .watchDebts()
          .firstWhere((rows) => rows.single.paidRial == 4000000);
      await dao.addPayment(debtId: id, amountRial: 4000000);

      expect((await updated).single.remainingRial, 6000000);
    });
  });
}
