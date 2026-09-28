import 'package:dakhl/core/db/database.dart';
import 'package:dakhl/core/notifications/reminder_scheduler.dart';
import 'package:dakhl/core/persian/jalali_utils.dart';
import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

/// Records what the scheduler asked the OS to do.
class _FakeSink implements ReminderSink {
  final scheduled = <({int id, DateTime fireAt, String title, String payload})>[];
  final cancelled = <int>[];

  @override
  Future<void> scheduleReminder({
    required int id,
    required DateTime fireAt,
    required String title,
    required String body,
    required String payload,
  }) async {
    scheduled.add((id: id, fireAt: fireAt, title: title, payload: payload));
  }

  @override
  Future<void> cancel(int id) async => cancelled.add(id);
}

void main() {
  late AppDatabase db;
  late _FakeSink sink;
  late ReminderScheduler scheduler;

  /// Fixed "now": the 10th of a Jalali month at noon, so a due date later in
  /// the same month is comfortably inside the horizon.
  final month = JalaliMonth.now();
  final now = JalaliUtils.dateForDayOfMonth(month, 10, hour: 12);

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    sink = _FakeSink();
    scheduler = ReminderScheduler(db: db, sink: sink, clock: () => now);
  });

  tearDown(() => db.close());

  Future<PlannedEntry> addExpense({int jDay = 20, int amountRial = 5000000}) async {
    final id = await db.recurringDao.insertItem(RecurringDraft(
      kind: OwnerKind.recurringExpense,
      title: 'اجاره خانه',
      amountRial: amountRial,
      jDay: jDay,
      start: month,
    ));
    await db.remindersDao
        .insertDefaultRule(OwnerKind.recurringExpense, id);
    await db.recurringDao.materialize(month);
    return (await db.recurringDao.readMonthPlan(month)).expenses.single;
  }

  Future<int> addDebt({DateTime? dueAt, int totalAmountRial = 20000000}) async {
    final id = await db.debtsDao.insertDebt(DebtsCompanion.insert(
      direction: DebtDirection.iOwe,
      personName: 'رضا',
      totalAmountRial: totalAmountRial,
      dueAt: Value(dueAt),
      status: DebtStatus.open,
      createdAt: now,
    ));
    await db.remindersDao.insertDefaultRule(OwnerKind.debt, id);
    return id;
  }

  group('planning', () {
    test('one reminder per rule, at daysBefore before the due date', () async {
      final entry = await addExpense(jDay: 20);
      await db.remindersDao.insertRule(
        ownerKind: OwnerKind.recurringExpense,
        ownerId: entry.item.id,
        daysBefore: 3,
        minutesOfDay: 8 * 60 + 30,
      );

      final planned = await scheduler.planReminders();
      expect(planned, hasLength(2), reason: 'the default rule plus this one');

      final dueMidnight = JalaliUtils.startOfDay(entry.dueAt);
      final fireTimes = planned.map((r) => r.fireAt).toList()..sort();
      expect(fireTimes.first,
          dueMidnight.subtract(const Duration(days: 3)).add(const Duration(hours: 8, minutes: 30)));
      expect(fireTimes.last, dueMidnight.add(const Duration(hours: 9)));
    });

    test('skips fire times that have already passed', () async {
      // Due on the 5th while "now" is the 10th.
      await addExpense(jDay: 5);
      expect(await scheduler.planReminders(), isEmpty);
    });

    test('skips settled and skipped occurrences', () async {
      final entry = await addExpense();
      expect(await scheduler.planReminders(), hasLength(1));

      await db.recurringDao.markDone(entry: entry);
      expect(await scheduler.planReminders(), isEmpty);
    });

    test('an item with no rules gets no reminders', () async {
      final id = await db.recurringDao.insertItem(RecurringDraft(
        kind: OwnerKind.recurringExpense,
        title: 'قبض برق',
        amountRial: 1000000,
        jDay: 20,
        start: month,
      ));
      await db.recurringDao.materialize(month);

      expect(await scheduler.planReminders(), isEmpty);
      expect(await db.remindersDao.readRules(ownerId: id), isEmpty);
    });

    test('dated open debts are included, undated ones are not', () async {
      await addDebt(dueAt: JalaliUtils.dateForDayOfMonth(month, 25));
      await addDebt(dueAt: null);

      final planned = await scheduler.planReminders();
      expect(planned, hasLength(1));
      expect(planned.single.ownerKind, OwnerKind.debt);
      expect(planned.single.payload, startsWith('debt:'));
    });

    test('a settled debt drops out', () async {
      final id = await addDebt(
          dueAt: JalaliUtils.dateForDayOfMonth(month, 25),
          totalAmountRial: 20000000);
      expect(await scheduler.planReminders(), hasLength(1));

      await db.debtsDao.addPayment(debtId: id, amountRial: 20000000);
      expect(await scheduler.planReminders(), isEmpty);
    });

    test('nothing is planned beyond the horizon', () async {
      await addDebt(
          dueAt: now.add(ReminderScheduler.horizon + const Duration(days: 1)));
      expect(await scheduler.planReminders(), isEmpty);
    });
  });

  group('sync', () {
    test('schedules what is missing and records it', () async {
      await addExpense();

      final result = await scheduler.sync();
      expect(result.scheduled, 1);
      expect(result.cancelled, 0);
      expect(sink.scheduled, hasLength(1));
      expect(sink.scheduled.single.id,
          greaterThanOrEqualTo(ReminderScheduler.idBase));
      expect(sink.scheduled.single.payload, startsWith('occurrence:'));
      expect(await db.remindersDao.readScheduled(), hasLength(1));
    });

    test('is idempotent: a second run touches nothing', () async {
      await addExpense();
      await scheduler.sync();
      sink.scheduled.clear();

      final again = await scheduler.sync();
      expect(again.scheduled, 0);
      expect(again.cancelled, 0);
      expect(sink.scheduled, isEmpty);
      expect(sink.cancelled, isEmpty);
      expect(await db.remindersDao.readScheduled(), hasLength(1));
    });

    test('cancels a pending reminder once its occurrence is settled', () async {
      final entry = await addExpense();
      await scheduler.sync();
      final scheduledId = sink.scheduled.single.id;

      await db.recurringDao.markDone(entry: entry);
      final result = await scheduler.sync();

      expect(result.cancelled, 1);
      expect(sink.cancelled, [scheduledId]);
      expect(await db.remindersDao.readScheduled(), isEmpty);
    });

    test('deleting the rule cancels its reminder', () async {
      final entry = await addExpense();
      await scheduler.sync();

      final rule = (await db.remindersDao.readRules(
        ownerKind: OwnerKind.recurringExpense,
        ownerId: entry.item.id,
      )).single;
      await db.remindersDao.deleteRule(rule.id);
      await scheduler.sync();

      expect(sink.cancelled, hasLength(1));
      expect(await db.remindersDao.readScheduled(), isEmpty);
    });

    test('moving the due date replaces the reminder', () async {
      final entry = await addExpense(jDay: 20);
      await scheduler.sync();
      final firstId = sink.scheduled.single.id;
      sink.scheduled.clear();

      await db.recurringDao.updateItem(
        entry.item.id,
        RecurringDraft(
          kind: OwnerKind.recurringExpense,
          title: 'اجاره خانه',
          amountRial: entry.item.amountRial,
          jDay: 25,
          start: month,
        ),
      );
      final result = await scheduler.sync();

      expect(result.cancelled, 1);
      expect(sink.cancelled, [firstId]);
      expect(result.scheduled, 1);
      expect(sink.scheduled.single.fireAt.isAfter(now), isTrue);
    });

    test('a reminder that already fired is forgotten, not cancelled',
        () async {
      final entry = await addExpense(jDay: 20);
      await scheduler.sync();
      final scheduled = await db.remindersDao.readScheduled();
      expect(scheduled, hasLength(1));

      // Same data, but "now" is a week past the fire time.
      final later = ReminderScheduler(
        db: db,
        sink: sink,
        clock: () => scheduled.single.fireAt.add(const Duration(days: 7)),
      );
      final result = await later.sync();

      expect(result.cancelled, 0,
          reason: 'cancelling would clear it out of the tray');
      expect(sink.cancelled, isEmpty);
      expect(await db.remindersDao.readScheduled(), isEmpty);
      // The occurrence itself is still due, but its reminder is in the past.
      expect((await db.recurringDao.readMonthPlan(month)).expenses.single.isDue,
          isTrue);
      expect(entry.item.title, 'اجاره خانه');
    });

    test('reminder ids never collide with transaction ids', () async {
      await addExpense();
      await scheduler.sync();

      final transactionId =
          await db.transactionsDao.insertTransaction(buildTransactionCompanion(
        type: TxnType.withdrawal,
        amountRial: 100000,
        occurredAt: now,
        status: TxnStatus.pending,
        source: TxnSource.sms,
      ));

      expect(sink.scheduled.single.id, isNot(transactionId));
      expect(sink.scheduled.single.id,
          greaterThan(ReminderScheduler.idBase - 1));
    });
  });

  group('rules', () {
    test('a duplicate rule returns the existing row instead of adding one',
        () async {
      final entry = await addExpense();
      final first = (await db.remindersDao.readRules(ownerId: entry.item.id))
          .single
          .id;

      final second = await db.remindersDao.insertRule(
        ownerKind: OwnerKind.recurringExpense,
        ownerId: entry.item.id,
        daysBefore: RemindersDao.defaultDaysBefore,
        minutesOfDay: RemindersDao.defaultMinutesOfDay,
      );

      expect(second, first);
      expect(await db.remindersDao.readRules(ownerId: entry.item.id),
          hasLength(1));
    });

    test('deleting a recurring item takes its rules with it', () async {
      final entry = await addExpense();
      await db.recurringDao.deleteItem(entry.item.kind, entry.item.id);

      expect(await db.remindersDao.readRules(ownerId: entry.item.id), isEmpty);
    });

    test('deleting a debt takes its rules with it', () async {
      final id = await addDebt(dueAt: now.add(const Duration(days: 5)));
      await db.debtsDao.deleteDebt(id);

      expect(
          await db.remindersDao
              .readRules(ownerKind: OwnerKind.debt, ownerId: id),
          isEmpty);
    });
  });
}
