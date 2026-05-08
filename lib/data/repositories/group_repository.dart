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
    DateTime? createdAt,
  }) async {
    final id = _uuid.v4();
    final group = EntryGroupModel(
      id: id,
      name: name,
      iconType: iconType,
      iconValue: iconValue,
      createdAt: (createdAt ?? DateTime.now()).toIso8601String(),
    );
    await _db.groupsDao.insertGroup(group);
    return id;
  }

  Future<void> updateGroup(EntryGroupModel group) =>
      _db.groupsDao.updateGroup(group);

  Future<void> updateGroupDateAndSyncEntries(
    String groupId,
    DateTime newDate,
  ) async {
    // Update group's created date
    final group = await _db.groupsDao.getGroupById(groupId);
    if (group != null) {
      final updatedGroup = group.copyWith(createdAt: newDate.toIso8601String());
      await _db.groupsDao.updateGroup(updatedGroup);

      // Update all entries in this group to have the same date
      final entries = await _db.entriesDao.getEntriesByGroupId(groupId);
      final dateStr = newDate.toIso8601String().split('T')[0];
      for (final entry in entries) {
        final updatedEntry = entry.copyWith(
          occurredAt: dateStr,
          updatedAt: DateTime.now().toIso8601String(),
        );
        await _db.entriesDao.updateEntry(updatedEntry);
      }
    }
  }

  Future<void> deleteGroup(String id) => _db.groupsDao.deleteGroup(id);
}
