import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/setup/device_setup.dart';

/// Persistent reminder on the transactions tab while SMS capture can't
/// work. Stays until the setup is actually complete, because a silently
/// broken SMS feature is worse than a visible nag — that's exactly the
/// failure this whole screen exists to prevent.
class SetupBanner extends ConsumerWidget {
  const SetupBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(setupStatusProvider).value;
    if (status == null || status.isComplete) return const SizedBox.shrink();

    final theme = Theme.of(context);
    final missing = status.unsatisfied.length;

    return Material(
      color: theme.colorScheme.errorContainer,
      child: InkWell(
        onTap: () => context.go('/setup'),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Icon(Icons.sms_failed_outlined,
                  color: theme.colorScheme.onErrorContainer),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'خواندن خودکار پیامک بانک فعال نیست',
                      style: TextStyle(
                        color: theme.colorScheme.onErrorContainer,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '$missing مورد باقی مانده — برای راه‌اندازی بزن',
                      style: TextStyle(
                        color: theme.colorScheme.onErrorContainer,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right,
                  color: theme.colorScheme.onErrorContainer),
            ],
          ),
        ),
      ),
    );
  }
}
