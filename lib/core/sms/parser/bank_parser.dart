import 'dart:convert';

import '../../db/database.dart';
import 'normalizer.dart';

/// What a pattern managed to extract from one SMS.
class ParsedSms {
  const ParsedSms({
    required this.pattern,
    required this.type,
    required this.amountRial,
    this.balanceAfterRial,
    this.accountRef,
  });

  final SmsPattern pattern;
  final TxnType type;
  final int amountRial;

  /// The balance the bank reported after this transaction, if the pattern
  /// captured one. Used for the reconciliation hint.
  final int? balanceAfterRial;

  /// Digits identifying the card/account, matched against
  /// `accounts.accountNoSuffix`.
  final String? accountRef;
}

/// Applies user-editable [SmsPattern] rows to a bank SMS.
///
/// Patterns are tried in [SmsPattern.priority] order; the first one that
/// yields both a direction and an amount wins. A pattern whose sender list
/// is empty matches any sender, which is how the generic fallback works.
class BankParser {
  const BankParser(this.patterns);

  final List<SmsPattern> patterns;

  ParsedSms? parse({required String sender, required String body}) {
    final normalized = normalizeSmsBody(body);
    final normalizedSender = _digitsOnly(sender);

    final candidates = patterns.where((p) => p.isEnabled).toList()
      ..sort((a, b) => a.priority.compareTo(b.priority));

    for (final pattern in candidates) {
      if (!_senderMatches(pattern, normalizedSender)) continue;
      final parsed = _applyPattern(pattern, normalized);
      if (parsed != null) return parsed;
    }
    return null;
  }

  /// Whether [sender] belongs to [pattern]'s bank. Exposed so the pipeline
  /// can tell a known bank sender from an unknown one before parsing.
  bool senderMatches(SmsPattern pattern, String sender) =>
      _senderMatches(pattern, _digitsOnly(sender));

  bool _senderMatches(SmsPattern pattern, String normalizedSender) {
    final senders = _decodeList(pattern.senderNumbers);
    // An empty sender list means "any sender" — the generic fallback.
    if (senders.isEmpty) return true;
    if (normalizedSender.isEmpty) return false;
    return senders.any((s) {
      final candidate = _digitsOnly(s);
      if (candidate.isEmpty) return false;
      return normalizedSender.endsWith(candidate) ||
          candidate.endsWith(normalizedSender);
    });
  }

  ParsedSms? _applyPattern(SmsPattern pattern, String normalizedBody) {
    final type = _direction(pattern, normalizedBody);
    if (type == null) return null;

    final amount = _firstNumber(pattern.amountRegex, normalizedBody);
    if (amount == null || amount <= 0) return null;

    final balance = pattern.balanceRegex == null
        ? null
        : _firstNumber(pattern.balanceRegex!, normalizedBody);

    return ParsedSms(
      pattern: pattern,
      type: type,
      amountRial: _toRial(amount, pattern.amountUnit),
      balanceAfterRial:
          balance == null ? null : _toRial(balance, pattern.amountUnit),
      accountRef: pattern.accountRefRegex == null
          ? null
          : _firstGroup(pattern.accountRefRegex!, normalizedBody),
    );
  }

  /// Direction comes from whichever keyword appears *earliest* in the body.
  /// Iranian bank SMS often mention both (e.g. a withdrawal that also names
  /// the destination), and the leading verb is the reliable one.
  TxnType? _direction(SmsPattern pattern, String body) {
    final deposit = _earliestIndex(_decodeList(pattern.depositKeywords), body);
    final withdrawal =
        _earliestIndex(_decodeList(pattern.withdrawalKeywords), body);

    if (deposit == null && withdrawal == null) return null;
    if (deposit == null) return TxnType.withdrawal;
    if (withdrawal == null) return TxnType.deposit;
    return deposit < withdrawal ? TxnType.deposit : TxnType.withdrawal;
  }

  int? _earliestIndex(List<String> keywords, String body) {
    int? best;
    for (final keyword in keywords) {
      if (keyword.isEmpty) continue;
      final index = body.indexOf(keyword);
      if (index >= 0 && (best == null || index < best)) best = index;
    }
    return best;
  }

  int? _firstNumber(String pattern, String body) {
    final digits = _firstGroup(pattern, body);
    return digits == null ? null : int.tryParse(digits);
  }

  String? _firstGroup(String pattern, String body) {
    final regex = RegExp(pattern);
    final match = regex.firstMatch(body);
    if (match == null) return null;
    // Prefer the first capturing group; fall back to the whole match for
    // user-authored patterns written without a group.
    if (match.groupCount >= 1) return match.group(1);
    return match.group(0);
  }

  int _toRial(int value, SmsAmountUnit unit) =>
      unit == SmsAmountUnit.toman ? value * 10 : value;

  static List<String> _decodeList(String json) {
    try {
      final decoded = jsonDecode(json);
      if (decoded is List) {
        return decoded.map((e) => e.toString()).toList();
      }
    } on FormatException {
      // A hand-edited pattern with malformed JSON shouldn't break parsing
      // of every other bank; treat it as "no keywords".
    }
    return const [];
  }

  static String _digitsOnly(String value) =>
      value.replaceAll(RegExp(r'[^0-9]'), '');
}
