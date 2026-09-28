import 'package:dakhl/core/db/database.dart';
import 'package:dakhl/core/persian/jalali_utils.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shamsi_date/shamsi_date.dart';

void main() {
  late AppDatabase db;
  late RecurringDao dao;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    dao = db.recurringDao;
  });

  tearDown(() => db.close());

  const month = JalaliMonth(1405, 5);

  RecurringDraft draft({
    OwnerKind kind = OwnerKind.recurringExpense,
    String title = 'اجاره خانه',
    int amountRial = 50000000,
    int jDay = 5,
    JalaliMonth start = month,
    JalaliMonth? end,
    int? categoryId,
    int? accountId,
  }) {
    return RecurringDraft(
      kind: kind,
      title: title,
      amountRial: amountRial,
      jDay: jDay,
      start: start,
      end: end,
      categoryId: categoryId,
      accountId: accountId,
    );
  }

  group('items', () {
    test('insert lands in the table matching the kind', () async {
      await dao.insertItem(draft(title: 'قبض برق'));
      await dao.insertItem(
          draft(kind: OwnerKind.recurringIncome, title: 'حقوق'));

      final expenses =
          await dao.readItems(kind: OwnerKind.recurringExpense);
      final incomes = await dao.readItems(kind: OwnerKind.recurringIncome);

      expect(expenses.map((i) => i.title), ['قبض برق']);
      expect(incomes.map((i) => i.title), ['حقوق']);
      expect(incomes.single.txnType, TxnType.deposit);
      expect(expenses.single.txnType, TxnType.withdrawal);
    });

    test('reads both kinds together, ordered by day of month', () async {
      await dao.insertItem(draft(title: 'اجاره', jDay: 20));
      await dao.insertItem(
          draft(kind: OwnerKind.recurringIncome, title: 'حقوق', jDay: 1));

      final items = await dao.readItems();
      expect(items.map((i) => i.title), ['حقوق', 'اجاره']);
    });

    test('inactive items are hidden unless asked for', () async {
      final id = await dao.insertItem(draft());
      await dao.setActive(OwnerKind.recurringExpense, id, false);

      expect(await dao.readItems(), isEmpty);
      expect(await dao.readItems(includeInactive: true), hasLength(1));
    });

    test('editing keeps createdAt and applies the new values', () async {
      final id = await dao.insertItem(draft());
      final before = await dao.findItem(OwnerKind.recurringExpense, id);

      await dao.updateItem(
          id, draft(title: 'اجاره جدید', amountRial: 60000000));

      final after = await dao.findItem(OwnerKind.recurringExpense, id);
      expect(after!.title, 'اجاره جدید');
      expect(after.amountRial, 60000000);
      expect(after.createdAt, before!.createdAt);
    });

    test('deleting an item removes its occurrences too', () async {
      final id = await dao.insertItem(draft());
      await dao.materialize(month);
      expect((await dao.readMonthPlan(month)).expenses, hasLength(1));

      await dao.deleteItem(OwnerKind.recurringExpense, id);

      expect(await dao.readItems(includeInactive: true), isEmpty);
      expect((await dao.readMonthPlan(month)).isEmpty, isTrue);
    });
  });

  group('coversMonth', () {
    test('excludes months before the start', () async {
      await dao.insertItem(draft(start: month));
      final item = (await dao.readItems()).single;

      expect(item.coversMonth(month - 1), isFalse);
      expect(item.coversMonth(month), isTrue);
      expect(item.coversMonth(month + 12), isTrue);
    });

    test('an end month is inclusive', () async {
      await dao.insertItem(draft(start: month, end: month + 2));
      final item = (await dao.readItems()).single;

      expect(item.coversMonth(month + 2), isTrue);
      expect(item.coversMonth(month + 3), isFalse);
    });
  });

  group('materialize', () {
    test('creates one due occurrence per covering item', () async {
      await dao.insertItem(draft(title: 'اجاره'));
      await dao.insertItem(
          draft(kind: OwnerKind.recurringIncome, title: 'حقوق'));

      expect(await dao.materialize(month), 2);

      final plan = await dao.readMonthPlan(month);
      expect(plan.expenses.single.item.title, 'اجاره');
      expect(plan.incomes.single.item.title, 'حقوق');
      expect(plan.expenses.single.status, OccurrenceStatus.due);
    });

    test('is a no-op on a second run', () async {
      await dao.insertItem(draft());

      expect(await dao.materialize(month), 1);
      expect(await dao.materialize(month), 0);
      expect((await dao.readMonthPlan(month)).expenses, hasLength(1));
    });

    test('skips inactive items and months outside the range', () async {
      final id = await dao.insertItem(draft(start: month, end: month));
      expect(await dao.materialize(month + 1), 0);

      await dao.setActive(OwnerKind.recurringExpense, id, false);
      expect(await dao.materialize(month), 0);
    });

    test('clamps the day of month to the month length', () async {
      // Esfand is 29 days in a common year, 30 in a leap year.
      await dao.insertItem(draft(jDay: 31, start: const JalaliMonth(1405, 12)));
      await dao.materialize(const JalaliMonth(1405, 12));

      final entry =
          (await dao.readMonthPlan(const JalaliMonth(1405, 12))).expenses.single;
      final due = Jalali.fromDateTime(entry.dueAt);
      expect(due.month, 12);
      expect(due.day, const JalaliMonth(1405, 12).lengthInDays);
    });
  });

  group('settling an occurrence', () {
    Future<PlannedEntry> onlyExpense() async =>
        (await dao.readMonthPlan(month)).expenses.single;

    setUp(() async {
      await dao.insertItem(draft(amountRial: 50000000));
      await dao.materialize(month);
    });

    test('writes a confirmed transaction and links it back', () async {
      final entry = await onlyExpense();
      final txnId = await dao.markDone(entry: entry);

      final settled = await onlyExpense();
      expect(settled.status, OccurrenceStatus.done);
      expect(settled.occurrence.transactionId, txnId);
      expect(settled.occurrence.resolvedAt, isNotNull);

      final txn = await db.transactionsDao.findById(txnId);
      expect(txn!.transaction.status, TxnStatus.confirmed);
      expect(txn.transaction.source, TxnSource.recurring);
      expect(txn.transaction.type, TxnType.withdrawal);
      expect(txn.transaction.amountRial, 50000000);
      expect(txn.transaction.note, 'اجاره خانه');
    });

    test('a different amount is recorded as this month\'s override', () async {
      await dao.markDone(entry: await onlyExpense(), amountRial: 55000000);

      final settled = await onlyExpense();
      expect(settled.occurrence.amountOverrideRial, 55000000);
      expect(settled.amountRial, 55000000);
      expect(settled.item.amountRial, 50000000, reason: 'the item is unchanged');
    });

    test('the default amount leaves no override behind', () async {
      await dao.markDone(entry: await onlyExpense(), amountRial: 50000000);
      expect((await onlyExpense()).occurrence.amountOverrideRial, isNull);
    });

    test('reopening deletes the transaction it generated', () async {
      final txnId = await dao.markDone(entry: await onlyExpense());
      await dao.reopen((await onlyExpense()).occurrence.id);

      final reopened = await onlyExpense();
      expect(reopened.status, OccurrenceStatus.due);
      expect(reopened.occurrence.transactionId, isNull);
      expect(reopened.occurrence.resolvedAt, isNull);
      expect(await db.transactionsDao.findById(txnId), isNull,
          reason: 'leaving it behind would double-count the month');
    });

    test('skipping writes no transaction', () async {
      await dao.skip((await onlyExpense()).occurrence.id);

      expect((await onlyExpense()).status, OccurrenceStatus.skipped);
      expect(await db.transactionsDao.watchTransactions().first, isEmpty);
    });
  });

  group('month plan totals', () {
    setUp(() async {
      await dao.insertItem(draft(
          kind: OwnerKind.recurringIncome, title: 'حقوق', amountRial: 900000000));
      await dao.insertItem(draft(title: 'اجاره', amountRial: 500000000));
      await dao.insertItem(draft(title: 'شهریه', amountRial: 100000000));
      await dao.materialize(month);
    });

    test('planned totals cover every unsettled and settled row', () async {
      final plan = await dao.readMonthPlan(month);

      expect(plan.plannedIncomeRial, 900000000);
      expect(plan.plannedExpenseRial, 600000000);
      expect(plan.plannedNetRial, 300000000);
      expect(plan.outstandingExpenseRial, 600000000);
      expect(plan.settledExpenseRial, 0);
    });

    test('settling moves an amount from outstanding to settled', () async {
      final plan = await dao.readMonthPlan(month);
      final rent = plan.expenses.firstWhere((e) => e.item.title == 'اجاره');
      await dao.markDone(entry: rent);

      final updated = await dao.readMonthPlan(month);
      expect(updated.settledExpenseRial, 500000000);
      expect(updated.outstandingExpenseRial, 100000000);
      expect(updated.plannedExpenseRial, 600000000);
      expect(updated.actualExpenseRial, 500000000,
          reason: 'the generated transaction shows up in the ledger');
    });

    test('a skipped row drops out of the plan entirely', () async {
      final plan = await dao.readMonthPlan(month);
      final tuition = plan.expenses.firstWhere((e) => e.item.title == 'شهریه');
      await dao.skip(tuition.occurrence.id);

      final updated = await dao.readMonthPlan(month);
      expect(updated.plannedExpenseRial, 500000000);
      expect(updated.outstandingExpenseRial, 500000000);
    });

    test('an inactive item keeps the occurrences it already produced',
        () async {
      final rent = (await dao.readItems())
          .firstWhere((item) => item.title == 'اجاره');
      await dao.setActive(rent.kind, rent.id, false);

      final plan = await dao.readMonthPlan(month);
      expect(plan.expenses.map((e) => e.item.title), contains('اجاره'));
    });
  });

  group('due dates', () {
    test('changing the day of month moves unsettled occurrences', () async {
      final id = await dao.insertItem(draft(jDay: 5));
      await dao.materialize(month);
      await dao.materialize(month + 1);

      await dao.updateItem(id, draft(jDay: 20));

      for (final target in [month, month + 1]) {
        final entry = (await dao.readMonthPlan(target)).expenses.single;
        expect(Jalali.fromDateTime(entry.dueAt).day, 20);
      }
    });

    test('a settled occurrence keeps the date the money moved', () async {
      final id = await dao.insertItem(draft(jDay: 5));
      await dao.materialize(month);
      final entry = (await dao.readMonthPlan(month)).expenses.single;
      final paidAt = JalaliUtils.dateForDayOfMonth(month, 7);
      await dao.markDone(entry: entry, paidAt: paidAt);

      await dao.updateItem(id, draft(jDay: 20));

      final settled = (await dao.readMonthPlan(month)).expenses.single;
      expect(Jalali.fromDateTime(settled.dueAt).day, 5);
    });
  });

  group('outstanding', () {
    test('spans months and stops at the given bound', () async {
      await dao.insertItem(draft(jDay: 10, start: month));
      await dao.materialize(month);
      await dao.materialize(month + 1);

      final untilThisMonth = await dao.readOutstanding(
          until: JalaliUtils.dateForDayOfMonth(month, 28));
      expect(untilThisMonth, hasLength(1));

      final all = await dao.readOutstanding();
      expect(all, hasLength(2));
      expect(all.first.dueAt.isBefore(all.last.dueAt), isTrue,
          reason: 'oldest first');
    });

    test('settled and skipped rows drop out', () async {
      await dao.insertItem(draft());
      await dao.materialize(month);
      final entry = (await dao.readMonthPlan(month)).expenses.single;

      await dao.markDone(entry: entry);
      expect(await dao.readOutstanding(), isEmpty);
    });
  });

  group('watchMonthPlan', () {
    test('materializes the month it is watching', () async {
      await dao.insertItem(draft());

      final plan = await dao
          .watchMonthPlan(month)
          .firstWhere((plan) => plan.expenses.isNotEmpty);

      expect(plan.expenses.single.item.title, 'اجاره خانه');
    });
  });
}
