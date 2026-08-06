import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/db/database.dart';
import '../../../core/db/providers.dart';
import '../category_style.dart';
import '../providers/categories_providers.dart';
import 'category_form_sheet.dart';

/// Categories management: add, edit, delete, and reorder.
class CategoriesPage extends ConsumerWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncCategories = ref.watch(categoriesProvider(null));

    return Scaffold(
      appBar: AppBar(title: const Text('دسته‌بندی‌ها')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showCategoryFormSheet(context),
        icon: const Icon(Icons.add),
        label: const Text('دسته جدید'),
      ),
      body: asyncCategories.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('خطا در بارگذاری: $e')),
        data: (categories) {
          if (categories.isEmpty) {
            return const Center(child: Text('هنوز دسته‌بندی‌ای نساخته‌ای'));
          }
          // System categories stay pinned below the user's own, and are not
          // draggable — reordering only rewrites the editable ones.
          final own = categories.where((c) => !c.isSystem).toList();
          final system = categories.where((c) => c.isSystem).toList();

          return ListView(
            padding: const EdgeInsets.only(bottom: 88),
            children: [
              if (own.isNotEmpty) ...[
                const _SectionHeader('دسته‌های من'),
                ReorderableListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  buildDefaultDragHandles: false,
                  // onReorderItem already accounts for the removed item, so
                  // newIndex needs no manual adjustment.
                  onReorderItem: (oldIndex, newIndex) {
                    final reordered = [...own];
                    reordered.insert(newIndex, reordered.removeAt(oldIndex));
                    ref
                        .read(categoriesDaoProvider)
                        .applyOrder(reordered.map((c) => c.id).toList());
                  },
                  children: [
                    for (var i = 0; i < own.length; i++)
                      _CategoryTile(
                        key: ValueKey(own[i].id),
                        category: own[i],
                        dragIndex: i,
                      ),
                  ],
                ),
              ],
              if (system.isNotEmpty) ...[
                const _SectionHeader('دسته‌های سیستمی'),
                const Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
                  child: Text(
                    'این دسته‌ها را خود اپ استفاده می‌کند و حذف نمی‌شوند؛ '
                    'فقط رنگ و آیکونشان قابل تغییر است.',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                for (final category in system)
                  _CategoryTile(
                    key: ValueKey(category.id),
                    category: category,
                  ),
              ],
            ],
          );
        },
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
    );
  }
}

class _CategoryTile extends ConsumerWidget {
  const _CategoryTile({super.key, required this.category, this.dragIndex});

  final Category category;

  /// Non-null for reorderable (user-owned) rows.
  final int? dragIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = category.color(context);
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color.withValues(alpha: 0.18),
        child: Icon(category.icon, color: color),
      ),
      title: Text(category.name),
      subtitle: Text(categoryKindLabel(category.kind)),
      // Tap opens the month's activity; the edit action is on the sheet
      // reachable from the detail page's app bar.
      onTap: () => context.go('/more/categories/${category.id}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            tooltip: 'ویرایش',
            onPressed: () =>
                showCategoryFormSheet(context, existing: category),
          ),
          if (!category.isSystem)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              tooltip: 'حذف',
              onPressed: () => _confirmDelete(context, ref),
            ),
          if (dragIndex != null)
            ReorderableDragStartListener(
              index: dragIndex!,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Icon(Icons.drag_handle),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _confirmDelete(BuildContext context, WidgetRef ref) async {
    final dao = ref.read(categoriesDaoProvider);
    final usage = await dao.transactionCount(category.id);
    if (!context.mounted) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('حذف «${category.name}»؟'),
        content: Text(
          usage == 0
              ? 'هیچ تراکنشی از این دسته استفاده نکرده است.'
              : 'این دسته در $usage تراکنش استفاده شده. با حذف آن، '
                  'آن تراکنش‌ها بدون دسته‌بندی می‌شوند (حذف نمی‌شوند).',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('انصراف'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('حذف'),
          ),
        ],
      ),
    );

    if (confirmed ?? false) {
      await dao.deleteCategory(category.id);
    }
  }
}
