import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';
import 'app/router.dart';
import 'core/db/providers.dart';
import 'core/notifications/notification_service.dart';
import 'core/sms/sms_listener.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final container = ProviderContainer();
  final notifications = container.read(notificationServiceProvider);
  await notifications.init();
  // If a notification tap cold-started us, the router jumps there on its
  // first build rather than landing on the transactions tab.
  await notifications.captureLaunchPayload();

  NotificationService.onTap = (payload) => appRouter.push(payload.route);

  // No-op when permission hasn't been granted yet; settings starts it the
  // moment the user grants it, without needing a restart.
  await container.read(smsListenerProvider).ensureStarted();

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const DakhlApp(),
    ),
  );

  _consumeLaunchPayload();
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
