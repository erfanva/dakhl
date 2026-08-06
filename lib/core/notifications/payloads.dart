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
}

/// An SMS-detected transaction waiting to be categorized.
class PendingTransactionPayload extends NotificationPayload {
  const PendingTransactionPayload(this.transactionId);

  final int transactionId;

  @override
  String encode() => 'pending:$transactionId';

  @override
  String get route => '/categorize/$transactionId';
}

/// A recurring income/expense occurrence that is due (Phase 4).
class OccurrencePayload extends NotificationPayload {
  const OccurrencePayload(this.occurrenceId);

  final int occurrenceId;

  @override
  String encode() => 'occurrence:$occurrenceId';

  @override
  String get route => '/month-plan';
}

/// A debt whose due date is approaching (Phase 4).
class DebtPayload extends NotificationPayload {
  const DebtPayload(this.debtId);

  final int debtId;

  @override
  String encode() => 'debt:$debtId';

  @override
  String get route => '/debts';
}
