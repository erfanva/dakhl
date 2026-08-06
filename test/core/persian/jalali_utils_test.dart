import 'package:dakhl/core/persian/jalali_utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shamsi_date/shamsi_date.dart';

void main() {
  group('JalaliMonth', () {
    test('ordinal arithmetic rolls over the year boundary', () {
      expect(const JalaliMonth(1405, 12) + 1, const JalaliMonth(1406, 1));
      expect(const JalaliMonth(1406, 1) - 1, const JalaliMonth(1405, 12));
    });

    test('adding many months stays consistent', () {
      expect(const JalaliMonth(1405, 5) + 12, const JalaliMonth(1406, 5));
    });

    test('first six months have 31 days, next five have 30', () {
      expect(const JalaliMonth(1405, 1).lengthInDays, 31);
      expect(const JalaliMonth(1405, 6).lengthInDays, 31);
      expect(const JalaliMonth(1405, 7).lengthInDays, 30);
      expect(const JalaliMonth(1405, 11).lengthInDays, 30);
    });

    test('endExclusive is the start of the next month', () {
      const month = JalaliMonth(1405, 5);
      expect(month.endExclusive, (month + 1).start);
    });

    test('label renders month name with Persian digits', () {
      expect(const JalaliMonth(1405, 5).label, 'مرداد ۱۴۰۵');
    });

    test('round-trips through a DateTime', () {
      final dt = Jalali(1405, 5, 14).toDateTime();
      expect(JalaliMonth.fromDateTime(dt), const JalaliMonth(1405, 5));
    });
  });

  group('dateForDayOfMonth clamping', () {
    test('keeps a valid day as-is', () {
      final date = JalaliUtils.dateForDayOfMonth(const JalaliMonth(1405, 1), 15);
      expect(Jalali.fromDateTime(date).day, 15);
    });

    test('clamps day 31 down in a 30-day month', () {
      final date = JalaliUtils.dateForDayOfMonth(const JalaliMonth(1405, 7), 31);
      expect(Jalali.fromDateTime(date).day, 30);
    });

    test('clamps to Esfand length', () {
      const esfand = JalaliMonth(1405, 12);
      final date = JalaliUtils.dateForDayOfMonth(esfand, 31);
      expect(Jalali.fromDateTime(date).day, esfand.lengthInDays);
      expect(esfand.lengthInDays, anyOf(29, 30));
    });

    test('carries the requested time of day', () {
      final date = JalaliUtils.dateForDayOfMonth(
        const JalaliMonth(1405, 5),
        10,
        hour: 9,
        minute: 30,
      );
      expect(date.hour, 9);
      expect(date.minute, 30);
    });
  });

  group('formatting', () {
    test('formatDate uses Persian digits and month name', () {
      final dt = Jalali(1405, 5, 14).toDateTime();
      expect(JalaliUtils.formatDate(dt), '۱۴ مرداد ۱۴۰۵');
    });

    test('formatTime zero-pads', () {
      final dt = DateTime(2026, 8, 5, 9, 5);
      expect(JalaliUtils.formatTime(dt), '۰۹:۰۵');
    });
  });

  test('startOfDay drops the time component', () {
    final dt = DateTime(2026, 8, 5, 14, 32, 11);
    expect(JalaliUtils.startOfDay(dt), DateTime(2026, 8, 5));
  });
}
