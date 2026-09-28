import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../notifications/notification_service.dart';
import '../notifications/reminder_scheduler.dart';
import 'database.dart';

/// The single app-wide database instance. Overridden in tests with an
/// in-memory database.
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final transactionsDaoProvider = Provider<TransactionsDao>(
  (ref) => ref.watch(appDatabaseProvider).transactionsDao,
);

final accountsDaoProvider = Provider<AccountsDao>(
  (ref) => ref.watch(appDatabaseProvider).accountsDao,
);

final categoriesDaoProvider = Provider<CategoriesDao>(
  (ref) => ref.watch(appDatabaseProvider).categoriesDao,
);

final recurringDaoProvider = Provider<RecurringDao>(
  (ref) => ref.watch(appDatabaseProvider).recurringDao,
);

final debtsDaoProvider = Provider<DebtsDao>(
  (ref) => ref.watch(appDatabaseProvider).debtsDao,
);

final remindersDaoProvider = Provider<RemindersDao>(
  (ref) => ref.watch(appDatabaseProvider).remindersDao,
);

/// The UI isolate's notification plugin instance. The background SMS
/// isolate creates its own — plugin state isn't shared across isolates.
final notificationServiceProvider =
    Provider<NotificationService>((ref) => NotificationService());

final reminderSchedulerProvider = Provider<ReminderScheduler>((ref) {
  return ReminderScheduler(
    db: ref.watch(appDatabaseProvider),
    sink: ref.watch(notificationServiceProvider),
  );
});

/// Re-runs the scheduler's diff whenever anything a reminder depends on
/// changes — a new fixed expense, a settled occurrence, a paid-off debt.
///
/// Something has to keep watching this for it to work, so the app widget
/// holds it for the whole session.
final reminderSyncProvider = StreamProvider<void>((ref) {
  final scheduler = ref.watch(reminderSchedulerProvider);
  return ref
      .watch(remindersDaoProvider)
      .watchInputs()
      .asyncMap((_) => scheduler.sync());
});
