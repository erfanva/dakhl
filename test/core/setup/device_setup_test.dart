import 'package:dakhl/core/setup/device_setup.dart';
import 'package:flutter_test/flutter_test.dart';

SetupCheckState state(SetupCheck check, bool satisfied,
        {bool verifiable = true}) =>
    SetupCheckState(
      check: check,
      isSatisfied: satisfied,
      isVerifiable: verifiable,
    );

void main() {
  group('SetupStatus', () {
    test('is complete only when every check passes', () {
      expect(
        SetupStatus([
          state(SetupCheck.sms, true),
          state(SetupCheck.notifications, true),
        ]).isComplete,
        isTrue,
      );
      expect(
        SetupStatus([
          state(SetupCheck.sms, true),
          state(SetupCheck.notifications, false),
        ]).isComplete,
        isFalse,
      );
    });

    test('lists only the unsatisfied checks', () {
      final status = SetupStatus([
        state(SetupCheck.sms, true),
        state(SetupCheck.notifications, false),
        state(SetupCheck.battery, false),
      ]);

      expect(
        status.unsatisfied.map((c) => c.check),
        [SetupCheck.notifications, SetupCheck.battery],
      );
    });

    test('only missing SMS or notifications count as blocking', () {
      // Battery and autostart degrade background capture but don't stop the
      // app from working, so they shouldn't hijack launch.
      final soft = SetupStatus([
        state(SetupCheck.sms, true),
        state(SetupCheck.notifications, true),
        state(SetupCheck.battery, false),
        state(SetupCheck.autostart, false, verifiable: false),
      ]);
      expect(soft.isBlocking, isFalse);
      expect(soft.isComplete, isFalse);

      expect(
        SetupStatus([
          state(SetupCheck.sms, false),
          state(SetupCheck.notifications, true),
        ]).isBlocking,
        isTrue,
      );
      expect(
        SetupStatus([
          state(SetupCheck.sms, true),
          state(SetupCheck.notifications, false),
        ]).isBlocking,
        isTrue,
      );
    });

    test('an all-clear status is neither blocking nor incomplete', () {
      final status = SetupStatus([
        for (final check in SetupCheck.values) state(check, true),
      ]);

      expect(status.isComplete, isTrue);
      expect(status.isBlocking, isFalse);
      expect(status.unsatisfied, isEmpty);
    });

    test('autostart is reported as unverifiable', () {
      final autostart = state(SetupCheck.autostart, false, verifiable: false);
      expect(autostart.isVerifiable, isFalse);
    });
  });
}
