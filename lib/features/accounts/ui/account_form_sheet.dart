import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/db/database.dart';
import '../../../core/db/providers.dart';
import '../../../core/money/amount_input_formatter.dart';
import '../../../core/money/money.dart';
import '../../../core/persian/digits.dart';

/// Opens the add/edit account sheet. Pass [existing] to edit.
/// Returns the account id on save, or null if dismissed.
Future<int?> showAccountFormSheet(BuildContext context, {Account? existing}) {
  return showModalBottomSheet<int>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (context) => _AccountFormSheet(existing: existing),
  );
}

class _AccountFormSheet extends ConsumerStatefulWidget {
  const _AccountFormSheet({this.existing});

  final Account? existing;

  @override
  ConsumerState<_AccountFormSheet> createState() => _AccountFormSheetState();
}

class _AccountFormSheetState extends ConsumerState<_AccountFormSheet> {
  final _nameController = TextEditingController();
  final _bankController = TextEditingController();
  final _suffixController = TextEditingController();
  final _initialBalanceController = TextEditingController();
  bool _saving = false;

  Account? get existing => widget.existing;

  @override
  void initState() {
    super.initState();
    final account = existing;
    if (account != null) {
      _nameController.text = account.name;
      _bankController.text = account.bankName ?? '';
      _suffixController.text = account.accountNoSuffix ?? '';
      if (account.initialBalanceRial != 0) {
        _initialBalanceController.text = toPersianDigits(
            Money.groupDigits((account.initialBalanceRial ~/ 10).toString()));
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _bankController.dispose();
    _suffixController.dispose();
    _initialBalanceController.dispose();
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
                    existing == null ? 'حساب جدید' : 'ویرایش حساب',
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(width: 48),
              ],
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _nameController,
              autofocus: existing == null,
              decoration: const InputDecoration(
                labelText: 'اسم حساب',
                hintText: 'مثلاً کارت ملت',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _bankController,
              decoration: const InputDecoration(
                labelText: 'نام بانک (اختیاری)',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _suffixController,
              keyboardType: TextInputType.number,
              textDirection: TextDirection.ltr,
              decoration: const InputDecoration(
                labelText: '۴ رقم آخر کارت (اختیاری)',
                helperText: 'برای تشخیص خودکار حساب از روی پیامک بانک',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _initialBalanceController,
              keyboardType: TextInputType.number,
              textDirection: TextDirection.ltr,
              inputFormatters: const [PersianAmountInputFormatter()],
              decoration: const InputDecoration(
                labelText: 'موجودی اولیه (تومان)',
                helperText: 'موجودی فعلی حساب، قبل از ثبت تراکنش‌ها',
              ),
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
        const SnackBar(content: Text('اسم حساب را وارد کن')),
      );
      return;
    }

    setState(() => _saving = true);
    final dao = ref.read(accountsDaoProvider);
    final bank = _bankController.text.trim();
    final suffix = toLatinDigits(_suffixController.text)
        .replaceAll(RegExp(r'[^0-9]'), '');
    final initialBalance = Money.parse(_initialBalanceController.text) ?? 0;
    int id;

    if (existing == null) {
      id = await dao.insertAccount(AccountsCompanion.insert(
        name: name,
        bankName: Value(bank.isEmpty ? null : bank),
        accountNoSuffix: Value(suffix.isEmpty ? null : suffix),
        initialBalanceRial: Value(initialBalance),
        sortOrder: Value(await dao.nextSortOrder()),
        createdAt: DateTime.now(),
      ));
    } else {
      id = existing!.id;
      await dao.updateAccount(existing!.copyWith(
        name: name,
        bankName: Value(bank.isEmpty ? null : bank),
        accountNoSuffix: Value(suffix.isEmpty ? null : suffix),
        initialBalanceRial: initialBalance,
      ));
    }

    if (mounted) Navigator.of(context).pop(id);
  }
}
