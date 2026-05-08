import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../data/models/entry.dart';
import '../../../data/models/entry_group.dart';
import '../../../data/models/year_month.dart';
import '../../../providers/entry_providers.dart';
import '../../../providers/group_providers.dart';
import '../../../l10n/app_localizations.dart';
import 'date_group_header.dart';
import 'standalone_entry_row.dart';
import 'group_entry_card.dart';

class EntryListByDate extends ConsumerWidget {
  final YearMonth selectedMonth;

  const EntryListByDate({super.key, required this.selectedMonth});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entriesAsync = ref.watch(monthEntriesProvider(selectedMonth));
    final groupsAsync = ref.watch(allGroupsProvider);

    return entriesAsync.when(
      data: (entries) {
        if (entries.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.receipt_long_outlined, size: 64, color: Colors.grey),
                const SizedBox(height: 16),
                Text(
                  AppLocalizations.of(context)!.noEntriesThisMonth,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          );
        }

        final groups = groupsAsync.valueOrNull ?? [];
        final groupMap = {for (final g in groups) g.id: g};

        // Group entries by date, then by groupId
        final byDate = <String, List<EntryModel>>{};
        for (final e in entries) {
          byDate.putIfAbsent(e.occurredAt, () => []).add(e);
        }

        final sortedDates = byDate.keys.toList()
          ..sort((a, b) => b.compareTo(a));

        return ListView.builder(
          padding: const EdgeInsets.only(bottom: 100),
          itemCount: sortedDates.length,
          itemBuilder: (context, index) {
            final date = sortedDates[index];
            final dayEntries = byDate[date]!;

            // Calculate net for the day
            double dayNet = 0;
            for (final e in dayEntries) {
              if (e.isIncome) {
                dayNet += e.amountBase;
              } else {
                dayNet -= e.amountBase;
              }
            }

            // Separate standalone entries and grouped entries
            final standaloneEntries =
                dayEntries.where((e) => e.groupId == null).toList();
            final groupedEntries =
                dayEntries.where((e) => e.groupId != null).toList();

            // Group by groupId
            final groupedByGroup = <String, List<EntryModel>>{};
            for (final e in groupedEntries) {
              if (e.groupId != null) {
                groupedByGroup.putIfAbsent(e.groupId!, () => []).add(e);
              }
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DateGroupHeader(date: date, dayNet: dayNet),
                ...standaloneEntries.map(
                  (e) => StandaloneEntryRow(entry: e),
                ),
                ...groupedByGroup.entries.map((ge) {
                  final group = groupMap[ge.key];
                  if (group == null) {
                    return Column(
                      children: ge.value
                          .map((e) => StandaloneEntryRow(entry: e))
                          .toList(),
                    );
                  }
                  return GroupEntryCard(
                    group: group,
                    entries: ge.value,
                  );
                }),
                if (index < sortedDates.length - 1)
                  const Divider(height: 16, thickness: 0.5),
              ],
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
    );
  }
}
