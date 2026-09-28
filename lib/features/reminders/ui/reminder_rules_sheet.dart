import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/db/database.dart';
import '../../../core/db/providers.dart';
import '../../../core/persian/digits.dart';
import '../providers/reminders_providers.dart';

/// Opens the reminder list for one recurring item or debt.
///
/// An owner with no rules gets no reminders — that's how the feature is
/// turned off, so the sheet says as much rather than looking broken.
Future<void> showReminderRulesSheet(
  BuildContext context, {
  required OwnerKind ownerKind,
  required int ownerId,
  required String ownerTitle,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (context) => _ReminderRulesSheet(
      ownerKind: ownerKind,
      ownerId: ownerId,
      ownerTitle: ownerTitle,
    ),
  );
}

class _ReminderRulesSheet extends ConsumerWidget {
  const _ReminderRulesSheet({
    required this.ownerKind,
    required this.ownerId,
    required this.ownerTitle,
  });

  final OwnerKind ownerKind;
  final int ownerId;
  final String ownerTitle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final owner = ReminderOwner(kind: ownerKind, id: ownerId);
    final rules = ref.watch(reminderRulesProvider(owner)).value ?? [];

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
                  'یادآورهای «$ownerTitle»',
                  style: theme.textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(width: 48),
            ],
          ),
          const SizedBox(height: 8),
          if (rules.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                'یادآوری تنظیم نشده؛ برای این مورد اعلانی نمی‌آید.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium
                    ?.copyWith(color: theme.colorScheme.outline),
              ),
            )
          else
            for (final rule in rules)
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.notifications_outlined),
                title: Text(reminderRuleLabel(rule)),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline),
                  tooltip: 'حذف',
                  onPressed: () =>
                      ref.read(remindersDaoProvider).deleteRule(rule.id),
                ),
              ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            icon: const Icon(Icons.add),
            label: const Text('افزودن یادآور'),
            onPressed: () => _add(context, ref),
          ),
        ],
      ),
    );
  }

  Future<void> _add(BuildContext context, WidgetRef ref) async {
    final result = await showDialog<({int daysBefore, int minutesOfDay})>(
      context: context,
      builder: (context) => const _NewRuleDialog(),
    );
    if (result == null) return;

    await ref.read(remindersDaoProvider).insertRule(
          ownerKind: ownerKind,
          ownerId: ownerId,
          daysBefore: result.daysBefore,
          minutesOfDay: result.minutesOfDay,
        );
  }
}

/// e.g. `روز موعد، ۹:۰۰` or `۲ روز قبل، ۲۰:۳۰`
String reminderRuleLabel(ReminderRule rule) {
  final hour = (rule.minutesOfDay ~/ 60).toString().padLeft(2, '0');
  final minute = (rule.minutesOfDay % 60).toString().padLeft(2, '0');
  final time = toPersianDigits('$hour:$minute');
  final when = switch (rule.daysBefore) {
    0 => 'روز موعد',
    1 => 'یک روز قبل',
    _ => '${toPersianDigits('${rule.daysBefore}')} روز قبل',
  };
  return '$when، ساعت $time';
}

class _NewRuleDialog extends StatefulWidget {
  const _NewRuleDialog();

  @override
  State<_NewRuleDialog> createState() => _NewRuleDialogState();
}

class _NewRuleDialogState extends State<_NewRuleDialog> {
  static const _dayOptions = [0, 1, 2, 3, 7, 14];

  int _daysBefore = 1;
  TimeOfDay _time = const TimeOfDay(hour: 9, minute: 0);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('یادآور جدید'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DropdownButtonFormField<int>(
            initialValue: _daysBefore,
            decoration: const InputDecoration(labelText: 'چه زمانی'),
            items: [
              for (final days in _dayOptions)
                DropdownMenuItem(
                  value: days,
                  child: Text(switch (days) {
                    0 => 'روز موعد',
                    1 => 'یک روز قبل',
                    _ => '${toPersianDigits('$days')} روز قبل',
                  }),
                ),
            ],
            onChanged: (days) => setState(() => _daysBefore = days ?? 0),
          ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            icon: const Icon(Icons.schedule),
            label: Text(toPersianDigits(
                '${_time.hour.toString().padLeft(2, '0')}:'
                '${_time.minute.toString().padLeft(2, '0')}')),
            onPressed: () async {
              final picked =
                  await showTimePicker(context: context, initialTime: _time);
              if (picked != null) setState(() => _time = picked);
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('انصراف'),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, (
            daysBefore: _daysBefore,
            minutesOfDay: _time.hour * 60 + _time.minute,
          )),
          child: const Text('افزودن'),
        ),
      ],
    );
  }
}
