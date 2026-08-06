import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/db/database.dart';
import '../../../core/db/providers.dart';
import '../../transactions/providers/transactions_providers.dart';

/// How many months the trend chart looks back, including the selected one.
const trendMonthCount = 6;

/// Totals for the month currently selected on the transactions tab, so the
/// report follows the same month the user was just looking at.
final monthTotalsProvider = StreamProvider.autoDispose<MonthTotals>((ref) {
  final month = ref.watch(selectedMonthProvider);
  return ref.watch(transactionsDaoProvider).watchMonthTotals(month);
});

/// The selected month and the five before it, oldest first.
final trendTotalsProvider =
    StreamProvider.autoDispose<List<MonthTotals>>((ref) {
  final month = ref.watch(selectedMonthProvider);
  final months = [
    for (var i = trendMonthCount - 1; i >= 0; i--) month - i,
  ];
  return ref.watch(transactionsDaoProvider).watchMonthlyTotals(months);
});

/// Category breakdown for the selected month, for the given direction.
final categoryTotalsProvider =
    StreamProvider.autoDispose.family<List<CategoryTotal>, TxnType>(
  (ref, type) {
    final month = ref.watch(selectedMonthProvider);
    return ref
        .watch(transactionsDaoProvider)
        .watchCategoryTotals(month: month, type: type);
  },
);

/// Transactions belonging to a single category in the selected month —
/// backs the category detail page.
final categoryTransactionsProvider =
    StreamProvider.autoDispose.family<List<TransactionWithRefs>, int>(
  (ref, categoryId) {
    final month = ref.watch(selectedMonthProvider);
    return ref.watch(transactionsDaoProvider).watchTransactions(
          month: month,
          categoryId: categoryId,
        );
  },
);

