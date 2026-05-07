import 'package:drift/drift.dart';

/// Table for currencies
class CurrenciesTable extends Table {
  @override
  String get tableName => 'currencies';

  TextColumn get code => text()();
  TextColumn get name => text()();
  TextColumn get symbol => text()();
  RealColumn get rateToBase => real()();

  @override
  Set<Column> get primaryKey => {code};
}
