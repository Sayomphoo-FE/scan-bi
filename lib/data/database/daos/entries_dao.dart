import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/entries_table.dart';
import '../../models/entry.dart';
import '../../models/monthly_summary.dart';
import '../../models/year_month.dart';

part 'entries_dao.g.dart';

@DriftAccessor(tables: [EntriesTable])
class EntriesDao extends DatabaseAccessor<AppDatabase>
    with _$EntriesDaoMixin {
  EntriesDao(super.db);

  // Convert DB row to model
  EntryModel _rowToModel(EntriesTableData row) {
    return EntryModel(
      id: row.id,
      type: row.type,
      title: row.title,
      iconType: row.iconType,
      iconValue: row.iconValue,
      amount: row.amount,
      currencyCode: row.currencyCode,
      amountBase: row.amountBase,
      occurredAt: row.occurredAt,
      groupId: row.groupId,
      receiptImagePath: row.receiptImagePath,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }

  // Convert model to companion
  EntriesTableCompanion _modelToCompanion(EntryModel model) {
    return EntriesTableCompanion(
      id: Value(model.id),
      type: Value(model.type),
      title: Value(model.title),
      iconType: Value(model.iconType),
      iconValue: Value(model.iconValue),
      amount: Value(model.amount),
      currencyCode: Value(model.currencyCode),
      amountBase: Value(model.amountBase),
      occurredAt: Value(model.occurredAt),
      groupId: Value(model.groupId),
      receiptImagePath: Value(model.receiptImagePath),
      createdAt: Value(model.createdAt),
      updatedAt: Value(model.updatedAt),
    );
  }

  Future<void> insertEntry(EntryModel entry) async {
    await into(entriesTable).insert(_modelToCompanion(entry));
  }

  Future<void> updateEntry(EntryModel entry) async {
    await (update(entriesTable)..where((t) => t.id.equals(entry.id)))
        .write(_modelToCompanion(entry));
  }

  Future<void> deleteEntry(String id) async {
    await (delete(entriesTable)..where((t) => t.id.equals(id))).go();
  }

  Future<void> deleteEntriesByGroupId(String groupId) async {
    await (delete(entriesTable)..where((t) => t.groupId.equals(groupId))).go();
  }

  Future<EntryModel?> getEntryById(String id) async {
    final row = await (select(entriesTable)
          ..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    return row == null ? null : _rowToModel(row);
  }

  /// Watch all entries ordered by occurredAt descending
  Stream<List<EntryModel>> watchAllEntries() {
    return (select(entriesTable)
          ..orderBy([(t) => OrderingTerm.desc(t.occurredAt)]))
        .watch()
        .map((rows) => rows.map(_rowToModel).toList());
  }

  /// Watch entries for a specific month
  Stream<List<EntryModel>> watchEntriesForMonth(YearMonth yearMonth) {
    return (select(entriesTable)
          ..where((t) =>
              t.occurredAt.isBiggerOrEqualValue(yearMonth.startDateString) &
              t.occurredAt.isSmallerOrEqualValue(yearMonth.endDateString))
          ..orderBy([(t) => OrderingTerm.desc(t.occurredAt)]))
        .watch()
        .map((rows) => rows.map(_rowToModel).toList());
  }

  /// Watch entries for a specific group
  Stream<List<EntryModel>> watchEntriesForGroup(String groupId) {
    return (select(entriesTable)
          ..where((t) => t.groupId.equals(groupId))
          ..orderBy([(t) => OrderingTerm.desc(t.occurredAt)]))
        .watch()
        .map((rows) => rows.map(_rowToModel).toList());
  }

  /// Watch monthly summary (income + expense totals)
  Stream<MonthlySummary> watchMonthlySummary(YearMonth yearMonth) {
    return watchEntriesForMonth(yearMonth).map((entries) {
      double totalIncome = 0;
      double totalExpense = 0;
      for (final e in entries) {
        if (e.isIncome) {
          totalIncome += e.amountBase;
        } else {
          totalExpense += e.amountBase;
        }
      }
      return MonthlySummary(
        totalIncome: totalIncome,
        totalExpense: totalExpense,
      );
    });
  }
}
