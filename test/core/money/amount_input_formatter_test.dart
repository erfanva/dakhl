import 'package:dakhl/core/money/amount_input_formatter.dart';
import 'package:dakhl/core/money/money.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

/// Runs the formatter the way a TextField would: old value → new value.
String applyFormatter(String input, {String previous = ''}) {
  const formatter = PersianAmountInputFormatter();
  return formatter
      .formatEditUpdate(
        TextEditingValue(text: previous),
        TextEditingValue(
          text: input,
          selection: TextSelection.collapsed(offset: input.length),
        ),
      )
      .text;
}

void main() {
  test('converts latin keypad input to grouped Persian digits', () {
    expect(applyFormatter('12500'), '۱۲٬۵۰۰');
  });

  test('groups large amounts', () {
    expect(applyFormatter('125000000'), '۱۲۵٬۰۰۰٬۰۰۰');
  });

  test('leaves short numbers ungrouped', () {
    expect(applyFormatter('500'), '۵۰۰');
  });

  test('accepts Persian digits already typed', () {
    expect(applyFormatter('۱۲۵۰۰'), '۱۲٬۵۰۰');
  });

  test('ignores stray non-digits', () {
    expect(applyFormatter('12,500 تومان'), '۱۲٬۵۰۰');
  });

  test('strips leading zeros but keeps a lone zero', () {
    expect(applyFormatter('00123'), '۱۲۳');
    expect(applyFormatter('0'), '۰');
  });

  test('clearing the field yields an empty value', () {
    expect(applyFormatter('', previous: '۱۲٬۵۰۰'), '');
  });

  test('reformats correctly as digits are appended', () {
    var text = '';
    for (final digit in ['1', '2', '5', '0', '0']) {
      text = applyFormatter('${Money.parse(text) == null ? '' : text}$digit',
          previous: text);
    }
    expect(text, '۱۲٬۵۰۰');
  });

  test('output round-trips through Money.parse', () {
    expect(Money.parse(applyFormatter('12500')), 125000);
  });
}
