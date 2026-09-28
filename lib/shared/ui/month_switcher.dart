import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/persian/jalali_utils.dart';
import '../../features/transactions/providers/transactions_providers.dart';

/// The prev/next month header. Every tab that reads [selectedMonthProvider]
/// shows the same one, so switching months on one tab carries to the others.
class MonthSwitcher extends ConsumerWidget {
  const MonthSwitcher({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final month = ref.watch(selectedMonthProvider);
    final notifier = ref.read(selectedMonthProvider.notifier);
    final isCurrent = month == JalaliMonth.now();

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
          // Tapping the label is the way back after browsing older months.
          // An InkWell rather than a TextButton so the label keeps its normal
          // colour on the current month instead of rendering as disabled.
          InkWell(
            onTap: isCurrent ? null : notifier.jumpToCurrent,
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Text(
                month.label,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
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
