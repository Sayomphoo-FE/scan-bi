import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../core/constants.dart';
import '../models/currency.dart';

class ExchangeRateService {
  Future<Map<String, double>> fetchRates({String base = 'USD'}) async {
    try {
      final uri = Uri.parse(
        '${AppConstants.exchangeRateBaseUrl}/latest.json'
        '?app_id=${AppConstants.exchangeRateApiKey}&base=$base',
      );
      final response = await http.get(uri);
      if (response.statusCode != 200) {
        throw Exception('Failed to fetch rates: ${response.statusCode}');
      }
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final rates = data['rates'] as Map<String, dynamic>;
      return rates.map((k, v) => MapEntry(k, (v as num).toDouble()));
    } catch (e) {
      debugPrint('ExchangeRateService error: $e');
      rethrow;
    }
  }

  /// Fetch rate for a specific currency code relative to base currency.
  /// Returns null if not available.
  Future<double?> getRateForCurrency({
    required String currencyCode,
    String base = 'USD',
  }) async {
    try {
      final rates = await fetchRates(base: base);
      return rates[currencyCode];
    } catch (_) {
      return null;
    }
  }

  /// Search currencies from a predefined list (offline-capable)
  List<CurrencyModel> searchCurrencies(String query) {
    final q = query.toLowerCase().trim();
    if (q.isEmpty) return _allCurrencies;
    return _allCurrencies
        .where(
          (c) =>
              c.code.toLowerCase().contains(q) ||
              c.name.toLowerCase().contains(q),
        )
        .toList();
  }

  static const List<CurrencyModel> _allCurrencies = [
    CurrencyModel(code: 'THB', name: 'Thai Baht', symbol: '฿', rateToBase: 1.0),
    CurrencyModel(
      code: 'USD',
      name: 'US Dollar',
      symbol: '\$',
      rateToBase: 0.028,
    ),
    CurrencyModel(code: 'EUR', name: 'Euro', symbol: '€', rateToBase: 0.026),
    CurrencyModel(
      code: 'JPY',
      name: 'Japanese Yen',
      symbol: '¥',
      rateToBase: 4.23,
    ),
    CurrencyModel(
      code: 'GBP',
      name: 'British Pound',
      symbol: '£',
      rateToBase: 0.022,
    ),
    CurrencyModel(
      code: 'SGD',
      name: 'Singapore Dollar',
      symbol: 'S\$',
      rateToBase: 0.037,
    ),
    CurrencyModel(
      code: 'CNY',
      name: 'Chinese Yuan',
      symbol: '¥',
      rateToBase: 0.20,
    ),
    CurrencyModel(
      code: 'KRW',
      name: 'South Korean Won',
      symbol: '₩',
      rateToBase: 37.0,
    ),
    CurrencyModel(
      code: 'HKD',
      name: 'Hong Kong Dollar',
      symbol: 'HK\$',
      rateToBase: 0.22,
    ),
    CurrencyModel(
      code: 'AUD',
      name: 'Australian Dollar',
      symbol: 'A\$',
      rateToBase: 0.043,
    ),
    CurrencyModel(
      code: 'CAD',
      name: 'Canadian Dollar',
      symbol: 'C\$',
      rateToBase: 0.038,
    ),
    CurrencyModel(
      code: 'CHF',
      name: 'Swiss Franc',
      symbol: 'CHF',
      rateToBase: 0.025,
    ),
    CurrencyModel(
      code: 'INR',
      name: 'Indian Rupee',
      symbol: '₹',
      rateToBase: 2.33,
    ),
    CurrencyModel(
      code: 'MYR',
      name: 'Malaysian Ringgit',
      symbol: 'RM',
      rateToBase: 0.13,
    ),
    CurrencyModel(
      code: 'VND',
      name: 'Vietnamese Dong',
      symbol: '₫',
      rateToBase: 699.0,
    ),
  ];
}
