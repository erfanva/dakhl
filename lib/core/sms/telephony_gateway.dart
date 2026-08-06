import 'package:another_telephony/telephony.dart';
import 'package:flutter/widgets.dart';

import '../db/database.dart';
import '../notifications/notification_service.dart';
import 'sms_gateway.dart';
import 'sms_pipeline.dart';

/// Handles an SMS that arrived while the app was killed or backgrounded.
///
/// Android spawns a *new isolate* for this, so nothing from the UI isolate
/// is available: the database connection, the notification plugin, and the
/// binding all have to be set up from scratch. Everything below the call to
/// [SmsPipeline.handle] is identical to the foreground path.
@pragma('vm:entry-point')
Future<void> backgroundSmsHandler(SmsMessage message) async {
  WidgetsFlutterBinding.ensureInitialized();

  final db = AppDatabase();
  try {
    final notifications = NotificationService();
    await notifications.init();

    await SmsPipeline(db: db, notifications: notifications).handle(
      sender: message.address ?? '',
      body: message.body ?? '',
      receivedAt: _timestampOf(message),
    );
  } catch (error, stack) {
    // A crash here is invisible to the user (no UI in this isolate), so at
    // least make it visible in logcat rather than silently losing the SMS.
    debugPrint('Background SMS handling failed: $error\n$stack');
  } finally {
    // The isolate is torn down right after this returns; leaving the
    // connection open risks a locked WAL for the UI isolate.
    await db.close();
  }
}

DateTime _timestampOf(SmsMessage message) {
  final millis = message.date;
  return millis == null
      ? DateTime.now()
      : DateTime.fromMillisecondsSinceEpoch(millis);
}

/// [SmsGateway] backed by another_telephony.
class TelephonySmsGateway implements SmsGateway {
  TelephonySmsGateway([Telephony? telephony])
      : _telephony = telephony ?? Telephony.instance;

  final Telephony _telephony;

  @override
  Future<bool> hasPermission() async {
    return await _telephony.requestSmsPermissions ?? false;
  }

  @override
  Future<bool> requestPermission() async {
    return await _telephony.requestSmsPermissions ?? false;
  }

  @override
  Future<void> startListening(void Function(IncomingSms sms) onForeground) async {
    _telephony.listenIncomingSms(
      onNewMessage: (message) => onForeground(IncomingSms(
        sender: message.address ?? '',
        body: message.body ?? '',
        receivedAt: _timestampOf(message),
      )),
      onBackgroundMessage: backgroundSmsHandler,
      listenInBackground: true,
    );
  }
}
