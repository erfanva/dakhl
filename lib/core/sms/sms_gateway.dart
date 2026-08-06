/// One received SMS, independent of the plugin that delivered it.
class IncomingSms {
  const IncomingSms({
    required this.sender,
    required this.body,
    required this.receivedAt,
  });

  final String sender;
  final String body;
  final DateTime receivedAt;
}

/// Delivers incoming SMS to the app.
///
/// The concrete implementation is plugin-specific and deliberately thin:
/// if the SMS plugin has to be swapped for a hand-written Kotlin
/// BroadcastReceiver, only the implementation changes — [SmsPipeline] and
/// everything above it stay untouched.
abstract interface class SmsGateway {
  /// Whether the SMS receive permission has been granted.
  Future<bool> hasPermission();

  /// Asks the user for SMS permission. Returns whether it was granted.
  Future<bool> requestPermission();

  /// Starts delivering messages. Foreground messages go to [onForeground];
  /// messages that arrive while the app is killed are handled by the
  /// implementation's own background entry point.
  Future<void> startListening(void Function(IncomingSms sms) onForeground);
}
