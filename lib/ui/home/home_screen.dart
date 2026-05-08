import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../data/models/year_month.dart';
import '../../providers/entry_providers.dart';
import '../../providers/group_providers.dart';
import 'widgets/month_summary_card.dart';
import 'widgets/entry_list_by_date.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  YearMonth _selectedMonth = YearMonth.now();

  void _previousMonth() {
    setState(() => _selectedMonth = _selectedMonth.previous);
  }

  void _nextMonth() {
    setState(() => _selectedMonth = _selectedMonth.next);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('scan-bi'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => context.push('/settings'),
            tooltip: 'Settings',
          ),
        ],
      ),
      body: Column(
        children: [
          MonthSummaryCard(
            selectedMonth: _selectedMonth,
            onPreviousMonth: _previousMonth,
            onNextMonth: _nextMonth,
          ),
          Expanded(
            child: EntryListByDate(selectedMonth: _selectedMonth),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddOptions(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.receipt_long_outlined),
              title: const Text('Add Single Entry'),
              onTap: () {
                Navigator.pop(ctx);
                context.push('/entry/add');
              },
            ),
            ListTile(
              leading: const Icon(Icons.folder_open_outlined),
              title: const Text('Create Group'),
              onTap: () {
                Navigator.pop(ctx);
                context.push('/group/add');
              },
            ),
          ],
        ),
      ),
    );
  }
}
