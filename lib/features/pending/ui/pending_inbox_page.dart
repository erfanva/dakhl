import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/db/database.dart';
import '../../../core/money/money.dart';
import '../../../core/persian/jalali_utils.dart';
import '../providers/pending_providers.dart';
import 'categorize_sheet.dart';

/// Catches transactions whose notification was missed or dismissed.
class PendingInboxPage extends ConsumerWidget {
  const PendingInboxPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncPending = ref.watch(pendingTransactionsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('در انتظار دسته‌بندی')),
      body: asyncPending.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('خطا در بارگذاری: $e')),
        data: (pending) {
          if (pending.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.inbox_outlined,
                        size: 64,
                        color: Theme.of(context).colorScheme.onSurfaceVariant),
                    const SizedBox(height: 16),
                    const Text('همه تراکنش‌ها دسته‌بندی شده‌اند'),
                  ],
                ),
              ),
            );
          }

          return ListView.builder(
            itemCount: pending.length,
            itemBuilder: (context, index) =>
                _PendingRow(item: pending[index]),
          );
        },
      ),
    );
  }
}

class _PendingRow extends StatelessWidget {
  const _PendingRow({required this.item});

  final TransactionWithRefs item;

  @override
  Widget build(BuildContext context) {
    final txn = item.transaction;
    final isDeposit = txn.type == TxnType.deposit;
    final color =
        isDeposit ? Colors.green.shade700 : Theme.of(context).colorScheme.error;
    final unknownAmount = txn.amountRial == 0;

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color.withValues(alpha: 0.15),
        child: Icon(
          unknownAmount
              ? Icons.help_outline
              : (isDeposit ? Icons.south_west : Icons.north_east),
          color: color,
        ),
      ),
      title: Text(unknownAmount
          ? 'پیامک بانکی ناشناخته'
          : Money.format(txn.amountRial)),
      subtitle: Text([
        if (item.account != null) item.account!.name,
        JalaliUtils.formatDate(txn.occurredAt),
        JalaliUtils.formatTime(txn.occurredAt),
      ].join(' · ')),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => showCategorizeSheet(context, txn.id),
    );
  }
}

/// Opens the categorize sheet for [transactionId].
Future<void> showCategorizeSheet(BuildContext context, int transactionId) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (context) => CategorizeSheet(transactionId: transactionId),
  );
}
