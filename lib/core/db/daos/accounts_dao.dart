import 'package:drift/drift.dart';

import '../database.dart';

part 'accounts_dao.g.dart';

/// An account with its computed current balance:
/// initial balance + confirmed deposits − confirmed withdrawals.
class AccountWithBalance {
  const AccountWithBalance({required this.account, required this.balanceRial});

  final Account account;
  final int balanceRial;
}

@DriftAccessor(tables: [Accounts, Transactions])
class AccountsDao extends DatabaseAccessor<AppDatabase> with _$AccountsDaoMixin {
  AccountsDao(super.db);

  Stream<List<Account>> watchAccounts({bool includeArchived = false}) {
    final query = select(accounts)
      ..orderBy([(a) => OrderingTerm.asc(a.sortOrder)]);
    if (!includeArchived) {
      query.where((a) => a.isArchived.equals(false));
    }
    return query.watch();
  }

  /// Live balances for every non-archived account, recomputed whenever
  /// the accounts or transactions tables change.
  Stream<List<AccountWithBalance>> watchAccountsWithBalances() {
    return watchAccounts().asyncMap((accountRows) async {
      final result = <AccountWithBalance>[];
      for (final account in accountRows) {
        final net = await _netConfirmedAmount(account.id);
        result.add(AccountWithBalance(
          account: account,
          balanceRial: account.initialBalanceRial + net,
        ));
      }
      return result;
    });
  }

  /// Sum of confirmed deposits minus withdrawals for [accountId]. Kept
  /// here (rather than only in TransactionsDao) so balance computation
  /// doesn't depend on cross-dao wiring quirks in generated code.
  Future<int> _netConfirmedAmount(int accountId) async {
    final deposits = await (selectOnly(transactions)
          ..addColumns([transactions.amountRial.sum()])
          ..where(transactions.accountId.equals(accountId) &
              transactions.status.equalsValue(TxnStatus.confirmed) &
              transactions.type.equalsValue(TxnType.deposit)))
        .getSingle();
    final withdrawals = await (selectOnly(transactions)
          ..addColumns([transactions.amountRial.sum()])
          ..where(transactions.accountId.equals(accountId) &
              transactions.status.equalsValue(TxnStatus.confirmed) &
              transactions.type.equalsValue(TxnType.withdrawal)))
        .getSingle();
    final depositSum = deposits.read(transactions.amountRial.sum()) ?? 0;
    final withdrawalSum = withdrawals.read(transactions.amountRial.sum()) ?? 0;
    return depositSum - withdrawalSum;
  }

  Future<int> insertAccount(AccountsCompanion entry) =>
      into(accounts).insert(entry);

  Future<bool> updateAccount(Account entry) => update(accounts).replace(entry);

  Future<void> archiveAccount(int id) {
    return (update(accounts)..where((a) => a.id.equals(id)))
        .write(const AccountsCompanion(isArchived: Value(true)));
  }

  /// Finds the account whose suffix matches the end of an SMS's account
  /// reference (e.g. card's last 4 digits), if any.
  Future<Account?> findBySuffix(String digitsFromSms) async {
    final all = await select(accounts).get();
    for (final account in all) {
      final suffix = account.accountNoSuffix;
      if (suffix != null &&
          suffix.isNotEmpty &&
          digitsFromSms.endsWith(suffix)) {
        return account;
      }
    }
    return null;
  }
}
