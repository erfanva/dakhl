import 'dart:convert';

import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/db/database.dart';
import '../../../core/db/providers.dart';
import '../providers/settings_providers.dart';

/// Lets the user enable, edit, and add bank SMS parsing rules — so a bank
/// the app doesn't know yet can be taught without a new release.
class SmsPatternsPage extends ConsumerWidget {
  const SmsPatternsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncPatterns = ref.watch(smsPatternsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('الگوهای پیامک بانک')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showSmsPatternFormSheet(context),
        icon: const Icon(Icons.add),
        label: const Text('الگوی جدید'),
      ),
      body: asyncPatterns.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('خطا در بارگذاری: $e')),
        data: (patterns) => ListView(
          padding: const EdgeInsets.only(bottom: 88),
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'هر پیامک با این الگوها به ترتیب اولویت بررسی می‌شود و '
                'اولین الگویی که هم جهت و هم مبلغ را پیدا کند برنده است. '
                'اگر بانکی شناسایی نمی‌شود، از صفحه «تزریق پیامک» متن آن را '
                'آزمایش کن و الگوی تازه بساز.',
                style: TextStyle(fontSize: 12),
              ),
            ),
            for (final pattern in patterns) _PatternTile(pattern: pattern),
          ],
        ),
      ),
    );
  }
}

class _PatternTile extends ConsumerWidget {
  const _PatternTile({required this.pattern});

  final SmsPattern pattern;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final senders = _decodeList(pattern.senderNumbers);
    return SwitchListTile(
      value: pattern.isEnabled,
      onChanged: (enabled) => ref
          .read(appDatabaseProvider)
          .smsPatternsDao
          .setEnabled(pattern.id, enabled),
      title: Text(pattern.bankName),
      subtitle: Text(
        senders.isEmpty ? 'همه فرستنده‌ها' : senders.join('، '),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.right,
      ),
      secondary: IconButton(
        icon: const Icon(Icons.edit_outlined),
        tooltip: 'ویرایش',
        onPressed: () => showSmsPatternFormSheet(context, existing: pattern),
      ),
    );
  }
}

/// Opens the add/edit pattern sheet.
Future<void> showSmsPatternFormSheet(
  BuildContext context, {
  SmsPattern? existing,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (context) => _SmsPatternFormSheet(existing: existing),
  );
}

class _SmsPatternFormSheet extends ConsumerStatefulWidget {
  const _SmsPatternFormSheet({this.existing});

  final SmsPattern? existing;

  @override
  ConsumerState<_SmsPatternFormSheet> createState() =>
      _SmsPatternFormSheetState();
}

class _SmsPatternFormSheetState extends ConsumerState<_SmsPatternFormSheet> {
  final _bankController = TextEditingController();
  final _sendersController = TextEditingController();
  final _depositController = TextEditingController();
  final _withdrawalController = TextEditingController();
  final _amountRegexController = TextEditingController();
  final _balanceRegexController = TextEditingController();
  final _accountRegexController = TextEditingController();
  SmsAmountUnit _unit = SmsAmountUnit.rial;
  bool _saving = false;

  SmsPattern? get existing => widget.existing;

  @override
  void initState() {
    super.initState();
    final pattern = existing;
    if (pattern != null) {
      _bankController.text = pattern.bankName;
      _sendersController.text = _decodeList(pattern.senderNumbers).join('، ');
      _depositController.text = _decodeList(pattern.depositKeywords).join('، ');
      _withdrawalController.text =
          _decodeList(pattern.withdrawalKeywords).join('، ');
      _amountRegexController.text = pattern.amountRegex;
      _balanceRegexController.text = pattern.balanceRegex ?? '';
      _accountRegexController.text = pattern.accountRefRegex ?? '';
      _unit = pattern.amountUnit;
    } else {
      _depositController.text = 'واریز، افزایش';
      _withdrawalController.text = 'برداشت، خرید، کاهش، انتقال';
      _amountRegexController.text = r'(?:مبلغ|برداشت|واریز)[:\s]*([0-9]+)';
      _balanceRegexController.text = r'(?:مانده|موجودی)[:\s]*([0-9]+)';
    }
  }

