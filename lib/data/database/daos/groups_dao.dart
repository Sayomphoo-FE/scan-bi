import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/entry_groups_table.dart';
import '../../models/entry_group.dart';

part 'groups_dao.g.dart';

@DriftAccessor(tables: [EntryGroupsTable])
class GroupsDao extends DatabaseAccessor<AppDatabase> with _$GroupsDaoMixin {
  GroupsDao(super.db);

  EntryGroupModel _rowToModel(EntryGroupsTableData row) {
    return EntryGroupModel(
      id: row.id,
      name: row.name,
      iconType: row.iconType,
      iconValue: row.iconValue,
      createdAt: row.createdAt,
    );
  }

  EntryGroupsTableCompanion _modelToCompanion(EntryGroupModel model) {
    return EntryGroupsTableCompanion(
      id: Value(model.id),
      name: Value(model.name),
      iconType: Value(model.iconType),
      iconValue: Value(model.iconValue),
      createdAt: Value(model.createdAt),
    );
  }

  Future<void> insertGroup(EntryGroupModel group) async {
    await into(entryGroupsTable).insert(_modelToCompanion(group));
  }

  Future<void> updateGroup(EntryGroupModel group) async {
    await (update(
      entryGroupsTable,
    )..where((t) => t.id.equals(group.id)))
        .write(_modelToCompanion(group));
  }

  Future<void> deleteGroup(String id) async {
    await (delete(entryGroupsTable)..where((t) => t.id.equals(id))).go();
  }

  Future<EntryGroupModel?> getGroupById(String id) async {
    final row = await (select(
      entryGroupsTable,
    )..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    return row == null ? null : _rowToModel(row);
  }

  Stream<List<EntryGroupModel>> watchAllGroups() {
    return (select(entryGroupsTable)
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .watch()
        .map((rows) => rows.map(_rowToModel).toList());
  }

  Stream<EntryGroupModel?> watchGroupById(String id) {
    return (select(entryGroupsTable)..where((t) => t.id.equals(id)))
        .watchSingleOrNull()
        .map((row) => row == null ? null : _rowToModel(row));
  }
}
