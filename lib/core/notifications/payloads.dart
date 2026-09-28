/// Typed notification payloads.
///
/// Payloads cross a process boundary (a tapped notification can cold-start
/// the app), so they're encoded as a short `kind:id` string rather than
/// anything that assumes shared memory.
sealed class NotificationPayload {
  const NotificationPayload();

  /// Parses a payload string, returning null for anything unrecognized —
  /// including payloads written by an older version of the app.
  static NotificationPayload? decode(String? raw) {
    if (raw == null || raw.isEmpty) return null;
    final separator = raw.indexOf(':');
    if (separator <= 0) return null;

    final kind = raw.substring(0, separator);
    final id = int.tryParse(raw.substring(separator + 1));
    if (id == null) return null;

    return switch (kind) {
      'pending' => PendingTransactionPayload(id),
      'occurrence' => OccurrencePayload(id),
      'debt' => DebtPayload(id),
      _ => null,
    };
  }

  String encode();

  /// Where tapping this notification should take the user.
  String get route;

  /// Whether [route] is a modal above the navigation shell, which has to be
  /// pushed, as opposed to a tab, which is navigated to.
  bool get isModal;
}

/// An SMS-detected transaction waiting to be categorized.
class PendingTransactionPayload extends NotificationPayload {
  const PendingTransactionPayload(this.transactionId);

  final int transactionId;

  @override
  String encode() => 'pending:$transactionId';

  @override
  String get route => '/categorize/$transactionId';

  @override
  bool get isModal => true;
}

/// A recurring income/expense occurrence that is due.
///
/// There is no per-occurrence screen, so this lands on the month plan, where
/// the row is one tap from being settled.
class OccurrencePayload extends NotificationPayload {
  const OccurrencePayload(this.occurrenceId);

  final int occurrenceId;

  @override
  String encode() => 'occurrence:$occurrenceId';

  @override
  String get route => '/month-plan';

  @override
  bool get isModal => false;
}

/// A debt whose due date is approaching.
class DebtPayload extends NotificationPayload {
  const DebtPayload(this.debtId);

  final int debtId;

  @override
  String encode() => 'debt:$debtId';

  @override
  String get route => '/debts/$debtId';

  @override
  bool get isModal => false;
}
