import 'package:drift/drift.dart';

import '../database.dart';

part 'reminders_dao.g.dart';

@DriftAccessor(tables: [
  ReminderRules,
  ScheduledNotifications,
  RecurringIncomes,
  RecurringExpenses,
  RecurringOccurrences,
  Debts,
  DebtPayments,
])
class RemindersDao extends DatabaseAccessor<AppDatabase>
    with _$RemindersDaoMixin {
  RemindersDao(super.db);

  /// What a new recurring item or dated debt gets unless the user changes it:
  /// a reminder on the due date at 9am.
  ///
  /// Having no rules means "don't remind me", so the default has to be a real
  /// row rather than an implicit fallback — otherwise there'd be no way to
  /// turn reminders off.
  static const defaultDaysBefore = 0;
  static const defaultMinutesOfDay = 9 * 60;

  Stream<List<ReminderRule>> watchRules(OwnerKind ownerKind, int ownerId) {
    return (select(reminderRules)
          ..where((r) =>
              r.ownerKind.equalsValue(ownerKind) & r.ownerId.equals(ownerId))
          ..orderBy([
            (r) => OrderingTerm.desc(r.daysBefore),
            (r) => OrderingTerm.asc(r.minutesOfDay),
          ]))
        .watch();
  }

  Future<List<ReminderRule>> readRules({OwnerKind? ownerKind, int? ownerId}) {
    final query = select(reminderRules);
    if (ownerKind != null) {
      query.where((r) => r.ownerKind.equalsValue(ownerKind));
    }
    if (ownerId != null) {
      query.where((r) => r.ownerId.equals(ownerId));
    }
    return query.get();
  }

  /// Adds a rule, or returns the existing one's id if this owner already has
  /// the same reminder — a duplicate would simply fire twice.
  Future<int> insertRule({
    required OwnerKind ownerKind,
    required int ownerId,
    required int daysBefore,
    required int minutesOfDay,
  }) async {
    final duplicate = await (select(reminderRules)
          ..where((r) =>
              r.ownerKind.equalsValue(ownerKind) &
              r.ownerId.equals(ownerId) &
              r.daysBefore.equals(daysBefore) &
              r.minutesOfDay.equals(minutesOfDay)))
        .getSingleOrNull();
    if (duplicate != null) return duplicate.id;

    return into(reminderRules).insert(
      ReminderRulesCompanion.insert(
        ownerKind: ownerKind,
        ownerId: ownerId,
        daysBefore: daysBefore,
        minutesOfDay: Value(minutesOfDay),
      ),
    );
  }

  Future<int> insertDefaultRule(OwnerKind ownerKind, int ownerId) =>
      insertRule(
        ownerKind: ownerKind,
        ownerId: ownerId,
        daysBefore: defaultDaysBefore,
        minutesOfDay: defaultMinutesOfDay,
      );

  Future<int> deleteRule(int id) =>
      (delete(reminderRules)..where((r) => r.id.equals(id))).go();

  /// Drops every rule for an owner — called when the owner itself goes away.
  Future<int> deleteRulesFor(OwnerKind ownerKind, int ownerId) {
    return (delete(reminderRules)
          ..where((r) =>
              r.ownerKind.equalsValue(ownerKind) & r.ownerId.equals(ownerId)))
        .go();
  }

  Future<List<ScheduledNotification>> readScheduled() =>
      select(scheduledNotifications).get();

  Future<int> insertScheduled(ScheduledNotificationsCompanion entry) =>
      into(scheduledNotifications).insert(entry);

  Future<int> deleteScheduled(int id) =>
      (delete(scheduledNotifications)..where((s) => s.id.equals(id))).go();

  /// Emits once immediately and again whenever anything a reminder is derived
  /// from changes, so the scheduler can re-run its diff.
  Stream<void> watchInputs() => customSelect(
        'SELECT 1',
        readsFrom: {
          reminderRules,
          recurringIncomes,
          recurringExpenses,
          recurringOccurrences,
          debts,
          debtPayments,
        },
      ).watch();
}
