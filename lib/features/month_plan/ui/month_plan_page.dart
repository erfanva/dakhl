import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/db/database.dart';
import '../../../core/db/providers.dart';
import '../../../core/money/money.dart';
import '../../../core/persian/jalali_utils.dart';
import '../../../shared/ui/month_switcher.dart';
import '../../categories/category_style.dart';
import '../../reminders/ui/reminder_rules_sheet.dart';
import '../providers/month_plan_providers.dart';
import 'recurring_form_sheet.dart';
import 'settle_occurrence_dialog.dart';

/// The month plan: fixed income and fixed expenses for the selected month,
/// each row either still due, settled into a real transaction, or skipped.
class MonthPlanPage extends ConsumerWidget {
  const MonthPlanPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncPlan = ref.watch(monthPlanProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('برنامه ماه')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showRecurringFormSheet(context),
        tooltip: 'افزودن ثابت',
        child: const Icon(Icons.add),
      ),
      body: asyncPlan.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('خطا در بارگذاری: $error')),
        data: (plan) => ListView(
          padding: const EdgeInsets.only(bottom: 96),
          children: [
            const MonthSwitcher(),
            if (plan.isEmpty)
              const _EmptyState()
            else
              _PlanSummary(plan: plan),
            _Section(
              title: 'درآمدهای ثابت',
              kind: OwnerKind.recurringIncome,
              entries: plan.incomes,
            ),
            _Section(
              title: 'هزینه‌های ثابت',
              kind: OwnerKind.recurringExpense,
              entries: plan.expenses,
            ),
          ],
        ),
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
      padding: const EdgeInsets.fromLTRB(32, 32, 32, 8),
      child: Column(
        children: [
          Icon(Icons.event_repeat,
              size: 56, color: theme.colorScheme.outline),
          const SizedBox(height: 16),
          Text(
            'درآمدها و هزینه‌های تکرارشونده‌ات را یک بار ثبت کن؛\n'
            'هر ماه خودش اینجا می‌آید و فقط تیکش را می‌زنی.',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium
                ?.copyWith(color: theme.colorScheme.outline),
          ),
        ],
      ),
    );
  }
}

class _PlanSummary extends StatelessWidget {
  const _PlanSummary({required this.plan});

  final MonthPlan plan;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final net = plan.plannedNetRial;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  _SummaryFigure(
                    label: 'درآمد ثابت',
                    amountRial: plan.plannedIncomeRial,
                    color: Colors.green,
                  ),
                  _SummaryFigure(
                    label: 'هزینه ثابت',
                    amountRial: plan.plannedExpenseRial,
                    color: theme.colorScheme.error,
                  ),
                ],
              ),
              const Divider(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(net >= 0 ? 'باقی‌مانده برنامه' : 'کسری برنامه',
                      style: theme.textTheme.bodyMedium),
                  Text(
                    Money.format(net),
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: net >= 0 ? Colors.green : theme.colorScheme.error,
                    ),
                  ),
                ],
              ),
              if (plan.outstandingExpenseRial > 0) ...[
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('هزینه‌های پرداخت‌نشده',
                        style: theme.textTheme.bodyMedium),
                    Text(Money.format(plan.outstandingExpenseRial),
                        style: theme.textTheme.bodyMedium),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _SummaryFigure extends StatelessWidget {
  const _SummaryFigure({
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
    required this.kind,
    required this.entries,
  });

  final String title;
  final OwnerKind kind;
  final List<PlannedEntry> entries;

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
                    showRecurringFormSheet(context, initialKind: kind),
              ),
            ],
          ),
        ),
        if (entries.isEmpty)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
            child: Text(
              kind == OwnerKind.recurringIncome
                  ? 'درآمد ثابتی برای این ماه ثبت نشده.'
                  : 'هزینه ثابتی برای این ماه ثبت نشده.',
              style: theme.textTheme.bodySmall
                  ?.copyWith(color: theme.colorScheme.outline),
            ),
          )
        else
          for (final entry in entries) _EntryTile(entry: entry),
      ],
    );
  }
}

class _EntryTile extends ConsumerWidget {
  const _EntryTile({required this.entry});

  final PlannedEntry entry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final item = entry.item;
    final overdue = entry.isOverdue(DateTime.now());
    final directionColor =
        item.isIncome ? Colors.green : theme.colorScheme.error;

