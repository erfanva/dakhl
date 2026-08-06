import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';
import 'app/router.dart';
import 'core/db/providers.dart';
import 'core/notifications/notification_service.dart';
import 'core/setup/device_setup.dart';
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

  // Order matters: a notification tap is a direct request and outranks the
  // setup prompt, which the banner keeps offering anyway.
  if (!_consumeLaunchPayload()) {
    await _promptSetupIfBlocked(container);
  }
}

/// Returns whether a notification launched the app (and was navigated to).
bool _consumeLaunchPayload() {
  final payload = NotificationService.pendingLaunchPayload;
  if (payload == null) return false;
  NotificationService.pendingLaunchPayload = null;

  // Deferred so the router has finished its first build before navigating.
  WidgetsBinding.instance.addPostFrameCallback((_) {
    appRouter.push(payload.route);
  });
  return true;
}

/// Opens the setup checklist when SMS capture simply cannot work — a
/// missing permission is invisible otherwise, which is how the feature
/// managed to look broken rather than unconfigured.
///
/// Only the two hard blockers force the screen; the softer items (battery,
/// autostart) are left to the banner so launching the app doesn't turn into
/// an interrogation.
Future<void> _promptSetupIfBlocked(ProviderContainer container) async {
  final setup = container.read(deviceSetupProvider);
  if (await setup.isBannerDismissed()) return;

  final status = await setup.read();
  if (!status.isBlocking) return;

  await setup.dismissBanner();
  WidgetsBinding.instance.addPostFrameCallback((_) {
    appRouter.push('/setup');
  });
}
