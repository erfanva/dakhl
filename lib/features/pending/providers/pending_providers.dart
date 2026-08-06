import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/db/database.dart';
import '../../../core/db/providers.dart';

/// Every SMS-detected transaction still awaiting categorization.
final pendingTransactionsProvider =
    StreamProvider.autoDispose<List<TransactionWithRefs>>((ref) {
  return ref
      .watch(transactionsDaoProvider)
      .watchTransactions(status: TxnStatus.pending);
});

/// A single pending transaction, kept live so the categorize sheet closes
/// cleanly if the row is confirmed or dismissed elsewhere.
final pendingTransactionProvider =
    StreamProvider.autoDispose.family<TransactionWithRefs?, int>((ref, id) {
  return ref
      .watch(transactionsDaoProvider)
      .watchTransactions(status: TxnStatus.pending)
      .map((rows) =>
          rows.where((row) => row.transaction.id == id).firstOrNull);
});
