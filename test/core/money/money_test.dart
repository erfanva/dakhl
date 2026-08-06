import 'package:dakhl/core/money/money.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('format', () {
    test('renders Rial as Toman with Persian digits and separators', () {
      expect(Money.format(125000000), '۱۲٬۵۰۰٬۰۰۰ تومان');
    });

    test('can render in Rial', () {
      expect(
        Money.format(125000000, unit: DisplayUnit.rial),
        '۱۲۵٬۰۰۰٬۰۰۰ ریال',
      );
    });

    test('omits the label when asked', () {
      expect(Money.format(50000, withLabel: false), '۵٬۰۰۰');
    });

    test('marks negatives with a minus sign', () {
      expect(Money.format(-50000, withLabel: false), '−۵٬۰۰۰');
    });
  });

  group('formatCompact', () {
    test('abbreviates millions', () {
      expect(Money.formatCompact(125000000), '۱۲٫۵ میلیون');
    });

    test('abbreviates thousands', () {
      expect(Money.formatCompact(2500000), '۲۵۰ هزار');
    });

    test('leaves small amounts unabbreviated', () {
      expect(Money.formatCompact(5000), '۵۰۰');
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
    expect(Money.format(rial), '۳۴٬۵۰۰ تومان');
  });
}
