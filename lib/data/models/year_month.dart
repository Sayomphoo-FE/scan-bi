import 'package:intl/intl.dart';

class YearMonth {
  final int year;
  final int month;

  const YearMonth({required this.year, required this.month});

  factory YearMonth.fromDateTime(DateTime dt) {
    return YearMonth(year: dt.year, month: dt.month);
  }

  factory YearMonth.now() {
    final now = DateTime.now();
    return YearMonth(year: now.year, month: now.month);
  }

  YearMonth get previous {
    if (month == 1) {
      return YearMonth(year: year - 1, month: 12);
    }
    return YearMonth(year: year, month: month - 1);
  }

  YearMonth get next {
    if (month == 12) {
      return YearMonth(year: year + 1, month: 1);
    }
    return YearMonth(year: year, month: month + 1);
  }

  DateTime get startDate => DateTime(year, month, 1);
  DateTime get endDate =>
      DateTime(year, month + 1, 1).subtract(const Duration(days: 1));

  /// ISO date string for the first day of month, e.g. "2025-05-01"
  String get startDateString =>
      '${year.toString().padLeft(4, '0')}-${month.toString().padLeft(2, '0')}-01';

  /// ISO date string for last day of month, e.g. "2025-05-31"
  String get endDateString {
    final end = DateTime(year, month + 1, 0);
    return '${end.year.toString().padLeft(4, '0')}-${end.month.toString().padLeft(2, '0')}-${end.day.toString().padLeft(2, '0')}';
  }

  String toDisplayString({String locale = 'en'}) {
    return DateFormat('MMMM yyyy', locale).format(DateTime(year, month));
  }

  @override
  bool operator ==(Object other) =>
      other is YearMonth && year == other.year && month == other.month;

  @override
  int get hashCode => Object.hash(year, month);

  @override
  String toString() => '$year-${month.toString().padLeft(2, '0')}';
}
