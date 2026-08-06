import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

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

/// Reads current permission state without prompting — opening settings
/// should show status, not trigger dialogs.
final smsPermissionStatusProvider =
    FutureProvider.autoDispose<SmsPermissionStatus>((ref) async {
  final gateway = ref.watch(smsGatewayProvider);
  return SmsPermissionStatus(
    notifications: await Permission.notification.isGranted,
    sms: await gateway.hasPermission(),
  );
});
