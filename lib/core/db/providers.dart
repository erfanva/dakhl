import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../notifications/notification_service.dart';
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

/// The UI isolate's notification plugin instance. The background SMS
/// isolate creates its own — plugin state isn't shared across isolates.
final notificationServiceProvider =
    Provider<NotificationService>((ref) => NotificationService());
