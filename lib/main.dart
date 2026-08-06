import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';
import 'app/router.dart';
import 'core/db/providers.dart';
import 'core/notifications/notification_service.dart';
import 'core/sms/sms_permissions.dart';
import 'core/sms/sms_pipeline.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final container = ProviderContainer();
  final notifications = container.read(notificationServiceProvider);
  await notifications.init();
  // If a notification tap cold-started us, the router jumps there on its
  // first build rather than landing on the transactions tab.
  await notifications.captureLaunchPayload();

  NotificationService.onTap = (payload) => appRouter.push(payload.route);

  await _startSmsListener(container);

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const DakhlApp(),
    ),
  );

  _consumeLaunchPayload();
}

/// Registers the foreground SMS listener. Messages that arrive while the
/// app is killed go through the background handler registered inside the
/// gateway instead.
Future<void> _startSmsListener(ProviderContainer container) async {
  final gateway = container.read(smsGatewayProvider);
  if (!await gateway.hasPermission()) return;

  final pipeline = SmsPipeline(
    db: container.read(appDatabaseProvider),
    notifications: container.read(notificationServiceProvider),
  );

  try {
    await gateway.startListening((sms) {
      pipeline.handle(
        sender: sms.sender,
        body: sms.body,
        receivedAt: sms.receivedAt,
      );
    });
  } catch (error, stack) {
    // A failure here costs the foreground fast-path only; the background
    // receiver still works and manual entry is unaffected.
    debugPrint('Failed to start SMS listener: $error\n$stack');
  }
}

void _consumeLaunchPayload() {
  final payload = NotificationService.pendingLaunchPayload;
  if (payload == null) return;
  NotificationService.pendingLaunchPayload = null;

  // Deferred so the router has finished its first build before navigating.
  WidgetsBinding.instance.addPostFrameCallback((_) {
    appRouter.push(payload.route);
  });
}
