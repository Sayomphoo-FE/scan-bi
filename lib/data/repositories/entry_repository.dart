import 'package:uuid/uuid.dart';

import '../database/app_database.dart';
import '../models/entry.dart';
import '../models/monthly_summary.dart';
import '../models/year_month.dart';

class EntryRepository {
  final AppDatabase _db;
  final _uuid = const Uuid();

  EntryRepository(this._db);

  Stream<List<EntryModel>> watchAllEntries() =>
      _db.entriesDao.watchAllEntries();

  Stream<List<EntryModel>> watchEntriesForMonth(YearMonth yearMonth) =>
      _db.entriesDao.watchEntriesForMonth(yearMonth);

  Stream<List<EntryModel>> watchEntriesForGroup(String groupId) =>
      _db.entriesDao.watchEntriesForGroup(groupId);

  Stream<MonthlySummary> watchMonthlySummary(YearMonth yearMonth) =>
      _db.entriesDao.watchMonthlySummary(yearMonth);

  Future<EntryModel?> getEntryById(String id) =>
      _db.entriesDao.getEntryById(id);

  Future<String> addEntry({
    required String type,
    required String title,
    required String iconType,
    required String iconValue,
    required double amount,
    required String currencyCode,
    required double amountBase,
    required String occurredAt,
    String? groupId,
    String? receiptImagePath,
  }) async {
    final now = DateTime.now().toIso8601String();
    final id = _uuid.v4();
    final entry = EntryModel(
      id: id,
      type: type,
      title: title,
      iconType: iconType,
      iconValue: iconValue,
      amount: amount,
      currencyCode: currencyCode,
      amountBase: amountBase,
      occurredAt: occurredAt,
      groupId: groupId,
      receiptImagePath: receiptImagePath,
      createdAt: now,
      updatedAt: now,
    );
    await _db.entriesDao.insertEntry(entry);
    return id;
  }

  Future<void> updateEntry(EntryModel entry) async {
    final updated = entry.copyWith(
      updatedAt: DateTime.now().toIso8601String(),
    );
    await _db.entriesDao.updateEntry(updated);
  }

  Future<void> deleteEntry(String id) => _db.entriesDao.deleteEntry(id);

  Future<void> deleteEntriesByGroupId(String groupId) =>
      _db.entriesDao.deleteEntriesByGroupId(groupId);
}
