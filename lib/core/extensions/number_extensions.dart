import 'package:intl/intl.dart';

extension NumberExtensions on double {
  /// Format as currency string with symbol and 2 decimal places
  /// e.g. 1234.5 → "฿ 1,234.50"
  String toCurrencyString({String symbol = '฿', String locale = 'en'}) {
    final formatter = NumberFormat.currency(
      locale: locale,
      symbol: '$symbol ',
      decimalDigits: 2,
    );
    return formatter.format(this);
  }

  /// Format as compact number e.g. 1234.5 → "1.23K"
  String toCompact({String locale = 'en'}) {
    final formatter = NumberFormat.compact(locale: locale);
    return formatter.format(this);
  }

  /// Format with 2 decimal places and thousands separator
  String toAmountString({String locale = 'en'}) {
    final formatter = NumberFormat('#,##0.00', locale);
    return formatter.format(this);
  }

  /// Returns sign prefix: "+" for positive, "-" for negative, "" for zero
  String get signPrefix {
    if (this > 0) return '+';
    if (this < 0) return '';
    return '';
  }
}

extension NullableNumberExtensions on double? {
  double get orZero => this ?? 0.0;
}
