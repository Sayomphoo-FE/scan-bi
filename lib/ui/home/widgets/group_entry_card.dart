import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../data/models/entry.dart';
import '../../../data/models/entry_group.dart';
import 'standalone_entry_row.dart';

class GroupEntryCard extends StatefulWidget {
  final EntryGroupModel group;
  final List<EntryModel> entries;

  const GroupEntryCard({
    super.key,
    required this.group,
    required this.entries,
  });

  @override
  State<GroupEntryCard> createState() => _GroupEntryCardState();
}

class _GroupEntryCardState extends State<GroupEntryCard> {
  bool _expanded = false;

  double get _totalAmount =>
      widget.entries.fold(0, (sum, e) => sum + e.amountBase);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final total = _totalAmount;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Column(
        children: [
          InkWell(
            onTap: () => setState(() => _expanded = !_expanded),
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  _buildGroupIcon(theme),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.group.name,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${widget.entries.length} items',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        total.toCurrencyString(),
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFF44336),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    _expanded ? Icons.expand_less : Icons.expand_more,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ],
              ),
            ),
          ),
          if (_expanded) ...[
            const Divider(height: 1),
            ...widget.entries.map(
              (e) => Row(
                children: [
                  Expanded(child: StandaloneEntryRow(entry: e)),
                  IconButton(
                    icon: const Icon(Icons.edit_outlined, size: 18),
                    onPressed: () => context.push('/entry/${e.id}/edit'),
                    tooltip: 'Edit',
                  ),
                ],
              ),
            ),
            // Tap group header to view group detail
            TextButton(
              onPressed: () =>
                  context.push('/group/${widget.group.id}'),
              child: const Text('View Group Detail'),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildGroupIcon(ThemeData theme) {
    if (widget.group.iconType == 'emoji') {
      return CircleAvatar(
        backgroundColor: theme.colorScheme.primaryContainer,
        child: Text(
          widget.group.iconValue,
          style: const TextStyle(fontSize: 20),
        ),
      );
    }
    return CircleAvatar(
      backgroundColor: theme.colorScheme.primaryContainer,
      child: const Icon(Icons.folder_outlined),
    );
  }
}
