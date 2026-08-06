import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../../../core/db/database.dart';
import '../../../core/db/providers.dart';
import '../../../core/money/money.dart';
import '../../accounts/providers/accounts_providers.dart';
import '../../categories/providers/categories_providers.dart';

/// Opens the manual add/edit transaction sheet. Pass [existing] to edit.
Future<void> showTransactionFormSheet(BuildContext context,
    {Transaction? existing}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (context) => _TransactionFormSheet(existing: existing),
  );
}

class _TransactionFormSheet extends ConsumerStatefulWidget {
  const _TransactionFormSheet({this.existing});

  final Transaction? existing;

  @override
  ConsumerState<_TransactionFormSheet> createState() =>
      _TransactionFormSheetState();
}

class _TransactionFormSheetState extends ConsumerState<_TransactionFormSheet> {
  late TxnType _type;
  late DateTime _occurredAt;
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();
  int? _accountId;
  int? _categoryId;
  bool _saving = false;

  Transaction? get existing => widget.existing;

  @override
  void initState() {
    super.initState();
    _type = existing?.type ?? TxnType.withdrawal;
    _occurredAt = existing?.occurredAt ?? DateTime.now();
    _accountId = existing?.accountId;
    _categoryId = existing?.categoryId;
    if (existing != null) {
      _amountController.text =
          Money.groupDigits((existing!.amountRial ~/ 10).toString());
      _noteController.text = existing!.note ?? '';
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categoryKind =
        _type == TxnType.deposit ? CategoryKind.income : CategoryKind.expense;
    final categories = ref.watch(categoriesProvider(categoryKind)).value ?? [];
    final accounts = ref.watch(accountsProvider).value ?? [];

    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              existing == null ? 'ثبت تراکنش' : 'ویرایش تراکنش',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            SegmentedButton<TxnType>(
              segments: const [
                ButtonSegment(value: TxnType.withdrawal, label: Text('برداشت')),
                ButtonSegment(value: TxnType.deposit, label: Text('واریز')),
              ],
              selected: {_type},
              onSelectionChanged: (s) => setState(() {
                _type = s.first;
                _categoryId = null;
              }),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall,
              decoration: const InputDecoration(
                labelText: 'مبلغ (تومان)',
              ),
            ),
            const SizedBox(height: 12),
            _DatePickerRow(
              value: _occurredAt,
              onChanged: (dt) => setState(() => _occurredAt = dt),
            ),
            const SizedBox(height: 12),
            _AccountPicker(
              accounts: accounts,
              value: _accountId,
              onChanged: (id) => setState(() => _accountId = id),
            ),
            const SizedBox(height: 12),
            Text('دسته‌بندی', style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 8),
            _CategoryGrid(
              categories: categories,
              value: _categoryId,
              onChanged: (id) => setState(() => _categoryId = id),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _noteController,
              decoration: const InputDecoration(labelText: 'توضیحات (اختیاری)'),
            ),
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
    final amountRial = Money.parse(_amountController.text);
    if (amountRial == null || amountRial <= 0) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('مبلغ را درست وارد کن')));
      return;
    }
    if (_categoryId == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('یک دسته‌بندی انتخاب کن')));
      return;
    }

    setState(() => _saving = true);
    final dao = ref.read(transactionsDaoProvider);
    final note = _noteController.text.trim();

    if (existing == null) {
      final companion = buildTransactionCompanion(
        type: _type,
        amountRial: amountRial,
        occurredAt: _occurredAt,
        status: TxnStatus.confirmed,
        source: TxnSource.manual,
        accountId: _accountId,
        categoryId: _categoryId,
        note: note.isEmpty ? null : note,
        confirmedAt: DateTime.now(),
      );
      await dao.insertTransaction(companion);
    } else {
      await dao.updateTransaction(existing!.copyWith(
        type: _type,
        amountRial: amountRial,
        occurredAt: _occurredAt,
        accountId: Value(_accountId),
        categoryId: Value(_categoryId),
        note: Value(note.isEmpty ? null : note),
      ));
    }

    if (mounted) Navigator.of(context).pop();
  }
}

class _DatePickerRow extends StatelessWidget {
  const _DatePickerRow({required this.value, required this.onChanged});

  final DateTime value;
  final ValueChanged<DateTime> onChanged;

  @override
  Widget build(BuildContext context) {
    final jalali = Jalali.fromDateTime(value);
    return OutlinedButton.icon(
      icon: const Icon(Icons.calendar_today_outlined),
      label: Text(
          '${jalali.formatter.wN} ${jalali.day} ${jalali.formatter.mN} ${jalali.year}'),
      onPressed: () async {
        final picked = await showPersianDatePicker(
          context: context,
          initialDate: jalali,
          firstDate: Jalali(1380, 1, 1),
          lastDate: Jalali.fromDateTime(DateTime.now()).addYears(1),
        );
        if (picked != null) {
          final dt = picked.toDateTime();
          onChanged(DateTime(
              dt.year, dt.month, dt.day, value.hour, value.minute));
        }
      },
    );
  }
}

class _AccountPicker extends StatelessWidget {
  const _AccountPicker({required this.accounts, required this.value, required this.onChanged});

  final List<Account> accounts;
  final int? value;
  final ValueChanged<int?> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<int?>(
      initialValue: value,
      decoration: const InputDecoration(labelText: 'حساب (اختیاری)'),
      items: [
        const DropdownMenuItem(value: null, child: Text('بدون حساب')),
        for (final a in accounts)
          DropdownMenuItem(value: a.id, child: Text(a.name)),
        const DropdownMenuItem(value: -1, child: Text('+ حساب جدید')),
      ],
      onChanged: (id) async {
        if (id == -1) {
          final newId = await _createAccountDialog(context);
          if (newId != null) onChanged(newId);
          return;
        }
        onChanged(id);
      },
    );
  }

  Future<int?> _createAccountDialog(BuildContext context) async {
    final controller = TextEditingController();
    final name = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('حساب جدید'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(labelText: 'اسم حساب'),
          autofocus: true,
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context), child: const Text('انصراف')),
          TextButton(
            onPressed: () => Navigator.pop(context, controller.text.trim()),
            child: const Text('ایجاد'),
          ),
        ],
      ),
    );
    if (name == null || name.isEmpty || !context.mounted) return null;
    final container = ProviderScope.containerOf(context);
    return container.read(accountsDaoProvider).insertAccount(
          AccountsCompanion.insert(name: name, createdAt: DateTime.now()),
        );
  }
}

class _CategoryGrid extends StatelessWidget {
  const _CategoryGrid({required this.categories, required this.value, required this.onChanged});

  final List<Category> categories;
  final int? value;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    if (categories.isEmpty) {
      return const Text('دسته‌بندی‌ای موجود نیست');
    }
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final c in categories)
          ChoiceChip(
            label: Text(c.name),
            selected: value == c.id,
            onSelected: (_) => onChanged(c.id),
          ),
      ],
    );
  }
}
