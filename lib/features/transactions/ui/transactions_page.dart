import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/db/database.dart';
import '../../../core/money/money.dart';
import '../../../core/persian/jalali_utils.dart';
import '../../../shared/ui/coming_soon_view.dart';
import '../../../core/db/providers.dart';
import '../../accounts/providers/accounts_providers.dart';
import '../providers/transactions_providers.dart';
import 'transaction_form_sheet.dart';

class TransactionsPage extends ConsumerWidget {
  const TransactionsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final month = ref.watch(selectedMonthProvider);
    final pendingCount = ref.watch(pendingCountProvider).value ?? 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('تراکنش‌ها'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_balance_wallet_outlined),
            tooltip: 'حساب‌ها',
            onPressed: () => context.go('/transactions/accounts'),
          ),
        ],
      ),
      body: Column(
        children: [
          if (pendingCount > 0) _PendingBanner(count: pendingCount),
          const _TotalBalanceCard(),
          const _AccountFilterRow(),
          _MonthSwitcher(month: month),
          const Expanded(child: _TransactionList()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showTransactionFormSheet(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _PendingBanner extends StatelessWidget {
  const _PendingBanner({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: theme.colorScheme.tertiaryContainer,
      child: InkWell(
        onTap: () {
          // TODO(phase-3): open pending inbox / categorize sheet.
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Icon(Icons.notifications_active_outlined,
                  color: theme.colorScheme.onTertiaryContainer),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  '$count تراکنش در انتظار دسته‌بندی',
                  style: TextStyle(color: theme.colorScheme.onTertiaryContainer),
                ),
              ),
              Icon(Icons.chevron_left, color: theme.colorScheme.onTertiaryContainer),
            ],
          ),
        ),
      ),
    );
  }
}

class _TotalBalanceCard extends ConsumerWidget {
  const _TotalBalanceCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accounts = ref.watch(accountsWithBalancesProvider).value ?? [];
    final total = accounts.fold<int>(0, (sum, a) => sum + a.balanceRial);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('موجودی کل',
                  style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 4),
              Text(
                Money.format(total),
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AccountFilterRow extends ConsumerWidget {
  const _AccountFilterRow();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accounts = ref.watch(accountsWithBalancesProvider).value ?? [];
    final selected = ref.watch(accountFilterProvider);

    if (accounts.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: 44,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        children: [
          _AccountChip(
            label: 'همه حساب‌ها',
            selected: selected == null,
            onTap: () => ref.read(accountFilterProvider.notifier).state = null,
          ),
          for (final a in accounts)
            _AccountChip(
              label: '${a.account.name} · ${Money.formatCompact(a.balanceRial)}',
              selected: selected == a.account.id,
              onTap: () =>
                  ref.read(accountFilterProvider.notifier).state = a.account.id,
            ),
        ],
      ),
    );
  }
}

class _AccountChip extends StatelessWidget {
  const _AccountChip({required this.label, required this.selected, required this.onTap});

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => onTap(),
      ),
    );
  }
}

class _MonthSwitcher extends ConsumerWidget {
  const _MonthSwitcher({required this.month});

  final JalaliMonth month;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(selectedMonthProvider.notifier);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // The chevrons are matchTextDirection icons, so they mirror
          // themselves under RTL — name them by their logical direction and
          // let Flutter flip both the icon and the Row order.
          IconButton(
            icon: const Icon(Icons.chevron_left),
            tooltip: 'ماه قبل',
            onPressed: notifier.previous,
          ),
          Text(month.label, style: Theme.of(context).textTheme.titleMedium),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            tooltip: 'ماه بعد',
            onPressed: notifier.next,
          ),
        ],
      ),
    );
  }
}

class _TransactionList extends ConsumerWidget {
  const _TransactionList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncTxns = ref.watch(monthTransactionsProvider);

    return asyncTxns.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('خطا: $err')),
      data: (txns) {
        if (txns.isEmpty) {
          return const ComingSoonView(
            icon: Icons.receipt_long_outlined,
            message: 'هنوز تراکنشی برای این ماه ثبت نشده. با دکمه + شروع کن.',
          );
        }
        final groups = _groupByDay(txns);
        return ListView.builder(
          padding: const EdgeInsets.only(bottom: 96),
          itemCount: groups.length,
          itemBuilder: (context, index) {
            final group = groups[index];
            return _DayGroup(day: group.day, items: group.items);
          },
        );
      },
    );
  }

  List<_DayGroupData> _groupByDay(List<TransactionWithRefs> txns) {
    final map = <DateTime, List<TransactionWithRefs>>{};
    for (final t in txns) {
      final day = JalaliUtils.startOfDay(t.transaction.occurredAt);
      map.putIfAbsent(day, () => []).add(t);
    }
    final days = map.keys.toList()..sort((a, b) => b.compareTo(a));
    return [for (final d in days) _DayGroupData(day: d, items: map[d]!)];
  }
}

class _DayGroupData {
  const _DayGroupData({required this.day, required this.items});
  final DateTime day;
  final List<TransactionWithRefs> items;
}

class _DayGroup extends StatelessWidget {
  const _DayGroup({required this.day, required this.items});

  final DateTime day;
  final List<TransactionWithRefs> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
          child: Text(
            JalaliUtils.formatDayHeader(day),
            style: Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(color: Theme.of(context).colorScheme.outline),
          ),
        ),
        for (final item in items) _TransactionTile(item: item),
      ],
    );
  }
}

class _TransactionTile extends ConsumerWidget {
  const _TransactionTile({required this.item});

  final TransactionWithRefs item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final txn = item.transaction;
    final isDeposit = txn.type == TxnType.deposit;
    final color = isDeposit ? Colors.green : Theme.of(context).colorScheme.error;
    final isPending = txn.status == TxnStatus.pending;

    return Dismissible(
      key: ValueKey(txn.id),
      background: Container(
        color: Theme.of(context).colorScheme.errorContainer,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.delete_outline),
      ),
      confirmDismiss: (_) => _confirmDelete(context),
      onDismissed: (_) =>
          ref.read(transactionsDaoProvider).deleteTransaction(txn.id),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withValues(alpha: 0.15),
          child: Icon(
            isDeposit ? Icons.south_west : Icons.north_east,
            color: color,
          ),
        ),
        title: Text(item.category?.name ?? (isPending ? 'در انتظار دسته‌بندی' : 'نامشخص')),
        subtitle: Text([
          if (item.account != null) item.account!.name,
          JalaliUtils.formatTime(txn.occurredAt),
          if (txn.note?.isNotEmpty ?? false) txn.note!,
        ].join(' · ')),
        // No +/− sign: the icon and the colour already say deposit vs
        // withdrawal. RTL puts the «تومان» label to the left of the digits.
        trailing: Text(
          Money.format(txn.amountRial),
          style: TextStyle(color: color, fontWeight: FontWeight.bold),
        ),
        onTap: () => showTransactionFormSheet(context, existing: txn),
      ),
    );
  }

  Future<bool> _confirmDelete(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('حذف تراکنش'),
        content: const Text('این تراکنش حذف شود؟'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('انصراف')),
          TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('حذف')),
        ],
      ),
    );
    return result ?? false;
  }
}
