import 'package:drift/drift.dart';

import 'entry_groups_table.dart';

/// Table for entries
class EntriesTable extends Table {
  @override
  String get tableName => 'entries';

  TextColumn get id => text()();
  TextColumn get type => text()(); // "income" | "expense"
  TextColumn get title => text()();
  TextColumn get iconType => text()();
  TextColumn get iconValue => text()();
  RealColumn get amount => real()();
  TextColumn get currencyCode => text()();
  RealColumn get amountBase => real()();
  TextColumn get occurredAt => text()(); // ISO 8601 date
  TextColumn get groupId =>
      text().nullable().references(EntryGroupsTable, #id)();
  TextColumn get receiptImagePath => text().nullable()();
  TextColumn get createdAt => text()();
  TextColumn get updatedAt => text()();

  @override
  Set<Column> get primaryKey => {id};
}
