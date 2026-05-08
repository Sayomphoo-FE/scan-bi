import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/entry_group.dart';
import '../data/repositories/group_repository.dart';
import 'database_provider.dart';

final groupRepositoryProvider = Provider<GroupRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return GroupRepository(db);
});

final allGroupsProvider = StreamProvider<List<EntryGroupModel>>((ref) {
  return ref.watch(groupRepositoryProvider).watchAllGroups();
});

final groupByIdProvider = StreamProvider.family<EntryGroupModel?, String>((
  ref,
  id,
) {
  return ref.watch(groupRepositoryProvider).watchGroupById(id);
});
