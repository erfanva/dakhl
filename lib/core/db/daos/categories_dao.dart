import 'package:drift/drift.dart';

import '../database.dart';

part 'categories_dao.g.dart';

@DriftAccessor(tables: [Categories, Transactions])
class CategoriesDao extends DatabaseAccessor<AppDatabase>
    with _$CategoriesDaoMixin {
  CategoriesDao(super.db);

  Stream<List<Category>> watchCategories({CategoryKind? kind}) {
    final query = select(categories)
      ..orderBy([(c) => OrderingTerm.asc(c.sortOrder)]);
    if (kind != null) {
      query.where((c) => c.kind.equalsValue(kind) | c.kind.equalsValue(CategoryKind.both));
    }
    return query.watch();
  }

  Future<Category?> findBySystemKey(String systemKey) {
    return (select(categories)..where((c) => c.systemKey.equals(systemKey)))
        .getSingleOrNull();
  }

  Future<Category?> findById(int id) =>
      (select(categories)..where((c) => c.id.equals(id))).getSingleOrNull();

  Future<int> insertCategory(CategoriesCompanion entry) =>
      into(categories).insert(entry);

  Future<bool> updateCategory(Category entry) =>
      update(categories).replace(entry);

  /// System categories cannot be deleted; callers should check
  /// [Category.isSystem] before offering this.
  ///
  /// Transactions referencing the category are not removed — the foreign key
  /// is `ON DELETE SET NULL`, so they fall back to being uncategorized.
  Future<int> deleteCategory(int id) =>
      (delete(categories)..where((c) => c.id.equals(id) & c.isSystem.equals(false)))
          .go();

  /// How many transactions point at this category. Used to warn before a
  /// delete, since those rows become uncategorized.
  Future<int> transactionCount(int categoryId) async {
    final count = transactions.id.count();
    final query = selectOnly(transactions)
      ..addColumns([count])
      ..where(transactions.categoryId.equals(categoryId));
    return await query.map((row) => row.read(count)).getSingle() ?? 0;
  }

  /// Sort order that places a new category after every existing one.
  Future<int> nextSortOrder() async {
    final maxOrder = categories.sortOrder.max();
    final query = selectOnly(categories)..addColumns([maxOrder]);
    final current = await query.map((row) => row.read(maxOrder)).getSingle();
    return (current ?? -1) + 1;
  }

  /// Persists a drag-reordered list by rewriting sortOrder in one batch.
  Future<void> applyOrder(List<int> orderedIds) {
    return batch((b) {
      for (var i = 0; i < orderedIds.length; i++) {
        b.update(
          categories,
          CategoriesCompanion(sortOrder: Value(i)),
          where: (c) => c.id.equals(orderedIds[i]),
        );
      }
    });
  }
}
