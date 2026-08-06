import 'package:dakhl/core/db/database.dart';
import 'package:dakhl/core/sms/parser/bank_parser.dart';
import 'package:dakhl/core/sms/parser/seed_patterns.dart';
import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

/// Corpus of real-world-shaped bank SMS bodies.
///
/// Every newly encountered format should be added here — this file is the
/// parser's regression suite.
void main() {
  late AppDatabase db;
  late BankParser parser;

  setUp(() async {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    await seedSmsPatterns(db);
    parser = BankParser(await db.select(db.smsPatterns).get());
  });

  tearDown(() => db.close());

  group('withdrawals', () {
    test('parses a Mellat withdrawal with Persian digits', () {
      final result = parser.parse(
        sender: '200030',
        body: 'برداشت:۲۵۰,۰۰۰\nمانده:۱,۳۵۰,۰۰۰\nکارت:۱۲۳۴',
      );

      expect(result, isNotNull);
      expect(result!.type, TxnType.withdrawal);
      expect(result.amountRial, 250000);
      expect(result.balanceAfterRial, 1350000);
      expect(result.accountRef, '1234');
    });

    test('parses a purchase worded as خرید', () {
      final result = parser.parse(
        sender: '200060',
        body: 'خرید\nمبلغ: ۸۹۵۰۰۰ ریال\nموجودی: ۴۲۰۰۰۰۰\nحساب ۵۶۷۸',
      );

      expect(result!.type, TxnType.withdrawal);
      expect(result.amountRial, 895000);
      expect(result.accountRef, '5678');
    });

    test('handles the Arabic thousands separator', () {
      final result = parser.parse(
        sender: '20002030',
        body: 'برداشت مبلغ ۱٬۲۰۰٬۰۰۰ مانده ۳٬۰۰۰٬۰۰۰',
      );

      expect(result!.amountRial, 1200000);
      expect(result.balanceAfterRial, 3000000);
    });
  });

  group('deposits', () {
    test('parses a Melli deposit', () {
      final result = parser.parse(
        sender: '1000001',
        body: 'واریز:۵,۰۰۰,۰۰۰\nمانده:۶,۲۰۰,۰۰۰\nکارت:۹۸۷۶',
      );

      expect(result!.type, TxnType.deposit);
      expect(result.amountRial, 5000000);
      expect(result.accountRef, '9876');
    });

    test('reads the leading keyword when both directions appear', () {
      // A deposit that also names the transfer it came from — "واریز"
      // leads, so the direction is a deposit.
      final result = parser.parse(
        sender: '200080',
        body: 'واریز مبلغ ۳۰۰۰۰۰ بابت انتقال از حساب دیگر\nمانده ۹۰۰۰۰۰',
      );

      expect(result!.type, TxnType.deposit);
      expect(result.amountRial, 300000);
    });

    test('treats a leading withdrawal keyword as a withdrawal', () {
      final result = parser.parse(
        sender: '200080',
        body: 'انتقال مبلغ ۳۰۰۰۰۰ واریز به حساب مقصد\nمانده ۹۰۰۰۰۰',
      );

      expect(result!.type, TxnType.withdrawal);
    });
  });

  group('real messages', () {
    // Captured from actual bank SMS. Note the Arabic ك/ي forms, which only
    // parse because the normalizer unifies them.
    const samanPurchase = '''بانك سامان
برداشت مبلغ 1,300,000 خريدکالا
از  849-800-3897614-1
مانده 22,033,833
1405/5/13
16:27:47''';

    // Blu writes conversationally and never says "مبلغ" — the amount is
    // only identifiable by the "ریال" that follows it.
    const bluWithdrawal = '''بلو
برداشت پول
عرفان عزیز، 8,305,000 ریال از حساب شما پرید.
موجودی: 215,922,009 ریال
۲۰:۲۵
۱۴۰۵.۰۵.۱۴''';

    test('parses a Saman purchase', () {
      final result = parser.parse(sender: '200060', body: samanPurchase);

      expect(result, isNotNull);
      expect(result!.type, TxnType.withdrawal);
      expect(result.amountRial, 1300000);
      expect(result.balanceAfterRial, 22033833);
    });

    test('parses a Blu withdrawal with no amount keyword', () {
      final result = parser.parse(sender: '2000225', body: bluWithdrawal);

      expect(result, isNotNull);
      expect(result!.type, TxnType.withdrawal);
      expect(result.amountRial, 8305000);
      expect(result.balanceAfterRial, 215922009);
    });

    test('both still parse when forwarded from a personal number', () {
      // How they were first tested — the generic fallback has to carry them.
      for (final body in [samanPurchase, bluWithdrawal]) {
        final result = parser.parse(sender: '+989123456789', body: body);
        expect(result, isNotNull, reason: body.split('\n').first);
        expect(result!.type, TxnType.withdrawal);
      }
    });

    test('does not mistake the trailing date or time for an amount', () {
      final result = parser.parse(sender: '200060', body: samanPurchase);
      expect(result!.amountRial, isNot(1405));
      expect(result.amountRial, 1300000);
    });
  });

  group('sender matching', () {
    test('matches a sender written with a country prefix', () {
      final result = parser.parse(
        sender: '+98200030',
        body: 'برداشت:۱۰۰۰۰\nمانده:۵۰۰۰۰',
      );

      expect(result, isNotNull);
      expect(result!.pattern.bankName, 'بانک ملت');
    });

    test('falls back to the generic pattern for an unknown sender', () {
      final result = parser.parse(
        sender: '5000123456',
        body: 'برداشت\nمبلغ: ۷۵۰۰۰\nمانده: ۲۵۰۰۰۰',
      );

      expect(result, isNotNull);
      expect(result!.pattern.bankName, 'عمومی');
      expect(result.amountRial, 75000);
    });
  });

  group('rejections', () {
    test('returns null for a personal message', () {
      final result = parser.parse(
        sender: '+989121234567',
        body: 'سلام، فردا ساعت ۵ میبینمت',
      );

      expect(result, isNull);
    });

    test('returns null when no amount can be found', () {
      final result = parser.parse(
        sender: '200030',
        body: 'برداشت از حساب شما انجام شد',
      );

      expect(result, isNull);
    });

    test('returns null for an OTP that mentions a bank', () {
      final result = parser.parse(
        sender: '200030',
        body: 'رمز پویا: ۴۵۳۲۱۸',
      );

      expect(result, isNull);
    });
  });

  group('units', () {
    test('multiplies Toman patterns up to Rial', () async {
      await db.into(db.smsPatterns).insert(
            SmsPatternsCompanion.insert(
              bankName: 'بانک تومانی',
              senderNumbers: '["555000"]',
              depositKeywords: '["واریز"]',
              withdrawalKeywords: '["برداشت"]',
              amountRegex: r'مبلغ[:\s]*([0-9]+)',
              amountUnit: SmsAmountUnit.toman,
              priority: const Value(10),
            ),
          );
      final tomanParser = BankParser(await db.select(db.smsPatterns).get());

      final result = tomanParser.parse(
        sender: '555000',
        body: 'برداشت مبلغ ۲۵۰۰۰ تومان',
      );

      expect(result!.amountRial, 250000);
    });
  });

  group('disabled patterns', () {
    test('a disabled pattern is skipped', () async {
      await db.update(db.smsPatterns).write(
            const SmsPatternsCompanion(isEnabled: Value(false)),
          );
      final noneEnabled = BankParser(await db.select(db.smsPatterns).get());

      expect(
        noneEnabled.parse(sender: '200030', body: 'برداشت:۱۰۰۰۰'),
        isNull,
      );
    });
  });
}
