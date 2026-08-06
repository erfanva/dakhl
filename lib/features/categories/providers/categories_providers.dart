import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/db/database.dart';
import '../../../core/db/providers.dart';

/// All categories, optionally restricted to a [CategoryKind] (categories
/// marked `both` always match).
final categoriesProvider =
    StreamProvider.autoDispose.family<List<Category>, CategoryKind?>(
  (ref, kind) => ref.watch(categoriesDaoProvider).watchCategories(kind: kind),
);
