import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/db/daos/accounts_dao.dart';
import '../../../core/db/providers.dart';
import '../../../core/money/money.dart';
import '../providers/accounts_providers.dart';
import 'account_form_sheet.dart';

/// Account management: add, edit, and remove accounts, with live balances.
class AccountsPage extends ConsumerWidget {
  const AccountsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncAccounts = ref.watch(accountsWithBalancesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('حساب‌ها')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showAccountFormSheet(context),
        icon: const Icon(Icons.add),
        label: const Text('حساب جدید'),
      ),
      body: asyncAccounts.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('خطا در بارگذاری: $e')),
        data: (accounts) {
          if (accounts.isEmpty) {
            return const _EmptyState();
          }
          final total =
              accounts.fold<int>(0, (sum, a) => sum + a.balanceRial);

          return ListView(
            padding: const EdgeInsets.only(bottom: 88),
            children: [
              Card(
                margin: const EdgeInsets.all(16),
                child: ListTile(
                  title: const Text('موجودی کل'),
                  trailing: Text(
                    Money.format(total),
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              for (final entry in accounts) _AccountTile(entry: entry),
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
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.account_balance_wallet_outlined,
                size: 64,
                color: Theme.of(context).colorScheme.onSurfaceVariant),
            const SizedBox(height: 16),
            const Text(
              'هنوز حسابی نساخته‌ای.\n'
              'برای دیدن موجودی هر بانک، حساب‌هایت را اضافه کن.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _AccountTile extends ConsumerWidget {
  const _AccountTile({required this.entry});

  final AccountWithBalance entry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final account = entry.account;
    final subtitle = [
      if (account.bankName?.isNotEmpty ?? false) account.bankName!,
      if (account.accountNoSuffix?.isNotEmpty ?? false)
        '••${account.accountNoSuffix}',
    ].join(' · ');

    return ListTile(
      leading: const CircleAvatar(child: Icon(Icons.credit_card)),
      title: Text(account.name),
      subtitle: subtitle.isEmpty ? null : Text(subtitle),
      onTap: () => showAccountFormSheet(context, existing: account),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            Money.format(entry.balanceRial),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          PopupMenuButton<String>(
            onSelected: (action) => switch (action) {
              'edit' => showAccountFormSheet(context, existing: account),
              'delete' => _confirmDelete(context, ref),
              _ => null,
            },
            itemBuilder: (context) => const [
              PopupMenuItem(value: 'edit', child: Text('ویرایش')),
              PopupMenuItem(value: 'delete', child: Text('حذف')),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _confirmDelete(BuildContext context, WidgetRef ref) async {
    final dao = ref.read(accountsDaoProvider);
    final usage = await dao.transactionCount(entry.account.id);
    if (!context.mounted) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('حذف «${entry.account.name}»؟'),
        content: Text(
          usage == 0
              ? 'هیچ تراکنشی به این حساب وصل نیست.'
              : 'این حساب به $usage تراکنش وصل است. با حذف آن، '
                  'آن تراکنش‌ها بدون حساب می‌شوند (حذف نمی‌شوند).',
        ),
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

    if (confirmed ?? false) {
      await dao.deleteAccount(entry.account.id);
    }
  }
}
