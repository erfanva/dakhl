import 'package:drift/drift.dart' show Value;
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
import '../providers/pending_providers.dart';

/// The sheet a transaction notification opens: pick a category, optionally
/// attach the payment to a debt, then confirm or dismiss.
class CategorizeSheet extends ConsumerStatefulWidget {
  const CategorizeSheet({super.key, required this.transactionId});

  final int transactionId;

  @override
  ConsumerState<CategorizeSheet> createState() => _CategorizeSheetState();
}

class _CategorizeSheetState extends ConsumerState<CategorizeSheet> {
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();
  int? _categoryId;
  int? _accountId;
  TxnType? _type;
  bool _initialized = false;
  bool _saving = false;

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  /// Seeds the editable fields from the parsed row, once.
  void _initializeFrom(Transaction txn) {
    if (_initialized) return;
    _initialized = true;
    _type = txn.type;
    _accountId = txn.accountId;
    _categoryId = txn.categoryId;
    if (txn.amountRial > 0) {
      _amountController.text = toPersianDigits(
          Money.groupDigits((txn.amountRial ~/ 10).toString()));
    }
    _noteController.text = txn.note ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final asyncTxn =
        ref.watch(pendingTransactionProvider(widget.transactionId));

    return asyncTxn.when(
      loading: () => const SizedBox(
        height: 220,
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => SizedBox(
        height: 220,
        child: Center(child: Text('خطا در بارگذاری: $e')),
      ),
      data: (item) {
        if (item == null) {
          // Already handled — from another device, the inbox, or a second
          // tap on the same notification.
          return const _AlreadyHandled();
        }
        _initializeFrom(item.transaction);
        return _buildForm(context, item);
      },
    );
  }

  Widget _buildForm(BuildContext context, TransactionWithRefs item) {
    final txn = item.transaction;
    final type = _type ?? txn.type;
    final categoryKind =
        type == TxnType.deposit ? CategoryKind.income : CategoryKind.expense;
    final categories = ref.watch(categoriesProvider(categoryKind)).value ?? [];
    final accounts = ref.watch(accountsProvider).value ?? [];
    final needsAmount = txn.amountRial == 0;

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
                    'دسته‌بندی تراکنش',
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(width: 48),
              ],
            ),
            const SizedBox(height: 8),
            _AmountHeader(
              amountRial: txn.amountRial,
              type: type,
              bankName: item.account?.name,
              occurredAt: txn.occurredAt,
            ),
            const SizedBox(height: 16),
            if (needsAmount) ...[
              // Unrecognized SMS: the user supplies direction and amount.
              SegmentedButton<TxnType>(
                segments: const [
                  ButtonSegment(
                      value: TxnType.withdrawal, label: Text('برداشت')),
                  ButtonSegment(value: TxnType.deposit, label: Text('واریز')),
                ],
                selected: {type},
                onSelectionChanged: (s) => setState(() {
                  _type = s.first;
                  _categoryId = null;
                }),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                textDirection: TextDirection.ltr,
                inputFormatters: const [PersianAmountInputFormatter()],
                style: Theme.of(context).textTheme.headlineSmall,
                decoration: const InputDecoration(labelText: 'مبلغ (تومان)'),
              ),
              const SizedBox(height: 12),
            ],
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
            const SizedBox(height: 16),
            Text('دسته‌بندی', style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final category in categories)
                  ChoiceChip(
                    avatar: Icon(category.icon,
                        size: 18, color: category.color(context)),
                    label: Text(category.name),
                    selected: _categoryId == category.id,
                    onSelected: (_) =>
                        setState(() => _categoryId = category.id),
                  ),
                ActionChip(
                  avatar: const Icon(Icons.add, size: 18),
                  label: const Text('دسته جدید'),
                  onPressed: () async {
                    final id = await showCategoryFormSheet(context,
                        initialKind: categoryKind);
                    if (id != null) setState(() => _categoryId = id);
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _noteController,
              decoration:
                  const InputDecoration(labelText: 'توضیحات (اختیاری)'),
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: _saving ? null : () => _confirm(txn),
              child: const Text('تایید'),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: _saving ? null : () => _dismiss(txn),
              child: const Text('نادیده بگیر'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _confirm(Transaction txn) async {
    final amountRial = txn.amountRial > 0
        ? txn.amountRial
        : (Money.parse(_amountController.text) ?? 0);
    if (amountRial <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('مبلغ را وارد کن')),
      );
      return;
    }
    if (_categoryId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('یک دسته‌بندی انتخاب کن')),
      );
      return;
    }

    setState(() => _saving = true);
    final dao = ref.read(transactionsDaoProvider);
    final note = _noteController.text.trim();

    await dao.updateTransaction(txn.copyWith(
      type: _type ?? txn.type,
      amountRial: amountRial,
      accountId: Value(_accountId),
      categoryId: Value(_categoryId),
      note: Value(note.isEmpty ? null : note),
      status: TxnStatus.confirmed,
      confirmedAt: Value(DateTime.now()),
    ));

    if (mounted) Navigator.of(context).pop();
  }

  Future<void> _dismiss(Transaction txn) async {
    setState(() => _saving = true);
    await ref.read(transactionsDaoProvider).dismissTransaction(txn.id);
    if (mounted) Navigator.of(context).pop();
  }
}

class _AmountHeader extends StatelessWidget {
  const _AmountHeader({
    required this.amountRial,
    required this.type,
    required this.bankName,
    required this.occurredAt,
  });

  final int amountRial;
  final TxnType type;
  final String? bankName;
  final DateTime occurredAt;

  @override
  Widget build(BuildContext context) {
    final isDeposit = type == TxnType.deposit;
    final color =
        isDeposit ? Colors.green.shade700 : Theme.of(context).colorScheme.error;

    return Column(
      children: [
        Chip(
          avatar: Icon(isDeposit ? Icons.south_west : Icons.north_east,
              size: 18, color: color),
          label: Text(isDeposit ? 'واریز' : 'برداشت'),
        ),
        const SizedBox(height: 8),
        if (amountRial > 0)
          Text(
            Money.format(amountRial),
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(fontWeight: FontWeight.bold, color: color),
          ),
        const SizedBox(height: 4),
        Text(
          [
            ?bankName,
            JalaliUtils.formatDate(occurredAt),
            JalaliUtils.formatTime(occurredAt),
          ].join(' · '),
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}

class _AlreadyHandled extends StatelessWidget {
  const _AlreadyHandled();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.check_circle_outline, size: 48),
          const SizedBox(height: 12),
          const Text('این تراکنش قبلاً بررسی شده است'),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('بستن'),
          ),
        ],
      ),
    );
  }
}
