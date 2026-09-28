import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../../../core/db/database.dart';
import '../../../core/db/providers.dart';
import '../../../core/money/amount_input_formatter.dart';
import '../../../core/money/money.dart';
import '../../../core/persian/digits.dart';
import '../../accounts/providers/accounts_providers.dart';

/// Records a payment against a debt (or a receipt against a credit).
Future<void> showDebtPaymentDialog(
  BuildContext context, {
  required DebtWithProgress entry,
}) {
  return showDialog(
    context: context,
    builder: (context) => _DebtPaymentDialog(entry: entry),
  );
}

class _DebtPaymentDialog extends ConsumerStatefulWidget {
  const _DebtPaymentDialog({required this.entry});

  final DebtWithProgress entry;

  @override
  ConsumerState<_DebtPaymentDialog> createState() => _DebtPaymentDialogState();
}

class _DebtPaymentDialogState extends ConsumerState<_DebtPaymentDialog> {
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();
  DateTime _paidAt = DateTime.now();
  int? _accountId;
  bool _recordTransaction = true;
  bool _saving = false;

  DebtWithProgress get entry => widget.entry;

  @override
  void initState() {
    super.initState();
    // Paying the rest off is the common case; a partial payment is a quick
    // edit from there.
    _amountController.text = toPersianDigits(
        Money.groupDigits((entry.remainingRial ~/ 10).toString()));
  }

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final accounts = ref.watch(accountsProvider).value ?? [];
    final jalali = Jalali.fromDateTime(_paidAt);

    return AlertDialog(
      title: Text(entry.iOwe ? 'ثبت پرداخت' : 'ثبت دریافت'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
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
              label:
                  Text('${jalali.day} ${jalali.formatter.mN} ${jalali.year}'),
              onPressed: _pickDate,
            ),
            if (accounts.isNotEmpty && _recordTransaction) ...[
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
            const SizedBox(height: 8),
            TextField(
              controller: _noteController,
              decoration: const InputDecoration(labelText: 'توضیحات (اختیاری)'),
            ),
            // Off for a payment the user already entered by hand, so the
            // ledger doesn't count it twice.
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('ثبت در تراکنش‌ها'),
              value: _recordTransaction,
              onChanged: (value) => setState(() => _recordTransaction = value),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('انصراف'),
        ),
        FilledButton(
          onPressed: _saving ? null : _save,
          child: const Text('ثبت'),
        ),
      ],
    );
  }

  Future<void> _pickDate() async {
    final picked = await showPersianDatePicker(
      context: context,
      initialDate: Jalali.fromDateTime(_paidAt),
      firstDate: Jalali(1380, 1, 1),
      lastDate: Jalali.fromDateTime(DateTime.now()).addYears(1),
    );
    if (picked != null) setState(() => _paidAt = picked.toDateTime());
  }

  Future<void> _save() async {
    final amountRial = Money.parse(_amountController.text);
    if (amountRial == null || amountRial <= 0) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('مبلغ را درست وارد کن')));
      return;
    }

    setState(() => _saving = true);
    final note = _noteController.text.trim();
    await ref.read(debtsDaoProvider).addPayment(
          debtId: entry.debt.id,
          amountRial: amountRial,
          paidAt: _paidAt,
          accountId: _recordTransaction ? _accountId : null,
          note: note.isEmpty ? null : note,
          recordTransaction: _recordTransaction,
        );

    if (mounted) Navigator.pop(context);
  }
}
