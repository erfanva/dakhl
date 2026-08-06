import 'package:dakhl/core/db/database.dart';
import 'package:dakhl/core/notifications/notification_service.dart';
import 'package:dakhl/core/sms/sms_pipeline.dart';
import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

/// Captures notifications instead of showing them, so the pipeline can be
/// exercised without a platform channel.
class _FakeNotifications implements NotificationService {
  final shown = <({int id, String title, String body})>[];

  @override
  Future<void> showPendingTransaction({
    required int transactionId,
    required String title,
    required String body,
  }) async {
    shown.add((id: transactionId, title: title, body: body));
  }

  @override
  Future<void> init() async {}

  @override
  Future<void> captureLaunchPayload() async {}

  @override
  Future<bool> requestPermission() async => true;

  @override
  Future<void> cancel(int id) async {}

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  late AppDatabase db;
  late _FakeNotifications notifications;
  late SmsPipeline pipeline;

  setUp(() async {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    // Touch the db so onCreate (which seeds patterns) has run.
    await db.select(db.smsPatterns).get();
    notifications = _FakeNotifications();
    pipeline = SmsPipeline(db: db, notifications: notifications);
  });

  tearDown(() => db.close());

  Future<SmsResult> handle(String sender, String body) {
    return pipeline.handle(
      sender: sender,
      body: body,
      receivedAt: DateTime(2026, 8, 6, 14, 30),
    );
  }

  group('parsed bank SMS', () {
    test('creates a pending transaction and notifies', () async {
      final result =
          await handle('200030', 'برداشت:۲۵۰,۰۰۰\nمانده:۱,۳۵۰,۰۰۰\nکارت:۱۲۳۴');

      expect(result.outcome, SmsOutcome.parsed);
      expect(result.transactionId, isNotNull);

      final row = await db.transactionsDao.findById(result.transactionId!);
      expect(row!.transaction.status, TxnStatus.pending);
      expect(row.transaction.source, TxnSource.sms);
      expect(row.transaction.type, TxnType.withdrawal);
      expect(row.transaction.amountRial, 250000);
      expect(row.transaction.balanceAfterRial, 1350000);
      expect(row.transaction.rawSmsId, isNotNull);

      expect(notifications.shown, hasLength(1));
      expect(notifications.shown.single.id, result.transactionId);
      expect(notifications.shown.single.title, contains('برداشت'));
    });

    test('does not count toward balances until confirmed', () async {
      final accountId = await db.accountsDao.insertAccount(
        AccountsCompanion.insert(
          name: 'کارت ملت',
          accountNoSuffix: const Value('1234'),
          initialBalanceRial: const Value(5000000),
          createdAt: DateTime.now(),
        ),
      );

      await handle('200030', 'برداشت:۲۵۰,۰۰۰\nمانده:۱,۳۵۰,۰۰۰\nکارت:۱۲۳۴');

      final balances = await db.accountsDao.watchAccountsWithBalances().first;
      expect(balances.single.account.id, accountId);
      expect(balances.single.balanceRial, 5000000);
    });

    test('attaches the transaction to the account matching the card suffix',
        () async {
      final accountId = await db.accountsDao.insertAccount(
        AccountsCompanion.insert(
          name: 'کارت ملت',
          accountNoSuffix: const Value('1234'),
          createdAt: DateTime.now(),
        ),
      );

      final result =
          await handle('200030', 'برداشت:۲۵۰,۰۰۰\nمانده:۱,۳۵۰,۰۰۰\nکارت:۱۲۳۴');

      final row = await db.transactionsDao.findById(result.transactionId!);
      expect(row!.transaction.accountId, accountId);

      // The bank's own balance figure is stored for the reconciliation hint.
      final account = await db.accountsDao.findById(accountId);
      expect(account!.lastSmsBalanceRial, 1350000);
      expect(account.lastSmsBalanceAt, isNotNull);
    });

    test('leaves the account null when no suffix matches', () async {
      await db.accountsDao.insertAccount(
        AccountsCompanion.insert(
          name: 'کارت دیگر',
          accountNoSuffix: const Value('9999'),
          createdAt: DateTime.now(),
        ),
      );

      final result =
          await handle('200030', 'برداشت:۲۵۰,۰۰۰\nمانده:۱,۳۵۰,۰۰۰\nکارت:۱۲۳۴');

      final row = await db.transactionsDao.findById(result.transactionId!);
      expect(row!.transaction.accountId, isNull);
    });

    test('stores the raw SMS as parsed', () async {
      await handle('200030', 'برداشت:۲۵۰,۰۰۰\nمانده:۱,۳۵۰,۰۰۰');

      final raw = await db.select(db.rawSms).getSingle();
      expect(raw.parseStatus, SmsParseStatus.parsed);
      expect(raw.matchedPatternId, isNotNull);
      // The original body is kept verbatim for re-parsing later.
      expect(raw.body, contains('۲۵۰,۰۰۰'));
    });
  });

  group('bank-like but unparsed', () {
    test('creates a zero-amount pending row for manual completion', () async {
      final result = await handle('200030', 'تراکنش شما با موفقیت انجام شد');

      expect(result.outcome, SmsOutcome.unrecognized);
      final row = await db.transactionsDao.findById(result.transactionId!);
      expect(row!.transaction.amountRial, 0);
      expect(row.transaction.status, TxnStatus.pending);

      final raw = await db.select(db.rawSms).getSingle();
      expect(raw.parseStatus, SmsParseStatus.unparsedBankLike);

      expect(notifications.shown.single.title, contains('ناشناخته'));
    });
  });

  group('non-bank SMS', () {
    test('is ignored without storing anything', () async {
      final result =
          await handle('+989121234567', 'سلام، فردا ساعت ۵ میبینمت');

      expect(result.outcome, SmsOutcome.ignored);
      expect(result.transactionId, isNull);
      expect(await db.select(db.rawSms).get(), isEmpty);
      expect(await db.select(db.transactions).get(), isEmpty);
      expect(notifications.shown, isEmpty);
    });

    test('an OTP from a bank sender is stored but not turned into money',
        () async {
      // Known sender, so it is recorded — but no amount means no guess at a
      // transaction value.
      final result = await handle('200030', 'رمز پویا: ۴۵۳۲۱۸');

      expect(result.outcome, SmsOutcome.unrecognized);
      final row = await db.transactionsDao.findById(result.transactionId!);
      expect(row!.transaction.amountRial, 0);
    });
  });

  test('pending count reflects what the inbox will show', () async {
    await handle('200030', 'برداشت:۱۰۰۰۰\nمانده:۵۰۰۰۰');
    await handle('1000001', 'واریز:۲۰۰۰۰\nمانده:۷۰۰۰۰');
    await handle('+989121234567', 'سلام');

    expect(await db.transactionsDao.watchPendingCount().first, 2);
  });
}
