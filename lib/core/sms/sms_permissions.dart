import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../db/providers.dart';
import 'sms_gateway.dart';
import 'telephony_gateway.dart';

/// Which of the two permissions the SMS feature needs are currently held.
class SmsPermissionStatus {
  const SmsPermissionStatus({required this.notifications, required this.sms});

  final bool notifications;
  final bool sms;

  /// The SMS feature only works end-to-end with both: one to read the
  /// message, one to tell the user about it.
  bool get isComplete => notifications && sms;
}

/// Requests the permissions the SMS pipeline depends on.
///
/// The app stays fully usable in manual-entry mode if either is refused,
/// so nothing here blocks startup.
class SmsPermissions {
  const SmsPermissions({required this.gateway, required this.requestNotify});

  final SmsGateway gateway;
  final Future<bool> Function() requestNotify;

  Future<bool> requestNotifications() => requestNotify();

  Future<bool> requestSms() => gateway.requestPermission();
}

final smsGatewayProvider =
    Provider<SmsGateway>((ref) => TelephonySmsGateway());

final smsPermissionsProvider = Provider<SmsPermissions>((ref) {
  final notifications = ref.watch(notificationServiceProvider);
  return SmsPermissions(
    gateway: ref.watch(smsGatewayProvider),
    requestNotify: notifications.requestPermission,
  );
});

final smsPermissionStatusProvider =
    FutureProvider.autoDispose<SmsPermissionStatus>((ref) async {
  final notifications = ref.watch(notificationServiceProvider);
  final gateway = ref.watch(smsGatewayProvider);
  return SmsPermissionStatus(
    // On Android 13+ this reports the real state; on older versions
    // notifications are granted at install time and it returns true.
    notifications: await notifications.requestPermission(),
    sms: await gateway.hasPermission(),
  );
});
