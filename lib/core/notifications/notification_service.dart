import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'payloads.dart';

/// Notification channels. Separate channels let the user silence reminders
/// without losing transaction alerts (or vice versa) from system settings.
abstract final class NotificationChannels {
  static const transactions = AndroidNotificationChannel(
    'transactions',
    'تراکنش‌ها',
    description: 'اعلان تراکنش‌های تشخیص‌داده‌شده از پیامک بانک',
    importance: Importance.high,
  );

  static const reminders = AndroidNotificationChannel(
    'reminders',
    'یادآورها',
    description: 'یادآور هزینه‌های ثابت، بدهی‌ها و طلب‌ها',
    importance: Importance.high,
  );
}

/// Thin wrapper over flutter_local_notifications.
///
/// Usable from both the UI isolate and the background SMS isolate — the
/// background isolate calls [init] then [showPendingTransaction] on its own
/// plugin instance, since plugin state isn't shared across isolates.
class NotificationService {
  NotificationService([FlutterLocalNotificationsPlugin? plugin])
      : _plugin = plugin ?? FlutterLocalNotificationsPlugin();

  final FlutterLocalNotificationsPlugin _plugin;

  /// Set when a tapped notification launched the app from cold. The router
  /// consumes this on first build.
  static NotificationPayload? pendingLaunchPayload;

  /// Called when a notification is tapped while the app is running.
  static void Function(NotificationPayload payload)? onTap;

  Future<void> init() async {
    const settings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    );

    await _plugin.initialize(
      settings: settings,
      onDidReceiveNotificationResponse: _handleResponse,
      onDidReceiveBackgroundNotificationResponse: _handleResponse,
    );

    final android = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await android?.createNotificationChannel(NotificationChannels.transactions);
    await android?.createNotificationChannel(NotificationChannels.reminders);
  }

  /// Reads the payload of a notification that cold-started the app, so the
  /// router can jump straight to it.
  Future<void> captureLaunchPayload() async {
    final details = await _plugin.getNotificationAppLaunchDetails();
    if (details?.didNotificationLaunchApp ?? false) {
      pendingLaunchPayload =
          NotificationPayload.decode(details!.notificationResponse?.payload);
    }
  }

  Future<bool> requestPermission() async {
    final android = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    return await android?.requestNotificationsPermission() ?? false;
  }

  /// Fires the "tap to categorize" alert for an SMS-detected transaction.
  /// The notification id is the transaction id, so a re-parse of the same
  /// row replaces rather than duplicates the alert.
  Future<void> showPendingTransaction({
    required int transactionId,
    required String title,
    required String body,
  }) {
    return _plugin.show(
      id: transactionId,
      title: title,
      body: body,
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails(
          NotificationChannels.transactions.id,
          NotificationChannels.transactions.name,
          channelDescription: NotificationChannels.transactions.description,
          importance: Importance.high,
          priority: Priority.high,
          // Persian text is long; let the system expand it.
          styleInformation: BigTextStyleInformation(body),
        ),
      ),
      payload: PendingTransactionPayload(transactionId).encode(),
    );
  }

  Future<void> cancel(int id) => _plugin.cancel(id: id);
}

/// Top-level so it can be used as a background notification callback.
@pragma('vm:entry-point')
void _handleResponse(NotificationResponse response) {
  final payload = NotificationPayload.decode(response.payload);
  if (payload == null) return;

  final handler = NotificationService.onTap;
  if (handler != null) {
    handler(payload);
  } else {
    // Tapped before the router was ready (cold start racing init) — stash
    // it for the router to pick up.
    NotificationService.pendingLaunchPayload = payload;
    if (kDebugMode) {
      debugPrint('Notification tapped before router was ready: ${response.payload}');
    }
  }
}
