import 'package:dakhl/core/persian/digits.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('toLatinDigits', () {
    test('converts Persian digits', () {
      expect(toLatinDigits('۱۲۳۴۵۶۷۸۹۰'), '1234567890');
    });

    test('converts Arabic-Indic digits', () {
      expect(toLatinDigits('٠١٢٣٤٥٦٧٨٩'), '0123456789');
    });

    test('leaves non-digits untouched', () {
      expect(toLatinDigits('مبلغ ۲۵۰۰۰ ریال'), 'مبلغ 25000 ریال');
    });
  });

  group('toPersianDigits', () {
    test('round-trips with toLatinDigits', () {
      expect(toLatinDigits(toPersianDigits('98765')), '98765');
    });
  });

  group('unifyLetters', () {
    test('normalizes Arabic ye and kaf', () {
      expect(unifyLetters('يك'), 'یک');
    });
  });

  group('normalizeForParsing', () {
    test('strips thousands separators from a Persian amount', () {
      expect(normalizeForParsing('۲۵۰,۰۰۰'), '250000');
    });

    test('strips the Arabic thousands separator', () {
      expect(normalizeForParsing('۱۲٬۵۰۰٬۰۰۰'), '12500000');
    });

    test('normalizes a realistic bank SMS body', () {
      const sms = 'برداشت:۲۵۰,۰۰۰\nمانده:۱,۳۵۰,۰۰۰\nكارت:۱۲۳۴';
      expect(
        normalizeForParsing(sms),
        'برداشت:250000 مانده:1350000 کارت:1234',
      );
    });
  });
}
