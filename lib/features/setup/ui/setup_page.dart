import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/setup/device_setup.dart';

/// Walks the user through the device-level settings that bank SMS capture
/// depends on, showing which are already satisfied.
///
/// Shown automatically on launch while something essential is missing, and
/// reachable from settings at any time.
class SetupPage extends ConsumerWidget {
  const SetupPage({super.key, this.showCloseButton = true});

  final bool showCloseButton;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncStatus = ref.watch(setupStatusProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('راه‌اندازی خواندن پیامک'),
        automaticallyImplyLeading: showCloseButton,
      ),
      body: asyncStatus.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('خطا در بررسی: $e')),
        data: (status) => ListView(
          padding: const EdgeInsets.only(bottom: 24),
          children: [
            _Intro(isComplete: status.isComplete),
            for (final state in status.checks)
              _CheckTile(state: state),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: OutlinedButton.icon(
                onPressed: () => ref.invalidate(setupStatusProvider),
                icon: const Icon(Icons.refresh),
                label: const Text('بررسی دوباره'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Intro extends StatelessWidget {
  const _Intro({required this.isComplete});

  final bool isComplete;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isComplete
            ? scheme.primaryContainer
            : scheme.tertiaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            isComplete ? Icons.check_circle_outline : Icons.info_outline,
            color: isComplete
                ? scheme.onPrimaryContainer
                : scheme.onTertiaryContainer,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              isComplete
                  ? 'همه‌چیز آماده است. تراکنش‌های پیامکی خودکار ثبت می‌شوند.'
                  : 'برای اینکه تراکنش‌ها حتی وقتی اپ بسته است از پیامک بانک '
                      'خوانده شوند، موارد زیر لازم است. اپ بدون این‌ها هم کار '
                      'می‌کند، ولی باید دستی ثبت کنی.',
              style: TextStyle(
                color: isComplete
                    ? scheme.onPrimaryContainer
                    : scheme.onTertiaryContainer,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CheckTile extends ConsumerWidget {
  const _CheckTile({required this.state});

  final SetupCheckState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final info = _copyFor(state.check);
    final scheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  state.isSatisfied
                      ? Icons.check_circle
                      : Icons.radio_button_unchecked,
                  color: state.isSatisfied ? Colors.green.shade600 : scheme.outline,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    info.title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(info.description,
                style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 12),
            if (!state.isVerifiable)
              _AutostartActions(state: state, actionLabel: info.action)
            else if (!state.isSatisfied)
              FilledButton(
                onPressed: () async {
                  await ref.read(deviceSetupProvider).fix(state.check);
                  ref.invalidate(setupStatusProvider);
                },
                child: Text(info.action),
              ),
          ],
        ),
      ),
    );
  }
}

/// Autostart can't be read back, so it gets an explicit "I did it" toggle
/// instead of a status the app pretends to know.
class _AutostartActions extends ConsumerWidget {
  const _AutostartActions({required this.state, required this.actionLabel});

  final SetupCheckState state;
  final String actionLabel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final setup = ref.read(deviceSetupProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FilledButton(
          onPressed: () => setup.openAutostartSettings(),
          child: Text(actionLabel),
        ),
        CheckboxListTile(
          contentPadding: EdgeInsets.zero,
          value: state.isSatisfied,
          title: const Text('خودراه‌اندازی را روشن کردم'),
          subtitle: const Text(
            'اندروید اجازه نمی‌دهد اپ خودش این را بررسی کند',
          ),
          onChanged: (value) async {
            await setup.setAutostartConfirmed(value ?? false);
            ref.invalidate(setupStatusProvider);
          },
        ),
      ],
    );
  }
}

class _CheckCopy {
  const _CheckCopy(this.title, this.description, this.action);

  final String title;
  final String description;
  final String action;
}

_CheckCopy _copyFor(SetupCheck check) => switch (check) {
      SetupCheck.sms => const _CheckCopy(
          'دسترسی خواندن پیامک',
          'بدون این، پیامک بانک اصلاً به اپ نمی‌رسد. محتوای پیامک‌ها فقط '
              'روی همین گوشی ذخیره می‌شود و جایی ارسال نمی‌شود.',
          'اجازه بده',
        ),
      SetupCheck.notifications => const _CheckCopy(
          'دسترسی اعلان‌ها',
          'تراکنش تشخیص‌داده‌شده با یک اعلان به تو خبر داده می‌شود تا با یک '
              'ضربه دسته‌بندی‌اش کنی.',
          'اجازه بده',
        ),
      SetupCheck.battery => const _CheckCopy(
          'حذف محدودیت باتری',
          'با محدودیت باتری، سیستم پردازش پیامک را وسط کار می‌کشد و تراکنش '
              'ثبت نمی‌شود.',
          'بدون محدودیت کن',
        ),
      SetupCheck.autostart => const _CheckCopy(
          'خودراه‌اندازی (Autostart)',
          'گوشی‌های شیائومی، هواوی، اوپو و مشابه به‌صورت پیش‌فرض اجازه '
              'نمی‌دهند اپ برای دریافت پیامک بالا بیاید. در لیستی که باز '
              'می‌شود «دخل» را پیدا کن و روشنش کن.',
          'باز کردن تنظیمات',
        ),
    };
