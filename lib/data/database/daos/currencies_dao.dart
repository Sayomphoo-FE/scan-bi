import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/currencies_table.dart';
import '../../models/currency.dart';

part 'currencies_dao.g.dart';

@DriftAccessor(tables: [CurrenciesTable])
class CurrenciesDao extends DatabaseAccessor<AppDatabase>
    with _$CurrenciesDaoMixin {
  CurrenciesDao(super.db);

  CurrencyModel _rowToModel(CurrenciesTableData row) {
    return CurrencyModel(
      code: row.code,
      name: row.name,
      symbol: row.symbol,
      rateToBase: row.rateToBase,
    );
  }

  CurrenciesTableCompanion _modelToCompanion(CurrencyModel model) {
    return CurrenciesTableCompanion(
      code: Value(model.code),
      name: Value(model.name),
      symbol: Value(model.symbol),
      rateToBase: Value(model.rateToBase),
    );
  }

  Future<void> upsertCurrency(CurrencyModel currency) async {
    await into(
      currenciesTable,
    ).insertOnConflictUpdate(_modelToCompanion(currency));
  }

  Future<void> deleteCurrency(String code) async {
    await (delete(currenciesTable)..where((t) => t.code.equals(code))).go();
  }

  Future<CurrencyModel?> getCurrencyByCode(String code) async {
    final row = await (select(
      currenciesTable,
    )..where((t) => t.code.equals(code)))
        .getSingleOrNull();
    return row == null ? null : _rowToModel(row);
  }

  Stream<List<CurrencyModel>> watchAllCurrencies() {
    return (select(currenciesTable)..orderBy([(t) => OrderingTerm.asc(t.code)]))
        .watch()
        .map((rows) => rows.map(_rowToModel).toList());
  }

  Future<List<CurrencyModel>> getAllCurrencies() async {
    final rows = await (select(
      currenciesTable,
    )..orderBy([(t) => OrderingTerm.asc(t.code)]))
        .get();
    return rows.map(_rowToModel).toList();
  }
}
