import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/db/database.dart';
import '../../../core/db/providers.dart';
import '../../transactions/providers/transactions_providers.dart';

/// The plan for the month selected app-wide. Watching it also materializes
/// that month's occurrences, so opening the tab is what fills the month in.
final monthPlanProvider = StreamProvider.autoDispose<MonthPlan>((ref) {
  final month = ref.watch(selectedMonthProvider);
  return ref.watch(recurringDaoProvider).watchMonthPlan(month);
});

/// Every recurring item including the switched-off ones — the management
/// list, as opposed to [monthPlanProvider]'s view of a single month.
final recurringItemsProvider =
    StreamProvider.autoDispose<List<RecurringItem>>((ref) {
  return ref.watch(recurringDaoProvider).watchItems(includeInactive: true);
});

/// Unsettled occurrences already past their due date, across every month —
/// what the overdue badge counts.
final overdueEntriesProvider =
    StreamProvider.autoDispose<List<PlannedEntry>>((ref) {
  return ref.watch(recurringDaoProvider).watchOutstanding(until: DateTime.now());
});
