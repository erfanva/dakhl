import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../core/db/database.dart';
import '../../../core/db/providers.dart';

/// Whether settled debts are shown alongside the open ones.
final showSettledDebtsProvider = StateProvider<bool>((ref) => false);

final debtsProvider =
    StreamProvider.autoDispose<List<DebtWithProgress>>((ref) {
  final includeSettled = ref.watch(showSettledDebtsProvider);
  return ref
      .watch(debtsDaoProvider)
      .watchDebts(includeSettled: includeSettled);
});

/// Outstanding totals in both directions, for the header card.
final debtTotalsProvider = StreamProvider.autoDispose<DebtTotals>((ref) {
  return ref.watch(debtsDaoProvider).watchTotals();
});

/// A single debt, kept live so the detail page follows payments and edits.
final debtProvider =
    StreamProvider.autoDispose.family<DebtWithProgress?, int>((ref, id) {
  return ref.watch(debtsDaoProvider).watchDebt(id);
});

final debtPaymentsProvider =
    StreamProvider.autoDispose.family<List<DebtPaymentWithTxn>, int>((ref, id) {
  return ref.watch(debtsDaoProvider).watchPayments(id);
});
