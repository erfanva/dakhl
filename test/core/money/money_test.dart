import 'package:dakhl/core/money/money.dart';
import 'package:flutter_test/flutter_test.dart';

/// Strips the Unicode LTR-isolate markers that [Money] wraps numbers in, so
/// assertions can read as the user sees them.
String plain(String formatted) =>
    formatted.replaceAll('\u2066', '').replaceAll('\u2069', '');

void main() {
  group('format', () {
    test('renders Rial as Toman with Persian digits and separators', () {
      expect(plain(Money.format(125000000)), '۱۲٬۵۰۰٬۰۰۰ تومان');
    });

    test('can render in Rial', () {
      expect(
        plain(Money.format(125000000, unit: DisplayUnit.rial)),
        '۱۲۵٬۰۰۰٬۰۰۰ ریال',
      );
    });

    test('omits the label when asked', () {
      expect(plain(Money.format(50000, withLabel: false)), '۵٬۰۰۰');
    });

    test('marks negatives with a minus sign', () {
      expect(plain(Money.format(-50000, withLabel: false)), '−۵٬۰۰۰');
    });

    test('isolates the digits but leaves the unit label outside', () {
      // RTL then renders the label to the left of the number, and the minus
      // stays glued to the left of the digits.
      expect(Money.format(-50000), '\u2066−۵٬۰۰۰\u2069 تومان');
    });
  });

  group('formatCompact', () {
    test('abbreviates millions', () {
      expect(plain(Money.formatCompact(125000000)), '۱۲٫۵ میلیون');
    });

    test('abbreviates thousands', () {
      expect(plain(Money.formatCompact(2500000)), '۲۵۰ هزار');
    });

    test('leaves small amounts unabbreviated', () {
      expect(plain(Money.formatCompact(5000)), '۵۰۰');
    });

    test('keeps the scale word outside the isolate', () {
      expect(Money.formatCompact(125000000), '\u2066۱۲٫۵\u2069 میلیون');
    });
  });

  group('parse', () {
    test('accepts Persian digits with separators', () {
      expect(Money.parse('۱۲٬۵۰۰'), 125000);
    });

    test('accepts latin digits with commas', () {
      expect(Money.parse('12,500'), 125000);
    });

    test('parses as Rial when told to', () {
      expect(Money.parse('12500', unit: DisplayUnit.rial), 12500);
    });

    test('returns null when there is no digit', () {
      expect(Money.parse('تومان'), isNull);
    });
  });

  test('parse and format round-trip', () {
    final rial = Money.parse('۳۴٬۵۰۰')!;
    expect(plain(Money.format(rial)), '۳۴٬۵۰۰ تومان');
  });

  test('parse accepts its own isolate-wrapped output', () {
    expect(Money.parse(Money.format(34500, withLabel: false)), 34500);
  });
}
