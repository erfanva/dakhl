import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/db/database.dart';
import '../../../core/money/money.dart';
import '../../../core/persian/digits.dart';
import '../../../core/persian/jalali_utils.dart';
import '../../reports/providers/reports_providers.dart';
import '../../transactions/providers/transactions_providers.dart';
import '../../transactions/ui/transaction_form_sheet.dart';
import '../providers/categories_providers.dart';
import '../category_style.dart';
import 'category_form_sheet.dart';

/// One category's activity in the selected month: total, share, and the
/// transactions themselves.
class CategoryDetailPage extends ConsumerWidget {
  const CategoryDetailPage({super.key, required this.categoryId});

  final int categoryId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final month = ref.watch(selectedMonthProvider);
    final asyncCategory =
        ref.watch(categoryByIdProvider(categoryId));
    final asyncTxns = ref.watch(categoryTransactionsProvider(categoryId));

    return Scaffold(
      appBar: AppBar(
        title: Text(asyncCategory.value?.name ?? 'دسته‌بندی'),
        actions: [
          if (asyncCategory.value != null)
            IconButton(
              icon: const Icon(Icons.edit_outlined),
              tooltip: 'ویرایش',
              onPressed: () => showCategoryFormSheet(
                context,
                existing: asyncCategory.value,
              ),
            ),
        ],
      ),
      body: asyncTxns.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('خطا در بارگذاری: $e')),
        data: (txns) {
          final category = asyncCategory.value;
          final total =
              txns.fold<int>(0, (sum, t) => sum + t.transaction.amountRial);

          return ListView(
            children: [
              _Header(
                category: category,
                month: month,
                totalRial: total,
                count: txns.length,
              ),
              if (txns.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(32),
                  child: Center(
                    child: Text(
                      'در ${month.label} تراکنشی در این دسته ثبت نشده',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                )
              else
                for (final item in txns) _TransactionRow(item: item),
            ],
          );
        },
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.category,
    required this.month,
    required this.totalRial,
    required this.count,
  });

  final Category? category;
  final JalaliMonth month;
  final int totalRial;
  final int count;

  @override
  Widget build(BuildContext context) {
    final color = category?.color(context) ??
        Theme.of(context).colorScheme.primary;

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: color.withValues(alpha: 0.18),
              child: Icon(category?.icon ?? Icons.category_outlined,
                  color: color, size: 28),
            ),
            const SizedBox(height: 12),
            Text(month.label,
                style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 4),
            Text(
              Money.format(totalRial),
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold, color: color),
            ),
            const SizedBox(height: 4),
            Text(
              '${toPersianDigits('$count')} تراکنش',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

class _TransactionRow extends StatelessWidget {
  const _TransactionRow({required this.item});

  final TransactionWithRefs item;

  @override
  Widget build(BuildContext context) {
    final txn = item.transaction;
    final isDeposit = txn.type == TxnType.deposit;
    final color =
        isDeposit ? Colors.green.shade700 : Theme.of(context).colorScheme.error;

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color.withValues(alpha: 0.15),
        child: Icon(isDeposit ? Icons.south_west : Icons.north_east,
            color: color),
      ),
      title: Text(JalaliUtils.formatDate(txn.occurredAt)),
      subtitle: Text([
        if (item.account != null) item.account!.name,
        JalaliUtils.formatTime(txn.occurredAt),
        if (txn.note?.isNotEmpty ?? false) txn.note!,
      ].join(' · ')),
      trailing: Text(
        Money.format(txn.amountRial),
        style: TextStyle(color: color, fontWeight: FontWeight.bold),
      ),
      onTap: () => showTransactionFormSheet(context, existing: txn),
    );
  }
}
