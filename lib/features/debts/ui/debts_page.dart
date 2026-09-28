import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/db/database.dart';
import '../../../core/money/money.dart';
import '../../../core/persian/jalali_utils.dart';
import '../providers/debts_providers.dart';
import 'debt_form_sheet.dart';

/// Debts and credits: what the user owes, what they're owed, and how much of
/// each is left after payments.
class DebtsPage extends ConsumerWidget {
  const DebtsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncDebts = ref.watch(debtsProvider);
    final showSettled = ref.watch(showSettledDebtsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('بدهی و طلب'),
        actions: [
          IconButton(
            icon: Icon(showSettled ? Icons.visibility_off : Icons.history),
            tooltip: showSettled ? 'پنهان کردن تسویه‌شده‌ها' : 'نمایش تسویه‌شده‌ها',
            onPressed: () => ref
                .read(showSettledDebtsProvider.notifier)
                .state = !showSettled,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDebtFormSheet(context),
        tooltip: 'افزودن',
        child: const Icon(Icons.add),
      ),
      body: asyncDebts.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('خطا در بارگذاری: $error')),
        data: (debts) {
          final iOwe = debts.where((d) => d.iOwe).toList();
          final owedToMe = debts.where((d) => !d.iOwe).toList();

          return ListView(
            padding: const EdgeInsets.only(bottom: 96),
            children: [
              const _TotalsCard(),
              if (debts.isEmpty) const _EmptyState(),
              _Section(
                title: 'بدهی‌های من',
                direction: DebtDirection.iOwe,
                debts: iOwe,
              ),
              _Section(
                title: 'طلب‌های من',
                direction: DebtDirection.owedToMe,
                debts: owedToMe,
              ),
            ],
          );
        },
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 24, 32, 0),
      child: Column(
        children: [
          Icon(Icons.handshake_outlined,
              size: 56, color: theme.colorScheme.outline),
          const SizedBox(height: 16),
          Text(
            'قرض‌هایی که داده‌ای یا گرفته‌ای را اینجا ثبت کن؛\n'
            'هر قسط که پرداخت شود، در تراکنش‌ها هم ثبت می‌شود.',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium
                ?.copyWith(color: theme.colorScheme.outline),
          ),
        ],
      ),
    );
  }
}

class _TotalsCard extends ConsumerWidget {
  const _TotalsCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final totals = ref.watch(debtTotalsProvider).value;
    if (totals == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  _Figure(
                    label: 'بدهی من',
                    amountRial: totals.iOweRial,
                    color: theme.colorScheme.error,
                  ),
                  _Figure(
                    label: 'طلب من',
                    amountRial: totals.owedToMeRial,
                    color: Colors.green,
                  ),
                ],
              ),
              const Divider(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    totals.netRial >= 0 ? 'خالص به نفع تو' : 'خالص به ضرر تو',
                    style: theme.textTheme.bodyMedium,
                  ),
                  Text(
                    Money.format(totals.netRial.abs()),
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: totals.netRial >= 0
                          ? Colors.green
                          : theme.colorScheme.error,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Figure extends StatelessWidget {
  const _Figure({
    required this.label,
    required this.amountRial,
    required this.color,
  });

  final String label;
  final int amountRial;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: theme.textTheme.bodySmall),
          const SizedBox(height: 4),
          Text(
            Money.format(amountRial),
            style: theme.textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.bold, color: color),
          ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({
    required this.title,
    required this.direction,
    required this.debts,
  });

  final String title;
  final DebtDirection direction;
  final List<DebtWithProgress> debts;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 8, 0),
          child: Row(
            children: [
              Expanded(
                child: Text(title,
                    style: theme.textTheme.titleSmall
                        ?.copyWith(color: theme.colorScheme.primary)),
              ),
              TextButton.icon(
                icon: const Icon(Icons.add, size: 18),
                label: const Text('افزودن'),
                onPressed: () =>
                    showDebtFormSheet(context, initialDirection: direction),
              ),
            ],
          ),
        ),
        if (debts.isEmpty)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
            child: Text(
              'موردی ثبت نشده.',
              style: theme.textTheme.bodySmall
                  ?.copyWith(color: theme.colorScheme.outline),
            ),
          )
        else
          for (final entry in debts) DebtTile(entry: entry),
      ],
    );
  }
}

/// One debt row: who, how much is left, and how far along it is.
class DebtTile extends StatelessWidget {
  const DebtTile({super.key, required this.entry});

  final DebtWithProgress entry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final debt = entry.debt;
    final overdue = entry.isOverdue(DateTime.now());
    final color = entry.isSettled
        ? theme.colorScheme.outline
        : (entry.iOwe ? theme.colorScheme.error : Colors.green);

    final subtitle = [
      if (debt.title?.isNotEmpty ?? false) debt.title!,
      if (entry.isSettled)
        'تسویه شد'
      else if (debt.dueAt != null)
        '${overdue ? 'سرموعد گذشته' : 'موعد'} '
            '${JalaliUtils.formatDate(debt.dueAt!)}',
      if (!entry.isSettled && entry.paidRial > 0)
        '${Money.format(entry.paidRial)} پرداخت شده',
    ].join(' · ');

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color.withValues(alpha: 0.15),
        child: Icon(
          entry.isSettled
              ? Icons.check
              : (entry.iOwe ? Icons.north_east : Icons.south_west),
          color: color,
        ),
      ),
      title: Text(debt.personName),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (subtitle.isNotEmpty)
            Text(
              subtitle,
              style: overdue ? TextStyle(color: theme.colorScheme.error) : null,
            ),
          if (!entry.isSettled && entry.paidRial > 0) ...[
            const SizedBox(height: 6),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: entry.progress,
                minHeight: 4,
                color: color,
              ),
            ),
          ],
        ],
      ),
      isThreeLine: !entry.isSettled && entry.paidRial > 0,
      trailing: Text(
        Money.format(entry.isSettled ? debt.totalAmountRial : entry.remainingRial),
        style: TextStyle(fontWeight: FontWeight.bold, color: color),
      ),
      onTap: () => context.go('/debts/${debt.id}'),
    );
  }
}
