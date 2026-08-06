import 'package:flutter_riverpod/flutter_riverpod.dart';

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