  @override
  void dispose() {
    for (final controller in [
      _bankController,
      _sendersController,
      _depositController,
      _withdrawalController,
      _amountRegexController,
      _balanceRegexController,
      _accountRegexController,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 8,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.close),
                  tooltip: 'بستن',
                  onPressed: () => Navigator.of(context).pop(),
                ),
                Expanded(
                  child: Text(
                    existing == null ? 'الگوی جدید' : 'ویرایش الگو',
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
                if (existing != null && !existing!.isBuiltIn)
                  IconButton(
                    icon: const Icon(Icons.delete_outline),
                    tooltip: 'حذف',
                    onPressed: _delete,
                  )
                else
                  const SizedBox(width: 48),
              ],
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _bankController,
              decoration: const InputDecoration(labelText: 'نام بانک'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _sendersController,
              textDirection: TextDirection.ltr,
              decoration: const InputDecoration(
                labelText: 'شماره‌های فرستنده',
                helperText: 'با ویرگول جدا کن؛ خالی یعنی همه فرستنده‌ها',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _depositController,
              decoration: const InputDecoration(
                labelText: 'کلیدواژه‌های واریز',
                helperText: 'با ویرگول جدا کن',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _withdrawalController,
              decoration: const InputDecoration(
                labelText: 'کلیدواژه‌های برداشت',
                helperText: 'با ویرگول جدا کن',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _amountRegexController,
              textDirection: TextDirection.ltr,
              decoration: const InputDecoration(
                labelText: 'الگوی مبلغ (regex)',
                helperText: 'گروه اول باید خود عدد باشد',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _balanceRegexController,
              textDirection: TextDirection.ltr,
              decoration:
                  const InputDecoration(labelText: 'الگوی مانده (اختیاری)'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _accountRegexController,
              textDirection: TextDirection.ltr,
              decoration: const InputDecoration(
                labelText: 'الگوی شناسه حساب (اختیاری)',
                helperText: 'برای تطبیق با ۴ رقم آخر کارت حساب‌ها',
              ),
            ),
            const SizedBox(height: 16),
            Text('واحد مبلغ در پیامک',
                style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 8),
            SegmentedButton<SmsAmountUnit>(
              segments: const [
                ButtonSegment(value: SmsAmountUnit.rial, label: Text('ریال')),
                ButtonSegment(value: SmsAmountUnit.toman, label: Text('تومان')),
              ],
              selected: {_unit},
              onSelectionChanged: (s) => setState(() => _unit = s.first),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _saving ? null : _save,
              child: Text(existing == null ? 'ثبت' : 'ذخیره تغییرات'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _save() async {
    final bankName = _bankController.text.trim();
    if (bankName.isEmpty) {
      _complain('نام بانک را وارد کن');
      return;
    }
    final amountRegex = _amountRegexController.text.trim();
    if (amountRegex.isEmpty) {
      _complain('الگوی مبلغ را وارد کن');
      return;
    }
    // A malformed regex would otherwise throw deep inside the background
    // isolate, where the user would never see the error.
    for (final entry in {
      'مبلغ': amountRegex,
      'مانده': _balanceRegexController.text.trim(),
      'شناسه حساب': _accountRegexController.text.trim(),
    }.entries) {
      if (entry.value.isEmpty) continue;
      try {
        RegExp(entry.value);
      } on FormatException catch (error) {
        _complain('الگوی ${entry.key} معتبر نیست: ${error.message}');
        return;
      }
    }

    setState(() => _saving = true);
    final dao = ref.read(appDatabaseProvider).smsPatternsDao;
    final balanceRegex = _balanceRegexController.text.trim();
    final accountRegex = _accountRegexController.text.trim();

    if (existing == null) {
      await dao.insertPattern(SmsPatternsCompanion.insert(
        bankName: bankName,
        senderNumbers: jsonEncode(_splitList(_sendersController.text)),
        depositKeywords: jsonEncode(_splitList(_depositController.text)),
        withdrawalKeywords: jsonEncode(_splitList(_withdrawalController.text)),
        amountRegex: amountRegex,
        balanceRegex: Value(balanceRegex.isEmpty ? null : balanceRegex),
        accountRefRegex: Value(accountRegex.isEmpty ? null : accountRegex),
        amountUnit: _unit,
        // User patterns run before the built-ins so they can override them.
        priority: const Value(50),
      ));
    } else {
      await dao.updatePattern(existing!.copyWith(
        bankName: bankName,
        senderNumbers: jsonEncode(_splitList(_sendersController.text)),
        depositKeywords: jsonEncode(_splitList(_depositController.text)),
        withdrawalKeywords: jsonEncode(_splitList(_withdrawalController.text)),
        amountRegex: amountRegex,
        balanceRegex: Value(balanceRegex.isEmpty ? null : balanceRegex),
        accountRefRegex: Value(accountRegex.isEmpty ? null : accountRegex),
        amountUnit: _unit,
      ));
    }

    if (mounted) Navigator.of(context).pop();
  }

  Future<void> _delete() async {
    await ref.read(appDatabaseProvider).smsPatternsDao.deletePattern(
          existing!.id,
        );
    if (mounted) Navigator.of(context).pop();
  }

  void _complain(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}

/// Splits a comma-separated field, accepting both Persian and latin commas.
List<String> _splitList(String raw) {
  return raw
      .split(RegExp('[،,]'))
      .map((part) => part.trim())
      .where((part) => part.isNotEmpty)
      .toList();
}

List<String> _decodeList(String json) {
  try {
    final decoded = jsonDecode(json);
    if (decoded is List) return decoded.map((e) => e.toString()).toList();
  } on FormatException {
    // Shown as empty rather than crashing the settings screen.
  }
  return const [];
}
