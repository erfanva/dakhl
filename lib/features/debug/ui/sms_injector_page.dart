import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/db/providers.dart';
import '../../../core/sms/sms_pipeline.dart';

/// Feeds a hand-written SMS straight into [SmsPipeline.handle] — the same
/// entry point the real broadcast receiver uses.
///
/// This exercises everything except the Android broadcast itself, which
/// makes it the practical way to add a new bank's pattern: paste the SMS,
/// see what the parser makes of it, adjust, repeat. Debug builds only.
class SmsInjectorPage extends ConsumerStatefulWidget {
  const SmsInjectorPage({super.key});

  @override
  ConsumerState<SmsInjectorPage> createState() => _SmsInjectorPageState();
}

class _SmsInjectorPageState extends ConsumerState<SmsInjectorPage> {
  final _senderController = TextEditingController(text: '200030');
  final _bodyController = TextEditingController(
    text: 'برداشت:۲۵۰,۰۰۰\nمانده:۱,۳۵۰,۰۰۰\nکارت:۱۲۳۴',
  );
  SmsResult? _lastResult;
  String? _error;
  bool _running = false;

  @override
  void dispose() {
    _senderController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تزریق پیامک (دیباگ)')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: _senderController,
            textDirection: TextDirection.ltr,
            decoration: const InputDecoration(labelText: 'فرستنده'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _bodyController,
            maxLines: 6,
            decoration: const InputDecoration(
              labelText: 'متن پیامک',
              alignLabelWithHint: true,
            ),
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: _running ? null : _inject,
            icon: const Icon(Icons.play_arrow),
            label: const Text('اجرا'),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: [
              for (final sample in _samples)
                ActionChip(
                  label: Text(sample.label),
                  onPressed: () {
                    _senderController.text = sample.sender;
                    _bodyController.text = sample.body;
                  },
                ),
            ],
          ),
          const SizedBox(height: 24),
          if (_error != null)
            Card(
              color: Theme.of(context).colorScheme.errorContainer,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(_error!),
              ),
            ),
          if (_lastResult != null) _ResultCard(result: _lastResult!),
        ],
      ),
    );
  }

  Future<void> _inject() async {
    setState(() {
      _running = true;
      _error = null;
    });

    try {
      final pipeline = SmsPipeline(
        db: ref.read(appDatabaseProvider),
        notifications: ref.read(notificationServiceProvider),
      );
      final result = await pipeline.handle(
        sender: _senderController.text.trim(),
        body: _bodyController.text,
        receivedAt: DateTime.now(),
      );
      if (mounted) setState(() => _lastResult = result);
    } catch (error) {
      if (mounted) setState(() => _error = '$error');
    } finally {
      if (mounted) setState(() => _running = false);
    }
  }
}

class _ResultCard extends StatelessWidget {
  const _ResultCard({required this.result});

  final SmsResult result;

  @override
  Widget build(BuildContext context) {
    final parsed = result.parsed;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('نتیجه', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            _row('وضعیت', switch (result.outcome) {
              SmsOutcome.parsed => 'شناسایی شد',
              SmsOutcome.unrecognized => 'بانکی ولی ناشناخته',
              SmsOutcome.ignored => 'نادیده گرفته شد (پیامک بانکی نیست)',
            }),
            if (result.transactionId != null)
              _row('شناسه تراکنش', '${result.transactionId}'),
            if (parsed != null) ...[
              _row('بانک', parsed.pattern.bankName),
              _row('نوع', parsed.type.name),
              _row('مبلغ (ریال)', '${parsed.amountRial}'),
              if (parsed.balanceAfterRial != null)
                _row('مانده (ریال)', '${parsed.balanceAfterRial}'),
              if (parsed.accountRef != null)
                _row('شناسه حساب', parsed.accountRef!),
            ],
          ],
        ),
      ),
    );
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text('$label: '),
          Expanded(
            child: Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

class _Sample {
  const _Sample(this.label, this.sender, this.body);

  final String label;
  final String sender;
  final String body;
}

const _samples = [
  _Sample('برداشت ملت', '200030',
      'برداشت:۲۵۰,۰۰۰\nمانده:۱,۳۵۰,۰۰۰\nکارت:۱۲۳۴'),
  _Sample('واریز ملی', '1000001',
      'واریز:۵,۰۰۰,۰۰۰\nمانده:۶,۲۰۰,۰۰۰\nکارت:۹۸۷۶'),
  _Sample('ناشناخته', '200030', 'تراکنش شما با موفقیت انجام شد'),
  _Sample('غیربانکی', '+989121234567', 'سلام، فردا میبینمت'),
];