    final (icon, iconColor) = switch (entry.status) {
      OccurrenceStatus.done => (Icons.check, Colors.green),
      OccurrenceStatus.skipped => (Icons.remove, theme.colorScheme.outline),
      OccurrenceStatus.due => (
          entry.category?.icon ?? Icons.event_repeat,
          overdue ? theme.colorScheme.error : directionColor,
        ),
    };

    final dueDate = JalaliUtils.formatDate(entry.dueAt);
    final status = switch (entry.status) {
      OccurrenceStatus.done => 'ثبت شد · '
          '${JalaliUtils.formatDate(entry.occurrence.resolvedAt ?? entry.dueAt)}',
      OccurrenceStatus.skipped => 'این ماه رد شد',
      OccurrenceStatus.due =>
        overdue ? 'عقب‌افتاده · موعد $dueDate' : 'موعد $dueDate',
    };

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: iconColor.withValues(alpha: 0.15),
        child: Icon(icon, color: iconColor),
      ),
      title: Text(
        item.title,
        style: entry.isSkipped
            ? const TextStyle(decoration: TextDecoration.lineThrough)
            : null,
      ),
      subtitle: Text(
        [
          status,
          if (!item.isActive) 'غیرفعال',
        ].join(' · '),
        style: overdue ? TextStyle(color: theme.colorScheme.error) : null,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            Money.format(entry.amountRial),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: entry.isSkipped ? theme.colorScheme.outline : directionColor,
            ),
          ),
          PopupMenuButton<String>(
            onSelected: (action) => _handle(context, ref, action),
            itemBuilder: (context) => [
              if (entry.isDue)
                PopupMenuItem(
                  value: 'settle',
                  child: Text(item.isIncome ? 'ثبت دریافت' : 'ثبت پرداخت'),
                ),
              if (entry.isDue)
                const PopupMenuItem(
                    value: 'skip', child: Text('این ماه را رد کن')),
              if (!entry.isDue)
                const PopupMenuItem(
                    value: 'reopen', child: Text('بازگرداندن به موعد')),
              const PopupMenuItem(
                  value: 'reminders', child: Text('یادآورها')),
              const PopupMenuItem(value: 'edit', child: Text('ویرایش')),
              const PopupMenuItem(value: 'delete', child: Text('حذف')),
            ],
          ),
        ],
      ),
      onTap: () => _handle(context, ref, entry.isDue ? 'settle' : 'reopen'),
    );
  }

  Future<void> _handle(
      BuildContext context, WidgetRef ref, String action) async {
    final dao = ref.read(recurringDaoProvider);
    switch (action) {
      case 'settle':
        await showSettleOccurrenceDialog(context, entry: entry);
      case 'skip':
        await dao.skip(entry.occurrence.id);
      case 'reopen':
        if (await _confirmReopen(context)) {
          await dao.reopen(entry.occurrence.id);
        }
      case 'reminders':
        await showReminderRulesSheet(
          context,
          ownerKind: entry.item.kind,
          ownerId: entry.item.id,
          ownerTitle: entry.item.title,
        );
      case 'edit':
        await showRecurringFormSheet(context, existing: entry.item);
      case 'delete':
        if (await _confirmDelete(context)) {
          await dao.deleteItem(entry.item.kind, entry.item.id);
        }
    }
  }

  /// Reopening deletes the transaction the occurrence generated, so it needs
  /// saying out loud.
  Future<bool> _confirmReopen(BuildContext context) async {
    if (entry.isSkipped) return true;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('بازگرداندن «${entry.item.title}»؟'),
        content: const Text(
            'تراکنشی که با ثبت این مورد ساخته شد حذف می‌شود و دوباره در '
            'انتظار ثبت قرار می‌گیرد.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('انصراف'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('بازگردان'),
          ),
        ],
      ),
    );
    return confirmed ?? false;
  }

  Future<bool> _confirmDelete(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('حذف «${entry.item.title}»؟'),
        content: const Text(
            'این مورد و موعدهای ثبت‌نشده‌اش حذف می‌شوند. تراکنش‌هایی که '
            'قبلاً ثبت شده‌اند سر جایشان می‌مانند.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('انصراف'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('حذف'),
          ),
        ],
      ),
    );
    return confirmed ?? false;
  }
}
