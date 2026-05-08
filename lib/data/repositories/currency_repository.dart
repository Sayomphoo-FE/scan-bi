import '../database/app_database.dart';
import '../models/currency.dart';

class CurrencyRepository {
  final AppDatabase _db;

  CurrencyRepository(this._db);

  Stream<List<CurrencyModel>> watchAllCurrencies() =>
      _db.currenciesDao.watchAllCurrencies();

  Future<List<CurrencyModel>> getAllCurrencies() =>
      _db.currenciesDao.getAllCurrencies();

  Future<CurrencyModel?> getCurrencyByCode(String code) =>
      _db.currenciesDao.getCurrencyByCode(code);

  Future<void> upsertCurrency(CurrencyModel currency) =>
      _db.currenciesDao.upsertCurrency(currency);

  Future<void> deleteCurrency(String code) =>
      _db.currenciesDao.deleteCurrency(code);
}
