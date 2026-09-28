import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/db/database.dart';
import '../../../core/db/providers.dart';
import '../../../core/money/money.dart';
import '../../../core/persian/jalali_utils.dart';
import '../../reminders/ui/reminder_rules_sheet.dart';
import '../providers/debts_providers.dart';
import 'debt_form_sheet.dart';
import 'debt_payment_dialog.dart';

/// A single debt: its progress, and the payments made against it.
class DebtDetailPage extends ConsumerWidget {
  const DebtDetailPage({super.key, required this.debtId});

  final int debtId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncDebt = ref.watch(debtProvider(debtId));

    return asyncDebt.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, _) => Scaffold(
        appBar: AppBar(),
        body: Center(child: Text('خطا در بارگذاری: $error')),
      ),
      data: (entry) {
        // Deleted from under us (or a stale deep link).
        if (entry == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('بدهی و طلب')),
            body: const Center(child: Text('این مورد دیگر وجود ندارد.')),
          );
        }
        return _DebtDetail(entry: entry);
      },
    );
  }
}

class _DebtDetail extends ConsumerWidget {
  const _DebtDetail({required this.entry});

  final DebtWithProgress entry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final debt = entry.debt;
    final payments = ref.watch(debtPaymentsProvider(debt.id)).value ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text(debt.personName),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            tooltip: 'ویرایش',
            onPressed: () => showDebtFormSheet(context, existing: entry),
          ),
          PopupMenuButton<String>(
            onSelected: (action) => _handle(context, ref, action),
            itemBuilder: (context) => [
              const PopupMenuItem(
                  value: 'reminders', child: Text('یادآورها')),
              PopupMenuItem(
                value: 'toggle-settled',
                child: Text(entry.isSettled
                    ? 'برگرداندن به باز'
                    : 'تسویه‌شده علامت بزن'),
              ),
              const PopupMenuItem(value: 'delete', child: Text('حذف')),
            ],
          ),
        ],
      ),
      floatingActionButton: entry.isSettled
          ? null
          : FloatingActionButton.extended(
              onPressed: () => showDebtPaymentDialog(context, entry: entry),
              icon: const Icon(Icons.add),
              label: Text(entry.iOwe ? 'ثبت پرداخت' : 'ثبت دریافت'),
            ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 96),
        children: [
          _SummaryCard(entry: entry),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 4),
            child: Text(
              entry.iOwe ? 'پرداخت‌ها' : 'دریافت‌ها',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(color: Theme.of(context).colorScheme.primary),
            ),
          ),
          if (payments.isEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
              child: Text(
                'هنوز چیزی ثبت نشده.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.outline),
              ),
            )
          else
            for (final payment in payments)
              _PaymentTile(entry: entry, payment: payment),
        ],
      ),
    );
  }

  Future<void> _handle(
      BuildContext context, WidgetRef ref, String action) async {
    final dao = ref.read(debtsDaoProvider);
    switch (action) {
      case 'reminders':
        if (entry.debt.dueAt == null) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('برای یادآور، اول یک موعد برای این مورد تعیین کن'),
          ));
          return;
        }
        await showReminderRulesSheet(
          context,
          ownerKind: OwnerKind.debt,
          ownerId: entry.debt.id,
          ownerTitle: entry.debt.personName,
        );
      case 'toggle-settled':
        await dao.setSettled(entry.debt.id, !entry.isSettled);
      case 'delete':
        if (await _confirmDelete(context)) {
          await dao.deleteDebt(entry.debt.id);
          if (context.mounted) Navigator.of(context).pop();
        }
    }
  }

  Future<bool> _confirmDelete(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('حذف «${entry.debt.personName}»؟'),
        content: const Text(
            'این مورد و سابقه پرداخت‌هایش حذف می‌شود. تراکنش‌هایی که در '
            'دفتر ثبت شده‌اند باقی می‌مانند.'),
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

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({required this.entry});

  final DebtWithProgress entry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final debt = entry.debt;
    final overdue = entry.isOverdue(DateTime.now());
    final color = entry.isSettled
        ? theme.colorScheme.outline
        : (entry.iOwe ? theme.colorScheme.error : Colors.green);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                entry.isSettled
                    ? 'تسویه شده'
                    : (entry.iOwe ? 'باقی‌مانده بدهی' : 'باقی‌مانده طلب'),
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 4),
              Text(
                Money.format(entry.remainingRial),
                style: theme.textTheme.headlineMedium
                    ?.copyWith(fontWeight: FontWeight.bold, color: color),
              ),
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: entry.progress,
                  minHeight: 6,
                  color: color,
                ),
              ),
              const SizedBox(height: 12),
              _Row(label: 'مبلغ کل', value: Money.format(debt.totalAmountRial)),
              _Row(label: 'پرداخت‌شده', value: Money.format(entry.paidRial)),
              if (debt.dueAt != null)
                _Row(
                  label: 'موعد',
                  value: JalaliUtils.formatDate(debt.dueAt!),
                  color: overdue ? theme.colorScheme.error : null,
                ),
              if (debt.title?.isNotEmpty ?? false)
                _Row(label: 'بابت', value: debt.title!),
              if (debt.note?.isNotEmpty ?? false)
                _Row(label: 'توضیحات', value: debt.note!),
            ],
          ),
        ),
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({required this.label, required this.value, this.color});

  final String label;
  final String value;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: theme.textTheme.bodySmall),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: theme.textTheme.bodyMedium?.copyWith(color: color),
            ),
          ),
        ],
      ),
    );
  }
}

class _PaymentTile extends ConsumerWidget {
  const _PaymentTile({required this.entry, required this.payment});

  final DebtWithProgress entry;
  final DebtPaymentWithTxn payment;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final row = payment.payment;
    final subtitle = [
      JalaliUtils.formatDate(row.paidAt),
      if (row.note?.isNotEmpty ?? false) row.note!,
      // Says whether this payment also moved the ledger, which is the part
      // users second-guess.
      if (payment.transaction == null) 'بدون تراکنش',
    ].join(' · ');

    return ListTile(
      leading: const CircleAvatar(child: Icon(Icons.payments_outlined)),
      title: Text(Money.format(row.amountRial)),
      subtitle: Text(subtitle),
      trailing: IconButton(
        icon: const Icon(Icons.delete_outline),
        tooltip: 'حذف',
        onPressed: () async {
          if (await _confirmDelete(context)) {
            await ref.read(debtsDaoProvider).deletePayment(row.id);
          }
        },
      ),
    );
  }

  Future<bool> _confirmDelete(BuildContext context) async {
    final hasTransaction = payment.transaction != null;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('حذف این پرداخت؟'),
        content: Text(hasTransaction
            ? 'تراکنش ثبت‌شده در دفتر هم حذف می‌شود.'
            : 'این پرداخت از سابقه حذف می‌شود.'),
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
