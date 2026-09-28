import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/db/database.dart';
import '../../../core/db/providers.dart';

/// What a set of reminder rules hangs off: a recurring item or a debt.
/// A value type so it can key a provider family.
class ReminderOwner {
  const ReminderOwner({required this.kind, required this.id});

  final OwnerKind kind;
  final int id;

  @override
  bool operator ==(Object other) =>
      other is ReminderOwner && other.kind == kind && other.id == id;

  @override
  int get hashCode => Object.hash(kind, id);
}

final reminderRulesProvider =
    StreamProvider.autoDispose.family<List<ReminderRule>, ReminderOwner>(
  (ref, owner) =>
      ref.watch(remindersDaoProvider).watchRules(owner.kind, owner.id),
);
