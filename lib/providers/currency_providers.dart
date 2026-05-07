import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/currency.dart';
import '../data/repositories/currency_repository.dart';
import '../data/services/exchange_rate_service.dart';
import 'database_provider.dart';

final currencyRepositoryProvider = Provider<CurrencyRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return CurrencyRepository(db);
});

final exchangeRateServiceProvider = Provider<ExchangeRateService>(
  (_) => ExchangeRateService(),
);

final allCurrenciesProvider = StreamProvider<List<CurrencyModel>>((ref) {
  return ref.watch(currencyRepositoryProvider).watchAllCurrencies();
});
