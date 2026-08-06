import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/db/database.dart';
import '../../../core/db/providers.dart';

final accountsProvider =
    StreamProvider.autoDispose<List<Account>>((ref) {
  return ref.watch(accountsDaoProvider).watchAccounts();
});

final accountsWithBalancesProvider =
    StreamProvider.autoDispose<List<AccountWithBalance>>((ref) {
  return ref.watch(accountsDaoProvider).watchAccountsWithBalances();
});
