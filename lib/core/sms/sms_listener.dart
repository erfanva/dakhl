import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../db/providers.dart';
import 'sms_gateway.dart';
import 'sms_permissions.dart';
import 'sms_pipeline.dart';

/// Registers the SMS listener, idempotently.
///
/// [SmsGateway.startListening] is what registers *both* the foreground
/// listener and the background broadcast handler, so it has to run at least
/// once after permission is granted. Calling it only at startup meant that
/// granting permission from the settings screen left SMS handling dead
/// until the next launch — hence [ensureStarted], which settings calls
/// right after a grant.
class SmsListener {
  SmsListener({required this.gateway, required this.pipeline});

  final SmsGateway gateway;
  final SmsPipeline pipeline;

  bool _started = false;

  /// Whether the listener is currently registered — surfaced in settings so
  /// a silent failure is visible rather than mysterious.
  bool get isStarted => _started;

  Future<bool> ensureStarted() async {
    if (_started) return true;
    if (!await gateway.hasPermission()) return false;

    try {
      await gateway.startListening((sms) {
        pipeline.handle(
          sender: sms.sender,
          body: sms.body,
          receivedAt: sms.receivedAt,
        );
      });
      _started = true;
      return true;
    } catch (error, stack) {
      debugPrint('Failed to start SMS listener: $error\n$stack');
      return false;
    }
  }
}

final smsPipelineProvider = Provider<SmsPipeline>((ref) {
  return SmsPipeline(
    db: ref.watch(appDatabaseProvider),
    notifications: ref.watch(notificationServiceProvider),
  );
});

final smsListenerProvider = Provider<SmsListener>((ref) {
  return SmsListener(
    gateway: ref.watch(smsGatewayProvider),
    pipeline: ref.watch(smsPipelineProvider),
  );
});
