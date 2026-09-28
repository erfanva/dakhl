import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../../../core/db/database.dart';
import '../../../core/db/providers.dart';
import '../../../core/money/amount_input_formatter.dart';
import '../../../core/money/money.dart';
import '../../../core/persian/digits.dart';
import '../../../core/persian/jalali_utils.dart';

/// Opens the add/edit sheet for a debt or a credit. Pass [existing] to edit.
/// Returns the debt id on save, or null if dismissed.
Future<int?> showDebtFormSheet(
  BuildContext context, {
  DebtWithProgress? existing,
  DebtDirection initialDirection = DebtDirection.iOwe,
}) {
  return showModalBottomSheet<int>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (context) => _DebtFormSheet(
      existing: existing,
      initialDirection: existing?.debt.direction ?? initialDirection,
    ),
  );
}

class _DebtFormSheet extends ConsumerStatefulWidget {
  const _DebtFormSheet({required this.initialDirection, this.existing});

  final DebtWithProgress? existing;
  final DebtDirection initialDirection;

  @override
  ConsumerState<_DebtFormSheet> createState() => _DebtFormSheetState();
}

class _DebtFormSheetState extends ConsumerState<_DebtFormSheet> {
  final _personController = TextEditingController();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();

  late DebtDirection _direction;
  DateTime? _dueAt;
  bool _saving = false;

  Debt? get existing => widget.existing?.debt;

  @override
  void initState() {
    super.initState();
    _direction = widget.initialDirection;
    final debt = existing;
    if (debt != null) {
      _personController.text = debt.personName;
      _titleController.text = debt.title ?? '';
      _amountController.text = toPersianDigits(
          Money.groupDigits((debt.totalAmountRial ~/ 10).toString()));
      _noteController.text = debt.note ?? '';
      _dueAt = debt.dueAt;
    }
  }

  @override
  void dispose() {
    _personController.dispose();
    _titleController.dispose();
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  bool get _iOwe => _direction == DebtDirection.iOwe;

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
                    existing == null
                        ? (_iOwe ? 'بدهی جدید' : 'طلب جدید')
                        : (_iOwe ? 'ویرایش بدهی' : 'ویرایش طلب'),
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(width: 48),
              ],
            ),
            const SizedBox(height: 8),
            SegmentedButton<DebtDirection>(
              segments: const [
                ButtonSegment(
                    value: DebtDirection.iOwe, label: Text('بدهکارم')),
                ButtonSegment(
                    value: DebtDirection.owedToMe, label: Text('طلبکارم')),
              ],
              selected: {_direction},
              onSelectionChanged: (s) => setState(() => _direction = s.first),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _personController,
              autofocus: existing == null,
              decoration: InputDecoration(
                labelText: _iOwe ? 'به چه کسی؟' : 'از چه کسی؟',
                hintText: 'مثلاً رضا',
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
              decoration: const InputDecoration(labelText: 'مبلغ کل (تومان)'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'بابت (اختیاری)',
                hintText: 'مثلاً قرض برای خرید لپ‌تاپ',
              ),
            ),
            const SizedBox(height: 12),
            _DueDateField(
              value: _dueAt,
              onChanged: (value) => setState(() => _dueAt = value),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _noteController,
              decoration: const InputDecoration(labelText: 'توضیحات (اختیاری)'),
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
    final messenger = ScaffoldMessenger.of(context);
    final person = _personController.text.trim();
    if (person.isEmpty) {
      messenger.showSnackBar(
          const SnackBar(content: Text('اسم طرف حساب را وارد کن')));
      return;
    }
    final amountRial = Money.parse(_amountController.text);
    if (amountRial == null || amountRial <= 0) {
      messenger
          .showSnackBar(const SnackBar(content: Text('مبلغ را درست وارد کن')));
      return;
    }
    // Editing the total below what's already been paid would leave the debt
    // in a state the progress bar can't describe.
    final paid = widget.existing?.paidRial ?? 0;
    if (amountRial < paid) {
      messenger.showSnackBar(SnackBar(
        content: Text('تا حالا ${Money.format(paid)} پرداخت شده؛ '
            'مبلغ کل نمی‌تواند کمتر از آن باشد'),
      ));
      return;
    }

    setState(() => _saving = true);
    final dao = ref.read(debtsDaoProvider);
    final title = _titleController.text.trim();
    final note = _noteController.text.trim();
    int id;

    if (existing == null) {
      id = await dao.insertDebt(DebtsCompanion.insert(
        direction: _direction,
        personName: person,
        title: Value(title.isEmpty ? null : title),
        totalAmountRial: amountRial,
        dueAt: Value(_dueAt),
        note: Value(note.isEmpty ? null : note),
        status: DebtStatus.open,
        createdAt: DateTime.now(),
      ));
      // Only a dated debt can be reminded about.
      if (_dueAt != null) {
        await ref
            .read(remindersDaoProvider)
            .insertDefaultRule(OwnerKind.debt, id);
      }
    } else {
      id = existing!.id;
      await dao.updateDebt(existing!.copyWith(
        direction: _direction,
        personName: person,
        title: Value(title.isEmpty ? null : title),
        totalAmountRial: amountRial,
        dueAt: Value(_dueAt),
        note: Value(note.isEmpty ? null : note),
      ));
    }

    if (mounted) Navigator.of(context).pop(id);
  }
}

class _DueDateField extends StatelessWidget {
  const _DueDateField({required this.value, required this.onChanged});

  final DateTime? value;
  final ValueChanged<DateTime?> onChanged;

  @override
  Widget build(BuildContext context) {
    final due = value;
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            icon: const Icon(Icons.event_outlined),
            label: Text(due == null
                ? 'موعد (اختیاری)'
                : 'موعد ${JalaliUtils.formatDate(due)}'),
            onPressed: () async {
              final picked = await showPersianDatePicker(
                context: context,
                initialDate: Jalali.fromDateTime(due ?? DateTime.now()),
                firstDate: Jalali(1380, 1, 1),
                lastDate: Jalali.fromDateTime(DateTime.now()).addYears(10),
              );
              if (picked != null) onChanged(picked.toDateTime());
            },
          ),
        ),
        if (due != null)
          IconButton(
            icon: const Icon(Icons.clear),
            tooltip: 'حذف موعد',
            onPressed: () => onChanged(null),
          ),
      ],
    );
  }
}
