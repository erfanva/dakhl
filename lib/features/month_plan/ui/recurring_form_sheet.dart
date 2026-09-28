import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/db/database.dart';
import '../../../core/db/providers.dart';
import '../../../core/money/amount_input_formatter.dart';
import '../../../core/money/money.dart';
import '../../../core/persian/digits.dart';
import '../../../core/persian/jalali_utils.dart';
import '../../accounts/providers/accounts_providers.dart';
import '../../categories/category_style.dart';
import '../../categories/providers/categories_providers.dart';
import '../../categories/ui/category_form_sheet.dart';

/// Opens the add/edit sheet for a recurring income or expense.
///
/// Pass [existing] to edit. [initialKind] picks the direction for a new item;
/// on an edit the direction is fixed, since the two live in different tables.
Future<void> showRecurringFormSheet(
  BuildContext context, {
  RecurringItem? existing,
  OwnerKind initialKind = OwnerKind.recurringExpense,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (context) => _RecurringFormSheet(
      existing: existing,
      initialKind: existing?.kind ?? initialKind,
    ),
  );
}

class _RecurringFormSheet extends ConsumerStatefulWidget {
  const _RecurringFormSheet({required this.initialKind, this.existing});

  final RecurringItem? existing;
  final OwnerKind initialKind;

  @override
  ConsumerState<_RecurringFormSheet> createState() =>
      _RecurringFormSheetState();
}

class _RecurringFormSheetState extends ConsumerState<_RecurringFormSheet> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();

  late OwnerKind _kind;
  late JalaliMonth _start;
  late int _jDay;
  JalaliMonth? _end;
  int? _categoryId;
  int? _accountId;
  bool _isActive = true;
  bool _saving = false;

  RecurringItem? get existing => widget.existing;

  @override
  void initState() {
    super.initState();
    final item = existing;
    _kind = widget.initialKind;
    _start = item?.start ?? JalaliMonth.now();
    _end = item?.end;
    _jDay = item?.jDay ?? 1;
    _categoryId = item?.categoryId;
    _accountId = item?.accountId;
    _isActive = item?.isActive ?? true;
    if (item != null) {
      _titleController.text = item.title;
      _amountController.text = toPersianDigits(
          Money.groupDigits((item.amountRial ~/ 10).toString()));
      _noteController.text = item.note ?? '';
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  bool get _isIncome => _kind == OwnerKind.recurringIncome;

  @override
  Widget build(BuildContext context) {
    final categoryKind = _isIncome ? CategoryKind.income : CategoryKind.expense;
    final categories = ref.watch(categoriesProvider(categoryKind)).value ?? [];
    final accounts = ref.watch(accountsProvider).value ?? [];

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
                    existing == null
                        ? (_isIncome ? 'درآمد ثابت جدید' : 'هزینه ثابت جدید')
                        : 'ویرایش ${_isIncome ? 'درآمد' : 'هزینه'} ثابت',
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(width: 48),
              ],
            ),
            const SizedBox(height: 8),
            // Income and expense live in different tables, so an existing row
            // can't switch sides — delete and re-add instead.
            if (existing == null)
              SegmentedButton<OwnerKind>(
                segments: const [
                  ButtonSegment(
                      value: OwnerKind.recurringExpense,
                      label: Text('هزینه ثابت')),
                  ButtonSegment(
                      value: OwnerKind.recurringIncome,
                      label: Text('درآمد ثابت')),
                ],
                selected: {_kind},
                onSelectionChanged: (s) => setState(() {
                  _kind = s.first;
                  _categoryId = null;
                }),
              ),
            const SizedBox(height: 16),
            TextField(
              controller: _titleController,
              autofocus: existing == null,
              decoration: InputDecoration(
                labelText: 'عنوان',
                hintText: _isIncome ? 'مثلاً حقوق' : 'مثلاً اجاره خانه',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              textDirection: TextDirection.ltr,
              inputFormatters: const [PersianAmountInputFormatter()],
              style: Theme.of(context).textTheme.headlineSmall,
              decoration: const InputDecoration(
                labelText: 'مبلغ ماهانه (تومان)',
                helperText: 'اگر ماهی متفاوت شد، همان ماه اصلاحش می‌کنی',
              ),
            ),
            const SizedBox(height: 12),
            _DayOfMonthField(
              value: _jDay,
              onChanged: (day) => setState(() => _jDay = day),
            ),
            const SizedBox(height: 12),
            _MonthField(
              label: 'از ماه',
              value: _start,
              // Non-nullable: without a nullLabel the field has no empty item.
              onChanged: (month) => setState(() => _start = month ?? _start),
            ),
            const SizedBox(height: 12),
            _MonthField(
              label: 'تا ماه (اختیاری)',
              value: _end,
              nullLabel: 'بدون پایان',
              onChanged: (month) => setState(() => _end = month),
            ),
            const SizedBox(height: 12),
            _AccountField(
              accounts: accounts,
              value: _accountId,
              onChanged: (id) => setState(() => _accountId = id),
            ),
            const SizedBox(height: 12),
            Text('دسته‌بندی', style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 8),
            _CategoryChips(
              categories: categories,
              value: _categoryId,
              kind: categoryKind,
              onChanged: (id) => setState(() => _categoryId = id),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _noteController,
              decoration: const InputDecoration(labelText: 'توضیحات (اختیاری)'),
            ),
            if (existing != null) ...[
              const SizedBox(height: 4),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('فعال'),
                subtitle: const Text(
                    'خاموش که باشد، برای ماه‌های بعد ساخته نمی‌شود'),
                value: _isActive,
                onChanged: (value) => setState(() => _isActive = value),
              ),
            ],
            const SizedBox(height: 20),
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
    final messenger = ScaffoldMessenger.of(context);
    void complain(String message) =>
        messenger.showSnackBar(SnackBar(content: Text(message)));

    final title = _titleController.text.trim();
    if (title.isEmpty) {
      complain('یک عنوان وارد کن');
      return;
    }
    final amountRial = Money.parse(_amountController.text);
    if (amountRial == null || amountRial <= 0) {
      complain('مبلغ را درست وارد کن');
      return;
    }
    final end = _end;
    if (end != null && end.ordinal < _start.ordinal) {
      complain('ماه پایان نمی‌تواند قبل از ماه شروع باشد');
      return;
    }

    setState(() => _saving = true);
    final note = _noteController.text.trim();
    final draft = RecurringDraft(
      kind: _kind,
      title: title,
      amountRial: amountRial,
      jDay: _jDay,
      start: _start,
      end: end,
      categoryId: _categoryId,
      accountId: _accountId,
      note: note.isEmpty ? null : note,
      isActive: _isActive,
    );

    final dao = ref.read(recurringDaoProvider);
    if (existing == null) {
      final id = await dao.insertItem(draft);
      // A new fixed item reminds on its due date until the user says
      // otherwise; the reminders sheet is where they change or remove it.
      await ref.read(remindersDaoProvider).insertDefaultRule(_kind, id);
    } else {
      await dao.updateItem(existing!.id, draft);
    }

    if (mounted) Navigator.of(context).pop();
  }
}

