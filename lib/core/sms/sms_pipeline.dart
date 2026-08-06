import 'package:drift/drift.dart';

import '../db/database.dart';
import '../money/money.dart';
import '../notifications/notification_service.dart';
import 'parser/bank_parser.dart';
import 'parser/normalizer.dart';

/// What the pipeline did with one SMS. Returned so the debug injector can
/// show it and tests can assert on it.
enum SmsOutcome {
  /// Not bank-like — nothing was stored.
  ignored,

  /// Parsed into a pending transaction.
  parsed,

  /// Looked like a bank SMS but no pattern matched; a pending transaction
  /// with a zero amount was created for manual completion.
  unrecognized,
}

class SmsResult {
  const SmsResult({required this.outcome, this.transactionId, this.parsed});

  final SmsOutcome outcome;
  final int? transactionId;
  final ParsedSms? parsed;
}

/// Turns an incoming bank SMS into a pending transaction plus a
/// notification.
///
/// This is the single entry point for SMS handling: the background
/// broadcast handler and the debug injector both call [handle], so what you
/// test on a desk is exactly what runs when a real SMS arrives.
class SmsPipeline {
  const SmsPipeline({required this.db, required this.notifications});

  final AppDatabase db;
  final NotificationService notifications;

  Future<SmsResult> handle({
    required String sender,
    required String body,
    required DateTime receivedAt,
  }) async {
    final normalized = normalizeSmsBody(body);
    final patterns = await db.select(db.smsPatterns).get();

    // Cheap rejection before touching anything else: a message that neither
    // comes from a known bank sender nor contains banking vocabulary is
    // almost certainly personal, and shouldn't be stored at all.
    final knownSender = _isKnownSender(sender, patterns);
    if (!knownSender && !looksLikeBankSms(normalized)) {
      return const SmsResult(outcome: SmsOutcome.ignored);
    }

    final parsed = BankParser(patterns).parse(sender: sender, body: body);

    final rawSmsId = await db.into(db.rawSms).insert(
          RawSmsCompanion.insert(
            sender: sender,
            body: body,
            receivedAt: receivedAt,
            parseStatus: parsed == null
                ? SmsParseStatus.unparsedBankLike
                : SmsParseStatus.parsed,
            matchedPatternId: Value(parsed?.pattern.id),
          ),
        );

    if (parsed == null) {
      final id = await _insertPending(
        rawSmsId: rawSmsId,
        receivedAt: receivedAt,
        // Direction and amount are unknown; the user fills them in from the
        // categorize sheet. Defaulting to a withdrawal is the safer guess
        // for an unrecognized bank SMS.
        type: TxnType.withdrawal,
        amountRial: 0,
      );
      await notifications.showPendingTransaction(
        transactionId: id,
        title: 'پیامک بانکی ناشناخته',
        body: 'برای ثبت دستی بزن',
      );
      return SmsResult(outcome: SmsOutcome.unrecognized, transactionId: id);
    }

    final accountId = parsed.accountRef == null
        ? null
        : (await db.accountsDao.findBySuffix(parsed.accountRef!))?.id;

    final id = await _insertPending(
      rawSmsId: rawSmsId,
      receivedAt: receivedAt,
      type: parsed.type,
      amountRial: parsed.amountRial,
      accountId: accountId,
      balanceAfterRial: parsed.balanceAfterRial,
    );

    if (parsed.balanceAfterRial != null && accountId != null) {
      await _recordReportedBalance(
        accountId: accountId,
        balanceRial: parsed.balanceAfterRial!,
        at: receivedAt,
      );
    }

    await notifications.showPendingTransaction(
      transactionId: id,
      title: '${parsed.type == TxnType.deposit ? 'واریز' : 'برداشت'} '
          '${Money.format(parsed.amountRial)}',
      body: '${parsed.pattern.bankName} — برای دسته‌بندی بزن',
    );

    return SmsResult(
      outcome: SmsOutcome.parsed,
      transactionId: id,
      parsed: parsed,
    );
  }

  Future<int> _insertPending({
    required int rawSmsId,
    required DateTime receivedAt,
    required TxnType type,
    required int amountRial,
    int? accountId,
    int? balanceAfterRial,
  }) {
    return db.transactionsDao.insertTransaction(
      buildTransactionCompanion(
        type: type,
        amountRial: amountRial,
        occurredAt: receivedAt,
        status: TxnStatus.pending,
        source: TxnSource.sms,
        accountId: accountId,
        rawSmsId: rawSmsId,
        balanceAfterRial: balanceAfterRial,
      ),
    );
  }

  /// Stores the bank's own balance figure so the accounts screen can flag a
  /// mismatch against the balance derived from recorded transactions.
  Future<void> _recordReportedBalance({
    required int accountId,
    required int balanceRial,
    required DateTime at,
  }) {
    return (db.update(db.accounts)..where((a) => a.id.equals(accountId))).write(
      AccountsCompanion(
        lastSmsBalanceRial: Value(balanceRial),
        lastSmsBalanceAt: Value(at),
      ),
    );
  }

  bool _isKnownSender(String sender, List<SmsPattern> patterns) {
    final parser = BankParser(patterns);
    // Reuse the parser's sender matching, but ignore the catch-all pattern
    // (empty sender list) which would match everything.
    return patterns.any((pattern) {
      if (pattern.senderNumbers.replaceAll(RegExp(r'[\[\]\s"]'), '').isEmpty) {
        return false;
      }
      return parser.senderMatches(pattern, sender);
    });
  }
}
