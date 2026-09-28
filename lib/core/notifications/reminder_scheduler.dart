import 'package:drift/drift.dart' show Value;

import '../db/database.dart';
import '../money/money.dart';
import '../persian/digits.dart';
import '../persian/jalali_utils.dart';
import 'payloads.dart';

/// What the scheduler needs from the notification layer.
///
/// Narrow on purpose: the diffing below is the part worth testing, and a test
/// can stand in for this without a plugin or a platform channel.
abstract interface class ReminderSink {
  Future<void> scheduleReminder({
    required int id,
    required DateTime fireAt,
    required String title,
    required String body,
    required String payload,
  });

  Future<void> cancel(int id);
}

/// A reminder the database says should exist, before it has an id.
class PlannedReminder {
  const PlannedReminder({
    required this.ownerKind,
    required this.ownerId,
    required this.ruleId,
    required this.fireAt,
    required this.payload,
    required this.title,
    required this.body,
    this.occurrenceId,
  });

  final OwnerKind ownerKind;
  final int ownerId;
  final int? occurrenceId;
  final int ruleId;
  final DateTime fireAt;
  final String payload;
  final String title;
  final String body;

  /// Identity for diffing against what is already scheduled. Everything in
  /// the key is stored on `scheduled_notifications`, so an existing row can
  /// produce the same key without knowing the notification text.
  String get key => '${ownerKind.name}/$ownerId/$occurrenceId/$ruleId/'
      '${fireAt.millisecondsSinceEpoch}';
}

/// Keeps the OS's pending notifications in step with the database.
///
/// [sync] is a diff, not a rebuild: notifications that should still fire are
/// left alone, so running it on every launch and after every edit is cheap
/// and doesn't reset alarms the user is already waiting on.
class ReminderScheduler {
  ReminderScheduler({
    required this.db,
    required this.sink,
    this.clock = DateTime.now,
  });

  final AppDatabase db;
  final ReminderSink sink;

  /// Injectable so tests can pin "now" instead of racing the wall clock.
  final DateTime Function() clock;

  /// How far ahead reminders are handed to the OS. Android caps how many
  /// alarms an app may hold, and anything further out gets scheduled on a
  /// later launch anyway.
  static const horizon = Duration(days: 62);

  /// Reminder notification ids start here, because pending-transaction alerts
  /// use the transaction's own id and the two must not collide.
  static const idBase = 1000000;

  /// Returns how many reminders were scheduled and cancelled.
  Future<({int scheduled, int cancelled})> sync() async {
    final now = clock();
    final wanted = {
      for (final reminder in await planReminders()) reminder.key: reminder,
    };
    final existing = await db.remindersDao.readScheduled();

    var cancelled = 0;
    for (final row in existing) {
      final key = '${row.ownerKind.name}/${row.ownerId}/${row.occurrenceId}/'
          '${row.ruleId}/${row.fireAt.millisecondsSinceEpoch}';
      if (wanted.remove(key) != null) continue;

      // A row whose time has passed has already fired. Cancelling it would
      // clear the notification out of the tray the user is looking at, so
      // just forget the bookkeeping.
      if (row.fireAt.isAfter(now)) {
        await sink.cancel(idBase + row.id);
        cancelled++;
      }
      await db.remindersDao.deleteScheduled(row.id);
    }

    var scheduled = 0;
    for (final reminder in wanted.values) {
      final rowId = await db.remindersDao.insertScheduled(
        ScheduledNotificationsCompanion.insert(
          ownerKind: reminder.ownerKind,
          ownerId: reminder.ownerId,
          occurrenceId: Value(reminder.occurrenceId),
          ruleId: Value(reminder.ruleId),
          fireAt: reminder.fireAt,
          payload: reminder.payload,
        ),
      );
      await sink.scheduleReminder(
        id: idBase + rowId,
        fireAt: reminder.fireAt,
        title: reminder.title,
        body: reminder.body,
        payload: reminder.payload,
      );
      scheduled++;
    }

    return (scheduled: scheduled, cancelled: cancelled);
  }

  /// Every reminder that should be pending right now: one per (unsettled
  /// thing with a due date) × (reminder rule), skipping fire times that have
  /// already gone by.
  Future<List<PlannedReminder>> planReminders() async {
    final now = clock();
    final until = now.add(horizon);
    return [
      ...await _recurringReminders(now, until),
      ...await _debtReminders(now, until),
    ];
  }

  Future<List<PlannedReminder>> _recurringReminders(
      DateTime now, DateTime until) async {
    final entries = await db.recurringDao.readOutstanding(until: until);
    final reminders = <PlannedReminder>[];

    for (final entry in entries) {
      final rules = await db.remindersDao.readRules(
        ownerKind: entry.item.kind,
        ownerId: entry.item.id,
      );
      for (final rule in rules) {
        final fireAt = _fireTime(entry.dueAt, rule);
        if (!fireAt.isAfter(now)) continue;
        reminders.add(PlannedReminder(
          ownerKind: entry.item.kind,
          ownerId: entry.item.id,
          occurrenceId: entry.occurrence.id,
          ruleId: rule.id,
          fireAt: fireAt,
          payload: OccurrencePayload(entry.occurrence.id).encode(),
          title: _lead(rule.daysBefore, entry.item.title),
          body: '${Money.format(entry.amountRial)} · '
              '${JalaliUtils.formatDate(entry.dueAt)}',
        ));
      }
    }
    return reminders;
  }

  Future<List<PlannedReminder>> _debtReminders(
      DateTime now, DateTime until) async {
    final open = await db.debtsDao.readDebts(includeSettled: false);
    final reminders = <PlannedReminder>[];

    for (final entry in open) {
      final dueAt = entry.debt.dueAt;
      if (dueAt == null || dueAt.isAfter(until)) continue;

      final rules = await db.remindersDao
          .readRules(ownerKind: OwnerKind.debt, ownerId: entry.debt.id);
      for (final rule in rules) {
        final fireAt = _fireTime(dueAt, rule);
        if (!fireAt.isAfter(now)) continue;
        final who = entry.debt.personName;
        reminders.add(PlannedReminder(
          ownerKind: OwnerKind.debt,
          ownerId: entry.debt.id,
          ruleId: rule.id,
          fireAt: fireAt,
          payload: DebtPayload(entry.debt.id).encode(),
          title: _lead(
            rule.daysBefore,
            entry.iOwe ? 'پرداخت به $who' : 'دریافت از $who',
          ),
          body: '${Money.format(entry.remainingRial)} · '
              '${JalaliUtils.formatDate(dueAt)}',
        ));
      }
    }
    return reminders;
  }

  /// [daysBefore] days before the due date, at the rule's time of day.
  ///
  /// Built off the due date's midnight so the offset is in whole days
  /// regardless of what time of day the due date itself carries.
  static DateTime _fireTime(DateTime dueAt, ReminderRule rule) {
    final midnight = JalaliUtils.startOfDay(dueAt);
    return midnight
        .subtract(Duration(days: rule.daysBefore))
        .add(Duration(minutes: rule.minutesOfDay));
  }

  static String _lead(int daysBefore, String what) {
    if (daysBefore == 0) return 'امروز موعد $what است';
    if (daysBefore == 1) return 'فردا موعد $what است';
    return '${toPersianDigits('$daysBefore')} روز تا موعد $what';
  }
}
