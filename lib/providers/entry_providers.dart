import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/entry.dart';
import '../data/models/year_month.dart';
import '../data/repositories/entry_repository.dart';
import 'database_provider.dart';

final entryRepositoryProvider = Provider<EntryRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return EntryRepository(db);
});

/// Watch all entries (descending by date)
final allEntriesProvider = StreamProvider<List<EntryModel>>((ref) {
  return ref.watch(entryRepositoryProvider).watchAllEntries();
});

/// Watch entries for a specific month
final monthEntriesProvider = StreamProvider.family<List<EntryModel>, YearMonth>(
  (ref, yearMonth) {
    return ref.watch(entryRepositoryProvider).watchEntriesForMonth(yearMonth);
  },
);

/// Watch entries for a specific group
final groupEntriesProvider = StreamProvider.family<List<EntryModel>, String>((
  ref,
  groupId,
) {
  return ref.watch(entryRepositoryProvider).watchEntriesForGroup(groupId);
});
