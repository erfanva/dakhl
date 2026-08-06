import 'dart:convert';

import 'package:drift/drift.dart';

import '../../db/database.dart';

/// Built-in parsing rules for common Iranian banks.
///
/// Patterns run against the *normalized* body (latin digits, no thousands
/// separators, unified ی/ک — see `normalizer.dart`), so the regexes only
/// ever deal with `[0-9]`.
///
/// Users can edit these or add their own in settings; [isBuiltIn] marks the
/// seeded ones so a future app update can refresh them without clobbering
/// user-authored rules.
class _SeedPattern {
  const _SeedPattern({
    required this.bankName,
    required this.senderNumbers,
    required this.amountRegex,
    this.balanceRegex,
    this.accountRefRegex,
    this.priority = 100,
  });

  final String bankName;
  final List<String> senderNumbers;
  final String amountRegex;
  final String? balanceRegex;
  final String? accountRefRegex;
  final int priority;

  /// Every Iranian bank we've seen quotes Rial and draws on the same
  /// direction vocabulary, so these are constants rather than per-bank
  /// fields. A bank that differs gets a user-authored pattern.
  ///
  /// «نشست» and «پرید» are Blu's conversational phrasing ("landed in" /
  /// "flew out of" your account); harmless for the other banks.
  static const depositKeywords = ['واریز', 'افزایش', 'نشست'];
  static const withdrawalKeywords = [
    'برداشت',
    'خرید',
    'کاهش',
    'انتقال',
    'پرید',
  ];
  static const unit = SmsAmountUnit.rial;
}

/// Two shapes cover every real bank SMS seen so far: an amount introduced by
/// a keyword ("برداشت مبلغ ۱۳۰۰۰۰۰"), or a bare amount followed by its unit
/// ("۸۳۰۵۰۰۰ ریال از حساب شما پرید"). Each branch captures, and the parser
/// takes whichever one matched.
const _defaultAmountRegex =
    r'(?:مبلغ|میزان|برداشت|واریز)[:\s]*([0-9]+)|([0-9]{4,})\s*(?:ریال|تومان)';

const _defaultBalanceRegex = r'(?:مانده|موجودی)[:\s]*([0-9]+)';

/// A generic fallback used when the sender is unknown but the body looks
/// like a bank notification. Runs last (highest priority number).
const _genericPattern = _SeedPattern(
  bankName: 'عمومی',
  senderNumbers: [],
  amountRegex: _defaultAmountRegex,
  balanceRegex: _defaultBalanceRegex,
  accountRefRegex: r'(?:کارت|حساب|سپرده)[:\s]*[*x\-]*([0-9]{4})',
  priority: 900,
);

const _seedPatterns = <_SeedPattern>[
  _SeedPattern(
    bankName: 'بانک ملی',
    senderNumbers: ['1000001', '20001824', '3000151'],
    amountRegex: _defaultAmountRegex,
    balanceRegex: _defaultBalanceRegex,
    accountRefRegex: r'(?:کارت|حساب)[:\s]*[*x\-]*([0-9]{4})',
  ),
  _SeedPattern(
    bankName: 'بانک ملت',
    senderNumbers: ['200030', '10000021', '983000'],
    amountRegex: _defaultAmountRegex,
    balanceRegex: _defaultBalanceRegex,
    accountRefRegex: r'(?:کارت|حساب|سپرده)[:\s]*[*x\-]*([0-9]{4})',
  ),
  _SeedPattern(
    bankName: 'بانک صادرات',
    senderNumbers: ['20002030', '1000151'],
    amountRegex: _defaultAmountRegex,
    balanceRegex: _defaultBalanceRegex,
    accountRefRegex: r'(?:کارت|حساب)[:\s]*[*x\-]*([0-9]{4})',
  ),
  _SeedPattern(
    bankName: 'بانک تجارت',
    senderNumbers: ['200080', '10000627'],
    amountRegex: _defaultAmountRegex,
    balanceRegex: _defaultBalanceRegex,
    accountRefRegex: r'(?:کارت|حساب)[:\s]*[*x\-]*([0-9]{4})',
  ),
  _SeedPattern(
    bankName: 'بانک سامان',
    senderNumbers: ['200060', '10009999'],
    amountRegex: _defaultAmountRegex,
    balanceRegex: _defaultBalanceRegex,
    accountRefRegex: r'(?:کارت|حساب|سپرده)[:\s]*[*x\-]*([0-9]{4})',
  ),
  _SeedPattern(
    bankName: 'بانک پاسارگاد',
    senderNumbers: ['2000505', '10000505'],
    amountRegex: _defaultAmountRegex,
    balanceRegex: _defaultBalanceRegex,
    accountRefRegex: r'(?:کارت|حساب)[:\s]*[*x\-]*([0-9]{4})',
  ),
  _SeedPattern(
    bankName: 'بانک رسالت',
    senderNumbers: ['200070', '100070'],
    amountRegex: _defaultAmountRegex,
    balanceRegex: _defaultBalanceRegex,
    accountRefRegex: r'(?:کارت|حساب)[:\s]*[*x\-]*([0-9]{4})',
  ),
  _SeedPattern(
    bankName: 'بلوبانک',
    senderNumbers: ['2000225', '100085'],
    amountRegex: _defaultAmountRegex,
    balanceRegex: _defaultBalanceRegex,
    accountRefRegex: r'(?:کارت|حساب)[:\s]*[*x\-]*([0-9]{4})',
  ),
  _SeedPattern(
    bankName: 'بانک آینده',
    senderNumbers: ['20002062', '100062'],
    amountRegex: _defaultAmountRegex,
    balanceRegex: _defaultBalanceRegex,
    accountRefRegex: r'(?:کارت|حساب)[:\s]*[*x\-]*([0-9]{4})',
  ),
  _genericPattern,
];

/// Inserts the built-in patterns. Called on database creation and again
/// when an upgrade adds banks the user doesn't have yet.
Future<void> seedSmsPatterns(AppDatabase db) async {
  final existing = await db.select(db.smsPatterns).get();
  final knownBanks = existing.map((p) => p.bankName).toSet();

  for (final seed in _seedPatterns) {
    if (knownBanks.contains(seed.bankName)) continue;
    await db.into(db.smsPatterns).insert(
          SmsPatternsCompanion.insert(
            bankName: seed.bankName,
            senderNumbers: jsonEncode(seed.senderNumbers),
            depositKeywords: jsonEncode(_SeedPattern.depositKeywords),
            withdrawalKeywords: jsonEncode(_SeedPattern.withdrawalKeywords),
            amountRegex: seed.amountRegex,
            balanceRegex: Value(seed.balanceRegex),
            accountRefRegex: Value(seed.accountRefRegex),
            amountUnit: _SeedPattern.unit,
            priority: Value(seed.priority),
            isBuiltIn: const Value(true),
          ),
        );
  }
}
