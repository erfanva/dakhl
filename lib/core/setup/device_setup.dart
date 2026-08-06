import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../sms/sms_listener.dart';
import '../sms/sms_permissions.dart';

/// The things that must all be true for a bank SMS to become a transaction
/// while the app is closed.
enum SetupCheck {
  /// Read incoming SMS.
  sms,

  /// Post the "tap to categorize" notification.
  notifications,

  /// Let the app run unrestricted in the background, so the OS doesn't kill
  /// the short-lived isolate that handles the message.
  battery,

  /// OEM autostart. Not readable through any API — the user confirms it.
  autostart,
}

class SetupCheckState {
  const SetupCheckState({
    required this.check,
    required this.isSatisfied,
    required this.isVerifiable,
  });

  final SetupCheck check;
  final bool isSatisfied;

  /// False for [SetupCheck.autostart]: the app can only take the user
  /// there and trust their answer.
  final bool isVerifiable;
}

class SetupStatus {
  const SetupStatus(this.checks);

  final List<SetupCheckState> checks;

  Iterable<SetupCheckState> get unsatisfied =>
      checks.where((c) => !c.isSatisfied);

  bool get isComplete => unsatisfied.isEmpty;

  /// SMS capture is dead without these two, so they drive the nag on open.
  bool get isBlocking => checks.any((c) =>
      !c.isSatisfied &&
      (c.check == SetupCheck.sms || c.check == SetupCheck.notifications));
}

/// Reads and repairs the device-level prerequisites for SMS capture.
class DeviceSetup {
  DeviceSetup({required this.ref, MethodChannel? channel})
      : _channel = channel ?? const MethodChannel('app.dakhl/device_setup');

  final Ref ref;
  final MethodChannel _channel;

  static const _autostartConfirmedKey = 'setup.autostart_confirmed';
  static const _dismissedKey = 'setup.banner_dismissed';

  /// Manufacturers whose power management blocks broadcast-triggered
  /// process starts by default. Others don't get asked about autostart.
  static const _autostartVendors = {
    'xiaomi',
    'redmi',
    'poco',
    'huawei',
    'honor',
    'oppo',
    'realme',
    'vivo',
    'oneplus',
    'meizu',
    'letv',
    'asus',
  };

  Future<SetupStatus> read() async {
    final prefs = await SharedPreferences.getInstance();
    final needsAutostart = await _needsAutostartStep();

    return SetupStatus([
      SetupCheckState(
        check: SetupCheck.sms,
        isSatisfied: await Permission.sms.isGranted,
        isVerifiable: true,
      ),
      SetupCheckState(
        check: SetupCheck.notifications,
        isSatisfied: await Permission.notification.isGranted,
        isVerifiable: true,
      ),
      SetupCheckState(
        check: SetupCheck.battery,
        isSatisfied: await Permission.ignoreBatteryOptimizations.isGranted,
        isVerifiable: true,
      ),
      if (needsAutostart)
        SetupCheckState(
          check: SetupCheck.autostart,
          isSatisfied: prefs.getBool(_autostartConfirmedKey) ?? false,
          isVerifiable: false,
        ),
    ]);
  }

  Future<bool> _needsAutostartStep() async {
    try {
      final manufacturer =
          await _channel.invokeMethod<String>('manufacturer') ?? '';
      return _autostartVendors.contains(manufacturer);
    } on PlatformException {
      // Unknown vendor: better to offer the step than to hide it.
      return true;
    } on MissingPluginException {
      return false;
    }
  }

  /// Runs the repair action for [check]. Returns once the user is back, so
  /// callers should re-[read] afterwards.
  Future<void> fix(SetupCheck check) async {
    switch (check) {
      case SetupCheck.sms:
        await ref.read(smsPermissionsProvider).requestSms();
        // Granting alone isn't enough — the receiver has to be registered.
        await ref.read(smsListenerProvider).ensureStarted();
      case SetupCheck.notifications:
        await ref.read(smsPermissionsProvider).requestNotifications();
      case SetupCheck.battery:
        await Permission.ignoreBatteryOptimizations.request();
      case SetupCheck.autostart:
        await openAutostartSettings();
    }
  }

  Future<void> openAutostartSettings() async {
    try {
      await _channel.invokeMethod<bool>('openAutostartSettings');
    } on PlatformException {
      await openAppSettings();
    }
  }

  /// Records the user's confirmation that they enabled autostart, since the
  /// system won't tell us.
  Future<void> setAutostartConfirmed(bool confirmed) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_autostartConfirmedKey, confirmed);
  }

  Future<bool> isBannerDismissed() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_dismissedKey) ?? false;
  }

  Future<void> dismissBanner() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_dismissedKey, true);
  }
}

final deviceSetupProvider =
    Provider<DeviceSetup>((ref) => DeviceSetup(ref: ref));

/// Current setup state. Invalidate after any fix to re-read.
final setupStatusProvider = FutureProvider<SetupStatus>((ref) {
  return ref.watch(deviceSetupProvider).read();
});
