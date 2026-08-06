import '../persian/digits.dart';

/// Currency the user sees. Amounts are always *stored* in Rial.
enum DisplayUnit {
  toman(divisor: 10, label: 'تومان'),
  rial(divisor: 1, label: 'ریال');

  const DisplayUnit({required this.divisor, required this.label});

  final int divisor;
  final String label;
}

/// Formatting and parsing of money values.
///
/// Everything in the database is an `int` count of Rial. Display converts
/// to the user's chosen unit and renders with Persian digits and the
/// Arabic thousands separator (٬), e.g. `۱۲٬۵۰۰٬۰۰۰ تومان`.
abstract final class Money {
  static const _thousandsSeparator = '٬';

  /// Formats a Rial amount for display, e.g. `۱۲٬۵۰۰٬۰۰۰ تومان`.
  static String format(
    int amountRial, {
    DisplayUnit unit = DisplayUnit.toman,
    bool withLabel = true,
    bool signed = false,
  }) {
    final negative = amountRial < 0;
    final value = amountRial.abs() ~/ unit.divisor;
    final grouped = groupDigits(value.toString());
    final sign = negative ? '−' : (signed ? '+' : '');
    final body = '$sign${toPersianDigits(grouped)}';
    return withLabel ? '$body ${unit.label}' : body;
  }

  /// Formats without a unit label — for compact chips and chart axes.
  static String formatCompact(int amountRial,
      {DisplayUnit unit = DisplayUnit.toman}) {
    final value = amountRial.abs() ~/ unit.divisor;
    final sign = amountRial < 0 ? '−' : '';
    if (value >= 1000000000) {
      return '$sign${toPersianDigits(_trim(value / 1000000000))} میلیارد';
    }
    if (value >= 1000000) {
      return '$sign${toPersianDigits(_trim(value / 1000000))} میلیون';
    }
    if (value >= 1000) {
      return '$sign${toPersianDigits(_trim(value / 1000))} هزار';
    }
    return '$sign${toPersianDigits(value.toString())}';
  }

  /// Inserts thousands separators into a latin digit string.
  static String groupDigits(String digits) {
    final buffer = StringBuffer();
    for (var i = 0; i < digits.length; i++) {
      if (i > 0 && (digits.length - i) % 3 == 0) {
        buffer.write(_thousandsSeparator);
      }
      buffer.write(digits[i]);
    }
    return buffer.toString();
  }

  /// Parses user input (Persian or latin digits, with or without
  /// separators) in [unit] into a Rial amount. Returns null if there is
  /// no digit in the input.
  static int? parse(String input, {DisplayUnit unit = DisplayUnit.toman}) {
    final digits = toLatinDigits(input).replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.isEmpty) return null;
    final value = int.tryParse(digits);
    if (value == null) return null;
    return value * unit.divisor;
  }

  static String _trim(double value) {
    final rounded = value.toStringAsFixed(1);
    final trimmed = rounded.endsWith('.0')
        ? rounded.substring(0, rounded.length - 2)
        : rounded;
    // Persian uses ٫ (U+066B) as the decimal separator, not a period.
    return trimmed.replaceAll('.', '٫');
  }
}
