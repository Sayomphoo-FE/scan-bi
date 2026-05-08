import 'package:intl/intl.dart';

extension DateExtensions on DateTime {
  /// Format as "dd MMM yyyy" e.g. "07 May 2025"
  String toDisplayDate({String locale = 'en'}) {
    return DateFormat('dd MMM yyyy', locale).format(this);
  }

  /// Format as "YYYY-MM-DD" (ISO 8601 date only)
  String toIsoDate() {
    return DateFormat('yyyy-MM-dd').format(this);
  }

  /// Format as "MMM yyyy" e.g. "May 2025"
  String toMonthYear({String locale = 'en'}) {
    return DateFormat('MMM yyyy', locale).format(this);
  }

  /// Returns true if same calendar date as [other]
  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  /// Returns true if same month and year as [other]
  bool isSameMonth(DateTime other) {
    return year == other.year && month == other.month;
  }

  /// Start of the day (00:00:00)
  DateTime get startOfDay => DateTime(year, month, day);

  /// Start of the month
  DateTime get startOfMonth => DateTime(year, month, 1);

  /// End of the month (last millisecond)
  DateTime get endOfMonth =>
      DateTime(year, month + 1, 1).subtract(const Duration(milliseconds: 1));
}
