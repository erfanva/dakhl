import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../core/db/database.dart';
import '../../../core/db/providers.dart';
import '../../../core/persian/jalali_utils.dart';

/// The Jalali month currently selected on the Transactions tab.
class SelectedMonthNotifier extends Notifier<JalaliMonth> {
  @override
  JalaliMonth build() => JalaliMonth.now();

  void next() => state = state + 1;
  void previous() => state = state - 1;
  void jumpToCurrent() => state = JalaliMonth.now();
}

final selectedMonthProvider =
    NotifierProvider<SelectedMonthNotifier, JalaliMonth>(
        SelectedMonthNotifier.new);

/// Account filter applied on top of the selected month (null = all accounts).
final accountFilterProvider = StateProvider<int?>((ref) => null);

/// Transactions for the selected month + account filter, newest first.
/// Pending items are always included so the inbox banner logic can rely
/// on the same stream.
final monthTransactionsProvider =
    StreamProvider.autoDispose<List<TransactionWithRefs>>((ref) {
  final month = ref.watch(selectedMonthProvider);
  final accountId = ref.watch(accountFilterProvider);
  final dao = ref.watch(transactionsDaoProvider);
  return dao.watchTransactions(month: month, accountId: accountId);
});

final pendingCountProvider = StreamProvider.autoDispose<int>((ref) {
  return ref.watch(transactionsDaoProvider).watchPendingCount();
});
