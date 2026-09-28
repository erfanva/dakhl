import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../../../core/db/database.dart';
import '../../../core/db/providers.dart';
import '../../../core/money/amount_input_formatter.dart';
import '../../../core/money/money.dart';
import '../../../core/persian/digits.dart';
import '../../accounts/providers/accounts_providers.dart';

/// Confirms settling a due occurrence, then writes the real transaction.
///
/// The amount and the date are editable because the whole point of a plan is
/// that reality drifts from it — the rent went up, the salary landed late.
Future<void> showSettleOccurrenceDialog(
  BuildContext context, {
  required PlannedEntry entry,
}) {
  return showDialog(
    context: context,
    builder: (context) => _SettleDialog(entry: entry),
  );
}

class _SettleDialog extends ConsumerStatefulWidget {
  const _SettleDialog({required this.entry});

  final PlannedEntry entry;

  @override
  ConsumerState<_SettleDialog> createState() => _SettleDialogState();
}

class _SettleDialogState extends ConsumerState<_SettleDialog> {
  final _amountController = TextEditingController();
  late DateTime _occurredAt;
  int? _accountId;
  bool _saving = false;

  PlannedEntry get entry => widget.entry;

  @override
  void initState() {
    super.initState();
    _amountController.text = toPersianDigits(
        Money.groupDigits((entry.amountRial ~/ 10).toString()));
    // Default to today rather than the due date: the common case is ticking
    // something off on the day it actually happened.
    _occurredAt = DateTime.now();
    _accountId = entry.item.accountId;
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final accounts = ref.watch(accountsProvider).value ?? [];
    final isIncome = entry.item.isIncome;
    final jalali = Jalali.fromDateTime(_occurredAt);

    return AlertDialog(
      title: Text(isIncome ? 'ثبت دریافت' : 'ثبت پرداخت'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(entry.item.title,
              style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 12),
          TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            textDirection: TextDirection.ltr,
            inputFormatters: const [PersianAmountInputFormatter()],
            decoration: const InputDecoration(labelText: 'مبلغ (تومان)'),
          ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            icon: const Icon(Icons.calendar_today_outlined),
            label: Text('${jalali.day} ${jalali.formatter.mN} ${jalali.year}'),
            onPressed: _pickDate,
          ),
          if (accounts.isNotEmpty) ...[
            const SizedBox(height: 8),
            DropdownButtonFormField<int?>(
              initialValue: _accountId,
              decoration: const InputDecoration(labelText: 'حساب'),
              items: [
                const DropdownMenuItem(value: null, child: Text('بدون حساب')),
                for (final account in accounts)
                  DropdownMenuItem(
                      value: account.id, child: Text(account.name)),
              ],
              onChanged: (id) => setState(() => _accountId = id),
            ),
          ],
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('انصراف'),
        ),
        FilledButton(
          onPressed: _saving ? null : _settle,
          child: const Text('ثبت'),
        ),
      ],
    );
  }

  Future<void> _pickDate() async {
    final picked = await showPersianDatePicker(
      context: context,
      initialDate: Jalali.fromDateTime(_occurredAt),
      firstDate: Jalali(1380, 1, 1),
      lastDate: Jalali.fromDateTime(DateTime.now()).addYears(1),
    );
    if (picked == null) return;
    final date = picked.toDateTime();
    setState(() => _occurredAt = DateTime(date.year, date.month, date.day,
        _occurredAt.hour, _occurredAt.minute));
  }

  Future<void> _settle() async {
    final amountRial = Money.parse(_amountController.text);
    if (amountRial == null || amountRial <= 0) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('مبلغ را درست وارد کن')));
      return;
    }

    setState(() => _saving = true);
    await ref.read(recurringDaoProvider).markDone(
          entry: entry,
          amountRial: amountRial,
          paidAt: _occurredAt,
          accountId: Value(_accountId),
        );

    if (mounted) Navigator.pop(context);
  }
}
