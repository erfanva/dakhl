import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/db/database.dart';
import '../../../core/db/providers.dart';
import '../category_style.dart';

/// Opens the add/edit category sheet. Pass [existing] to edit.
///
/// Returns the category id on save (useful when creating one inline from the
/// transaction form), or null if the user backed out.
Future<int?> showCategoryFormSheet(
  BuildContext context, {
  Category? existing,
  CategoryKind? initialKind,
}) {
  return showModalBottomSheet<int>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (context) => _CategoryFormSheet(
      existing: existing,
      initialKind: initialKind,
    ),
  );
}

class _CategoryFormSheet extends ConsumerStatefulWidget {
  const _CategoryFormSheet({this.existing, this.initialKind});

  final Category? existing;
  final CategoryKind? initialKind;

  @override
  ConsumerState<_CategoryFormSheet> createState() => _CategoryFormSheetState();
}

class _CategoryFormSheetState extends ConsumerState<_CategoryFormSheet> {
  final _nameController = TextEditingController();
  late CategoryKind _kind;
  late IconData _icon;
  late Color _color;
  bool _saving = false;

  Category? get existing => widget.existing;

  /// System categories are referenced by code (debt payments, adjustments),
  /// so their name and kind stay fixed; only the look is editable.
  bool get _isSystem => existing?.isSystem ?? false;

  @override
  void initState() {
    super.initState();
    _kind = existing?.kind ?? widget.initialKind ?? CategoryKind.expense;
    _icon = categoryIconFor(existing?.iconCode);
    _color = existing?.colorValue != null
        ? Color(existing!.colorValue!)
        : categoryColors.first;
    _nameController.text = existing?.name ?? '';
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 8,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.close),
                  tooltip: 'بستن',
                  onPressed: () => Navigator.of(context).pop(),
                ),
                Expanded(
                  child: Text(
                    existing == null ? 'دسته‌بندی جدید' : 'ویرایش دسته‌بندی',
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
                // Balances the close button so the title stays centered.
                const SizedBox(width: 48),
              ],
            ),
            const SizedBox(height: 8),
            _Preview(icon: _icon, color: _color, name: _nameController.text),
            const SizedBox(height: 16),
            TextField(
              controller: _nameController,
              autofocus: existing == null,
              enabled: !_isSystem,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                labelText: 'اسم دسته‌بندی',
                helperText:
                    _isSystem ? 'اسم دسته‌های سیستمی قابل تغییر نیست' : null,
              ),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 16),
            if (!_isSystem) ...[
              Text('نوع', style: Theme.of(context).textTheme.labelLarge),
              const SizedBox(height: 8),
              SegmentedButton<CategoryKind>(
                segments: [
                  for (final kind in CategoryKind.values)
                    ButtonSegment(
                      value: kind,
                      label: Text(categoryKindLabel(kind)),
                    ),
                ],
                selected: {_kind},
                onSelectionChanged: (s) => setState(() => _kind = s.first),
              ),
              const SizedBox(height: 16),
            ],
            Text('رنگ', style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 8),
            _ColorPicker(
              value: _color,
              onChanged: (c) => setState(() => _color = c),
            ),
            const SizedBox(height: 16),
            Text('آیکون', style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 8),
            _IconPicker(
              value: _icon,
              color: _color,
              onChanged: (i) => setState(() => _icon = i),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _saving ? null : _save,
              child: Text(existing == null ? 'ثبت' : 'ذخیره تغییرات'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _save() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('اسم دسته‌بندی را وارد کن')),
      );
      return;
    }

    setState(() => _saving = true);
    final dao = ref.read(categoriesDaoProvider);
    int id;

    if (existing == null) {
      id = await dao.insertCategory(
        CategoriesCompanion.insert(
          name: name,
          kind: _kind,
          iconCode: Value(_icon.codePoint),
          colorValue: Value(_color.toARGB32()),
          sortOrder: Value(await dao.nextSortOrder()),
          createdAt: DateTime.now(),
        ),
      );
    } else {
      id = existing!.id;
      await dao.updateCategory(
        existing!.copyWith(
          name: name,
          kind: _kind,
          iconCode: Value(_icon.codePoint),
          colorValue: Value(_color.toARGB32()),
        ),
      );
    }

    if (mounted) Navigator.of(context).pop(id);
  }
}

class _Preview extends StatelessWidget {
  const _Preview({required this.icon, required this.color, required this.name});

  final IconData icon;
  final Color color;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: color.withValues(alpha: 0.18),
            child: Icon(icon, color: color, size: 32),
          ),
          const SizedBox(height: 8),
          Text(
            name.trim().isEmpty ? 'بدون اسم' : name.trim(),
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}

class _ColorPicker extends StatelessWidget {
  const _ColorPicker({required this.value, required this.onChanged});

  final Color value;
  final ValueChanged<Color> onChanged;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        for (final color in categoryColors)
          GestureDetector(
            onTap: () => onChanged(color),
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                border: color.toARGB32() == value.toARGB32()
                    ? Border.all(
                        color: Theme.of(context).colorScheme.onSurface,
                        width: 3,
                      )
                    : null,
              ),
              child: color.toARGB32() == value.toARGB32()
                  ? const Icon(Icons.check, color: Colors.white, size: 20)
                  : null,
            ),
          ),
      ],
    );
  }
}

class _IconPicker extends StatelessWidget {
  const _IconPicker({
    required this.value,
    required this.color,
    required this.onChanged,
  });

  final IconData value;
  final Color color;
  final ValueChanged<IconData> onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 56,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        itemCount: categoryIcons.length,
        itemBuilder: (context, index) {
          final icon = categoryIcons[index];
          final selected = icon.codePoint == value.codePoint;
          return InkWell(
            onTap: () => onChanged(icon),
            borderRadius: BorderRadius.circular(12),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: selected ? color.withValues(alpha: 0.18) : null,
                border: selected ? Border.all(color: color, width: 2) : null,
              ),
              child: Icon(
                icon,
                color: selected ? color : Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          );
        },
      ),
    );
  }
}
