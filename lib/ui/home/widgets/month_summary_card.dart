import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/year_month.dart';
import '../../../providers/monthly_summary_provider.dart';
import 'progress_bar_widget.dart';

class MonthSummaryCard extends ConsumerWidget {
  final YearMonth selectedMonth;
  final VoidCallback onPreviousMonth;
  final VoidCallback onNextMonth;

  const MonthSummaryCard({
    super.key,
    required this.selectedMonth,
    required this.onPreviousMonth,
    required this.onNextMonth,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summaryAsync = ref.watch(monthlySummaryProvider(selectedMonth));
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Month selector row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: onPreviousMonth,
                  icon: const Icon(Icons.chevron_left),
                ),
                Text(
                  selectedMonth.toDisplayString(),
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: onNextMonth,
                  icon: const Icon(Icons.chevron_right),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Summary data - 3 lines layout
            summaryAsync.when(
              data: (summary) => Column(
                children: [
                  // Line 1: Balance (large)
                  Text(
                    summary.balance.toCurrencyString(),
                    style: theme.textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: summary.balance >= 0
                          ? const Color(0xFF4CAF50)
                          : const Color(0xFFF44336),
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  // Line 2: Income & Expense with percentages
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: _SummaryItemSmall(
                          label: 'Income',
                          amount: summary.totalIncome,
                          color: const Color(0xFF4CAF50),
                        ),
                      ),
                      Expanded(
                        child: _SummaryItemSmall(
                          label: 'Expense',
                          amount: summary.totalExpense,
                          subLabel: summary.totalIncome > 0
                              ? '${summary.expensePercent.toStringAsFixed(1)}%'
                              : '0%',
                          color: const Color(0xFFF44336),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  
                  // Line 3: Progress bar
                  ProgressBarWidget(
                    greenFlex: summary.greenFlex,
                    redFlex: summary.redFlex,
                  ),
                ],
              ),
              loading: () => const SizedBox(
                height: 60,
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (e, _) => Text('Error: $e'),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final String label;
  final double amount;
  final Color color;

  const _SummaryItem({
    required this.label,
    required this.amount,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          amount.toCurrencyString(),
          style: theme.textTheme.bodyMedium?.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class _SummaryItemSmall extends StatelessWidget {
  final String label;
  final double amount;
  final String? subLabel;
  final Color color;

  const _SummaryItemSmall({
    required this.label,
    required this.amount,
    this.subLabel,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          amount.toCurrencyString(),
          style: theme.textTheme.bodyMedium?.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (subLabel != null) ...[
          const SizedBox(height: 2),
          Text(
            subLabel!,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ],
    );
  }
}
