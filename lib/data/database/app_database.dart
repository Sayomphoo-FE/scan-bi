import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'tables/entries_table.dart';
import 'tables/entry_groups_table.dart';
import 'tables/currencies_table.dart';
import 'daos/entries_dao.dart';
import 'daos/groups_dao.dart';
import 'daos/currencies_dao.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [EntriesTable, EntryGroupsTable, CurrenciesTable],
  daos: [EntriesDao, GroupsDao, CurrenciesDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        await m.createAll();
      },
      onUpgrade: (m, from, to) async {
        // Future migrations here
      },
    );
  }

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'scan_bi_db');
  }
}
