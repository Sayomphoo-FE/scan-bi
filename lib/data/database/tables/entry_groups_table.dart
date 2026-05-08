import 'package:drift/drift.dart';

/// Table for entry_groups
class EntryGroupsTable extends Table {
  @override
  String get tableName => 'entry_groups';

  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get iconType => text()();
  TextColumn get iconValue => text()();
  TextColumn get createdAt => text()();

  @override
  Set<Column> get primaryKey => {id};
}
