/// Digit and text normalization helpers for Persian/Arabic input.
///
/// The SMS parser depends on these: bank messages mix Persian digits
/// (۰-۹), Arabic-Indic digits (٠-٩), Arabic letters (ي/ك) and several
/// thousands separators, and everything must be reduced to a canonical
/// latin-digit form before regexes run.
library;

const _persianDigits = '۰۱۲۳۴۵۶۷۸۹';
const _arabicDigits = '٠١٢٣٤٥٦٧٨٩';
const _latinDigits = '0123456789';

/// Separators seen in bank SMS amounts: latin comma, Arabic comma,
/// Arabic thousands separator, and a few unicode spaces.
final _separators = RegExp('[,،٬ ‌‏\u202B\u202C]');

/// Converts Persian and Arabic-Indic digits to latin digits.
String toLatinDigits(String input) {
  final buffer = StringBuffer();
  for (final rune in input.runes) {
    final ch = String.fromCharCode(rune);
    final persianIndex = _persianDigits.indexOf(ch);
    if (persianIndex >= 0) {
      buffer.write(_latinDigits[persianIndex]);
      continue;
    }
    final arabicIndex = _arabicDigits.indexOf(ch);
    if (arabicIndex >= 0) {
      buffer.write(_latinDigits[arabicIndex]);
      continue;
    }
    buffer.write(ch);
  }
  return buffer.toString();
}

/// Converts latin digits to Persian digits, for display.
String toPersianDigits(String input) {
  final buffer = StringBuffer();
  for (final rune in input.runes) {
    final ch = String.fromCharCode(rune);
    final index = _latinDigits.indexOf(ch);
    buffer.write(index >= 0 ? _persianDigits[index] : ch);
  }
  return buffer.toString();
}

/// Unifies Arabic letter variants to their Persian counterparts.
String unifyLetters(String input) =>
    input.replaceAll('ي', 'ی').replaceAll('ك', 'ک').replaceAll('ة', 'ه');

/// Full normalization used before parsing an SMS body: latin digits,
/// Persian letters, no thousands separators, collapsed whitespace.
String normalizeForParsing(String input) {
  final normalized = unifyLetters(toLatinDigits(input))
      .replaceAll(_separators, '')
      .replaceAll(RegExp(r'\s+'), ' ')
      .trim();
  return normalized;
}
