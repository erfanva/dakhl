import 'package:flutter/services.dart';

import '../persian/digits.dart';
import 'money.dart';

/// Renders an amount field in Persian digits with thousands separators as
/// the user types, e.g. typing `12500` shows `۱۲٬۵۰۰`.
///
/// The numeric keypad emits latin digits, so this normalizes whatever
/// arrives (latin, Persian, or Arabic-Indic) and re-groups it. Grouping
/// shifts every character to the right of an edit anyway, so the caret is
/// parked at the end rather than tracked through the reformat.
///
/// [Money.parse] accepts this output as-is.
class PersianAmountInputFormatter extends TextInputFormatter {
  const PersianAmountInputFormatter();

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits =
        toLatinDigits(newValue.text).replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.isEmpty) return const TextEditingValue();

    // A leading zero is never meaningful in an amount, but "0" alone is a
    // valid intermediate state while typing.
    final normalized = digits.replaceFirst(RegExp(r'^0+(?=\d)'), '');
    final formatted = toPersianDigits(Money.groupDigits(normalized));

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