class _DayOfMonthField extends StatelessWidget {
  const _DayOfMonthField({required this.value, required this.onChanged});

  final int value;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<int>(
      initialValue: value,
      decoration: const InputDecoration(
        labelText: 'روز ماه',
        helperText: 'در ماه‌های کوتاه‌تر به آخرین روز ماه منتقل می‌شود',
      ),
      items: [
        for (var day = 1; day <= 31; day++)
          DropdownMenuItem(
            value: day,
            child: Text('${toPersianDigits('$day')} ماه'),
          ),
      ],
      onChanged: (day) => onChanged(day ?? 1),
    );
  }
}

/// A Jalali month picker. [nullLabel] makes the field nullable — the option
/// an open-ended recurring item needs.
class _MonthField extends StatelessWidget {
  const _MonthField({
    required this.label,
    required this.value,
    required this.onChanged,
    this.nullLabel,
  });

  final String label;
  final JalaliMonth? value;
  final ValueChanged<JalaliMonth?> onChanged;
  final String? nullLabel;

  /// Two years back through three years ahead, always widened to include the
  /// current value so editing an old item doesn't hand the dropdown a value
  /// that isn't among its items.
  List<JalaliMonth> _options() {
    final now = JalaliMonth.now();
    var first = now - 24;
    var last = now + 36;
    final current = value;
    if (current != null) {
      if (current.ordinal < first.ordinal) first = current;
      if (current.ordinal > last.ordinal) last = current;
    }
    return [
      for (var i = 0; i <= last.ordinal - first.ordinal; i++) first + i,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<int?>(
      initialValue: value?.ordinal,
      decoration: InputDecoration(labelText: label),
      items: [
        if (nullLabel != null)
          DropdownMenuItem(value: null, child: Text(nullLabel!)),
        for (final month in _options())
          DropdownMenuItem(value: month.ordinal, child: Text(month.label)),
      ],
      onChanged: (ordinal) =>
          onChanged(ordinal == null ? null : JalaliMonth.fromOrdinal(ordinal)),
    );
  }
}

class _AccountField extends StatelessWidget {
  const _AccountField({
    required this.accounts,
    required this.value,
    required this.onChanged,
  });

  final List<Account> accounts;
  final int? value;
  final ValueChanged<int?> onChanged;

  @override
  Widget build(BuildContext context) {
    if (accounts.isEmpty) return const SizedBox.shrink();

    return DropdownButtonFormField<int?>(
      initialValue: value,
      decoration: const InputDecoration(labelText: 'حساب (اختیاری)'),
      items: [
        const DropdownMenuItem(value: null, child: Text('بدون حساب')),
        for (final account in accounts)
          DropdownMenuItem(value: account.id, child: Text(account.name)),
      ],
      onChanged: onChanged,
    );
  }
}

class _CategoryChips extends StatelessWidget {
  const _CategoryChips({
    required this.categories,
    required this.value,
    required this.kind,
    required this.onChanged,
  });

  final List<Category> categories;
  final int? value;
  final CategoryKind kind;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final category in categories)
          ChoiceChip(
            avatar: Icon(category.icon, size: 18, color: category.color(context)),
            label: Text(category.name),
            selected: value == category.id,
            onSelected: (_) => onChanged(category.id),
          ),
        ActionChip(
          avatar: const Icon(Icons.add, size: 18),
          label: const Text('دسته جدید'),
          onPressed: () async {
            final id = await showCategoryFormSheet(context, initialKind: kind);
            if (id != null) onChanged(id);
          },
        ),
      ],
    );
  }
}
