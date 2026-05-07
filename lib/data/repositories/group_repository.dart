import 'package:uuid/uuid.dart';

import '../database/app_database.dart';
import '../models/entry_group.dart';

class GroupRepository {
  final AppDatabase _db;
  final _uuid = const Uuid();

  GroupRepository(this._db);

  Stream<List<EntryGroupModel>> watchAllGroups() =>
      _db.groupsDao.watchAllGroups();

  Stream<EntryGroupModel?> watchGroupById(String id) =>
      _db.groupsDao.watchGroupById(id);

  Future<EntryGroupModel?> getGroupById(String id) =>
      _db.groupsDao.getGroupById(id);

  Future<String> createGroup({
    required String name,
    required String iconType,
    required String iconValue,
  }) async {
    final id = _uuid.v4();
    final group = EntryGroupModel(
      id: id,
      name: name,
      iconType: iconType,
      iconValue: iconValue,
      createdAt: DateTime.now().toIso8601String(),
    );
    await _db.groupsDao.insertGroup(group);
    return id;
  }

  Future<void> updateGroup(EntryGroupModel group) =>
      _db.groupsDao.updateGroup(group);

  Future<void> deleteGroup(String id) => _db.groupsDao.deleteGroup(id);
}
