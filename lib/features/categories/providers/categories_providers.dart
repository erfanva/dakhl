import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/db/database.dart';
import '../../../core/db/providers.dart';

/// All categories, optionally restricted to a [CategoryKind] (categories
/// marked `both` always match).
final categoriesProvider =
    StreamProvider.autoDispose.family<List<Category>, CategoryKind?>(
  (ref, kind) => ref.watch(categoriesDaoProvider).watchCategories(kind: kind),
);

/// A single category, kept live so detail pages follow renames and
/// icon/colour edits without a manual refresh.
final categoryByIdProvider =
    StreamProvider.autoDispose.family<Category?, int>((ref, id) {
  return ref
      .watch(categoriesDaoProvider)
      .watchCategories()
      .map((categories) => categories.where((c) => c.id == id).firstOrNull);
});
