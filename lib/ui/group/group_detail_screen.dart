import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../data/models/entry.dart';
import '../../providers/entry_providers.dart';
import '../../providers/group_providers.dart';

class GroupDetailScreen extends ConsumerWidget {
  final String groupId;

  const GroupDetailScreen({super.key, required this.groupId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupAsync = ref.watch(groupByIdProvider(groupId));
    final entriesAsync = ref.watch(groupEntriesProvider(groupId));

    return groupAsync.when(
      data: (group) {
        if (group == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Group')),
            body: const Center(child: Text('Group not found')),
          );
        }

        final entries = entriesAsync.valueOrNull ?? [];
        final total = entries.fold<double>(0, (s, e) => s + e.amountBase);

        return Scaffold(
          appBar: AppBar(
            title: Text(group.name),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit_outlined),
                onPressed: () => context.push('/group/$groupId/edit'),
                tooltip: 'Edit Group',
              ),
            ],
          ),
          body: Column(
            children: [
              // Group header card
              Card(
                margin: const EdgeInsets.all(16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor:
                            Theme.of(context).colorScheme.primaryContainer,
                        child: group.iconType == 'emoji'
                            ? Text(group.iconValue,
                                style: const TextStyle(fontSize: 26))
                            : const Icon(Icons.folder_outlined, size: 26),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(group.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    )),
                            Text(
                              '${entries.length} items  •  ฿${total.toStringAsFixed(2)}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Entries list
              Expanded(
                child: entries.isEmpty
                    ? const Center(child: Text('No entries in this group'))
                    : ListView.builder(
                        padding: const EdgeInsets.only(bottom: 100),
                        itemCount: entries.length,
                        itemBuilder: (ctx, i) {
                          final entry = entries[i];
                          return _EntryListTile(entry: entry);
                        },
                      ),
              ),
            ],
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FilledButton.icon(
                  onPressed: () =>
                      context.push('/entry/add?groupId=$groupId'),
                  icon: const Icon(Icons.add),
                  label: const Text('Add Entry to Group'),
                ),
                const SizedBox(height: 8),
                OutlinedButton(
                  onPressed: () => _deleteGroup(context, ref),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.error,
                    side: BorderSide(
                        color: Theme.of(context).colorScheme.error),
                    minimumSize: const Size.fromHeight(48),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Delete Entire Group'),
                ),
              ],
            ),
          ),
        );
      },
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('Error: $e'))),
    );
  }

  Future<void> _deleteGroup(BuildContext context, WidgetRef ref) async {
    final groupAsync = ref.read(groupByIdProvider(groupId));
    final entries = ref.read(groupEntriesProvider(groupId)).valueOrNull ?? [];

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Group'),
        content: Text(
          'Delete this group and all ${entries.length} entries inside?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(ctx).colorScheme.error,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      await ref.read(entryRepositoryProvider).deleteEntriesByGroupId(groupId);
      await ref.read(groupRepositoryProvider).deleteGroup(groupId);
      if (context.mounted) context.pop();
    }
  }
}

class _EntryListTile extends StatelessWidget {
  final EntryModel entry;

  const _EntryListTile({required this.entry});

  @override
  Widget build(BuildContext context) {
    final isIncome = entry.isIncome;
    final amountColor =
        isIncome ? const Color(0xFF4CAF50) : const Color(0xFFF44336);
    final prefix = isIncome ? '+' : '-';

    return ListTile(
      leading: CircleAvatar(
        backgroundColor:
            Theme.of(context).colorScheme.surfaceContainerHighest,
        child: entry.iconType == 'emoji'
            ? Text(entry.iconValue, style: const TextStyle(fontSize: 18))
            : const Icon(Icons.receipt, size: 18),
      ),
      title: Text(entry.title),
      subtitle: Text(entry.occurredAt),
      trailing: Text(
        '$prefix${entry.currencyCode} ${entry.amount.toStringAsFixed(2)}',
        style: TextStyle(
          color: amountColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: () => GoRouter.of(context).push('/entry/${entry.id}/edit'),
    );
  }
}
