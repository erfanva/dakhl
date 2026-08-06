import '../../persian/digits.dart';

/// Prepares a raw SMS body for regex matching.
///
/// Bank SMS arrive with Persian or Arabic-Indic digits, thousands
/// separators in several flavours, and inconsistent ی/ک forms. Normalizing
/// once here means every pattern regex can assume plain `[0-9]` and a
/// single spelling of each letter.
String normalizeSmsBody(String body) => normalizeForParsing(body);

/// Cheap pre-filter: is this SMS worth running the full pattern list over?
///
/// Runs before any database work in the background isolate, so an SMS from
/// a friend costs almost nothing.
bool looksLikeBankSms(String normalizedBody) {
  return _bankIndicators.any(normalizedBody.contains);
}

const _bankIndicators = [
  'مبلغ',
  'واریز',
  'برداشت',
  'موجودی',
  'مانده',
  'کارت',
  'حساب',
  'تراکنش',
  'انتقال',
];
