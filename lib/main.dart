import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'data/database/app_database.dart';
import 'data/models/currency.dart';
import 'firebase_options.dart';
import 'providers/database_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();

  // Initialize Firebase (wrapped in try-catch for placeholder config)
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint('Firebase init skipped: $e');
  }

  // Seed default currencies on first launch
  final prefs = await SharedPreferences.getInstance();
  final db = AppDatabase();
  if (!prefs.containsKey('currencies_seeded')) {
    await _seedDefaultCurrencies(db);
    await prefs.setBool('currencies_seeded', true);
  }

  runApp(
    ProviderScope(
      overrides: [databaseProvider.overrideWithValue(db)],
      child: const ScanBiApp(),
    ),
  );
}

Future<void> _seedDefaultCurrencies(AppDatabase db) async {
  const defaultCurrencies = [
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
  ];

  for (final currency in defaultCurrencies) {
    await db.currenciesDao.upsertCurrency(currency);
  }
}
