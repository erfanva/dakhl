import 'package:shamsi_date/shamsi_date.dart';

import 'digits.dart';

/// A Jalali year+month pair — the unit almost every screen groups by.
class JalaliMonth implements Comparable<JalaliMonth> {
  const JalaliMonth(this.year, this.month);

  factory JalaliMonth.fromDateTime(DateTime dateTime) {
    final jalali = Jalali.fromDateTime(dateTime);
    return JalaliMonth(jalali.year, jalali.month);
  }

  factory JalaliMonth.now() => JalaliMonth.fromDateTime(DateTime.now());

  final int year;
  final int month;

  /// Months since Jalali year 0 — makes arithmetic and comparison trivial.
  int get ordinal => year * 12 + (month - 1);

  static JalaliMonth fromOrdinal(int ordinal) =>
      JalaliMonth(ordinal ~/ 12, ordinal % 12 + 1);

  JalaliMonth operator +(int months) => fromOrdinal(ordinal + months);
  JalaliMonth operator -(int months) => fromOrdinal(ordinal - months);

  /// Number of days in this month (accounts for leap Esfand).
  int get lengthInDays => Jalali(year, month, 1).monthLength;

  /// First instant of this month in local time.
  DateTime get start => Jalali(year, month, 1).toDateTime();

  /// First instant of the next month — use as an exclusive upper bound.
  DateTime get endExclusive => (this + 1).start;

  String get monthName => JalaliUtils.monthNames[month - 1];

  /// e.g. `مرداد ۱۴۰۵`
  String get label => '$monthName ${toPersianDigits(year.toString())}';

  @override
  int compareTo(JalaliMonth other) => ordinal.compareTo(other.ordinal);

  @override
  bool operator ==(Object other) =>
      other is JalaliMonth && other.year == year && other.month == month;

  @override
  int get hashCode => ordinal;

  @override
  String toString() => '$year-${month.toString().padLeft(2, '0')}';
}

abstract final class JalaliUtils {
  static const monthNames = [
    'فروردین',
    'اردیبهشت',
    'خرداد',
    'تیر',
    'مرداد',
    'شهریور',
    'مهر',
    'آبان',
    'آذر',
    'دی',
    'بهمن',
    'اسفند',
  ];

  static const weekDayNames = [
    'شنبه',
    'یکشنبه',
    'دوشنبه',
    'سه‌شنبه',
    'چهارشنبه',
    'پنجشنبه',
    'جمعه',
  ];

  /// Builds a DateTime for [day] of [month], clamping the day to the
  /// month's length. A recurring expense on the 31st lands on the 30th of
  /// a 30-day month and on the 29th/30th of Esfand.
  static DateTime dateForDayOfMonth(
    JalaliMonth month,
    int day, {
    int hour = 0,
    int minute = 0,
  }) {
    final clamped = day.clamp(1, month.lengthInDays);
    return Jalali(month.year, month.month, clamped, hour, minute).toDateTime();
  }

  /// `۱۴ مرداد ۱۴۰۵`
  static String formatDate(DateTime dateTime) {
    final j = Jalali.fromDateTime(dateTime);
    return '${toPersianDigits(j.day.toString())} ${monthNames[j.month - 1]} '
        '${toPersianDigits(j.year.toString())}';
  }

  /// `شنبه ۱۴ مرداد`
  static String formatDayHeader(DateTime dateTime) {
    final j = Jalali.fromDateTime(dateTime);
    return '${weekDayNames[j.weekDay - 1]} ${toPersianDigits(j.day.toString())} '
        '${monthNames[j.month - 1]}';
  }

  /// `۱۴:۰۵`
  static String formatTime(DateTime dateTime) {
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');
    return toPersianDigits('$hour:$minute');
  }

  /// `۱۴ مرداد ۱۴۰۵ — ۱۴:۰۵`
  static String formatDateTime(DateTime dateTime) =>
      '${formatDate(dateTime)} — ${formatTime(dateTime)}';

  /// Local midnight of [dateTime]'s Jalali day.
  static DateTime startOfDay(DateTime dateTime) =>
      DateTime(dateTime.year, dateTime.month, dateTime.day);
}
