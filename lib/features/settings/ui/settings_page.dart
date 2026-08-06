import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/sms/sms_listener.dart';
import '../../../core/sms/sms_permissions.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncStatus = ref.watch(smsPermissionStatusProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('تنظیمات')),
      body: ListView(
        children: [
          const _SectionHeader('پیامک بانک'),
          asyncStatus.when(
            loading: () => const ListTile(
              leading: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
              title: Text('در حال بررسی دسترسی‌ها…'),
            ),
            error: (e, _) => ListTile(
              leading: const Icon(Icons.error_outline),
              title: const Text('بررسی دسترسی‌ها ناموفق بود'),
              subtitle: Text('$e'),
            ),
            data: (status) => _PermissionTiles(status: status),
          ),
          ListTile(
            leading: const Icon(Icons.checklist),
            title: const Text('راه‌اندازی خواندن پیامک'),
            subtitle: const Text('بررسی دسترسی‌ها و تنظیمات گوشی'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.go('/setup'),
          ),
          ListTile(
            leading: const Icon(Icons.rule),
            title: const Text('الگوهای پیامک بانک'),
            subtitle: const Text('افزودن یا ویرایش قواعد تشخیص'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.go('/more/settings/sms-patterns'),
          ),
          if (kDebugMode) ...[
            const _SectionHeader('ابزار توسعه'),
            ListTile(
              leading: const Icon(Icons.bug_report_outlined),
              title: const Text('تزریق پیامک'),
              subtitle: const Text('آزمایش پارسر بدون پیامک واقعی'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.go('/more/settings/sms-injector'),
            ),
          ],
        ],
      ),
    );
  }
}

class _PermissionTiles extends ConsumerWidget {
  const _PermissionTiles({required this.status});

  final SmsPermissionStatus status;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(smsPermissionsProvider);

    return Column(
      children: [
        SwitchListTile(
          value: status.notifications,
          title: const Text('اعلان‌ها'),
          subtitle: Text(status.notifications
              ? 'برای هر تراکنش اعلان می‌آید'
              : 'بدون این دسترسی اعلانی نمی‌بینی'),
          secondary: const Icon(Icons.notifications_outlined),
          onChanged: status.notifications
              ? null
              : (_) async {
                  await controller.requestNotifications();
                  ref.invalidate(smsPermissionStatusProvider);
                },
        ),
        SwitchListTile(
          value: status.sms,
          title: const Text('خواندن پیامک'),
          subtitle: Text(status.sms
              ? 'تراکنش‌ها از پیامک بانک خوانده می‌شوند'
              : 'بدون این دسترسی باید دستی ثبت کنی'),
          secondary: const Icon(Icons.sms_outlined),
          onChanged: status.sms
              ? null
              : (_) async {
                  await controller.requestSms();
                  // Registering the receiver is what actually makes SMS
                  // arrive; without this the feature stays dead until the
                  // next app launch.
                  await ref.read(smsListenerProvider).ensureStarted();
                  ref.invalidate(smsPermissionStatusProvider);
                },
        ),
        if (status.sms && !ref.watch(smsListenerProvider).isStarted)
          ListTile(
            leading: Icon(Icons.warning_amber,
                color: Theme.of(context).colorScheme.error),
            title: const Text('شنونده پیامک فعال نیست'),
            subtitle: const Text('برای فعال شدن، اپ را یک بار ببند و باز کن'),
          ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
      child: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .titleSmall
            ?.copyWith(color: Theme.of(context).colorScheme.primary),
      ),
    );
  }
}
