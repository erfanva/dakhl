import 'package:drift/drift.dart';

import '../database.dart';

part 'categories_dao.g.dart';

@DriftAccessor(tables: [Categories])
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

  Future<int> insertCategory(CategoriesCompanion entry) =>
      into(categories).insert(entry);

  Future<bool> updateCategory(Category entry) =>
      update(categories).replace(entry);

  /// System categories cannot be deleted; callers should check
  /// [Category.isSystem] before offering this.
  Future<int> deleteCategory(int id) =>
      (delete(categories)..where((c) => c.id.equals(id) & c.isSystem.equals(false)))
          .go();
}
