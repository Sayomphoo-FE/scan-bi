import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateGroupHeader extends StatelessWidget {
  final String date; // "YYYY-MM-DD"
  final double dayNet;

  const DateGroupHeader({
    super.key,
    required this.date,
    required this.dayNet,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    DateTime? parsedDate;
    try {
      parsedDate = DateTime.parse(date);
    } catch (_) {}

    final displayDate = parsedDate != null
        ? DateFormat('EEE, dd MMM yyyy').format(parsedDate)
        : date;

    final netColor = dayNet >= 0
        ? const Color(0xFF4CAF50)
        : const Color(0xFFF44336);
    final netPrefix = dayNet >= 0 ? '+' : '';

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            displayDate,
            style: theme.textTheme.labelMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            '$netPrefix฿${dayNet.abs().toStringAsFixed(2)}',
            style: theme.textTheme.labelMedium?.copyWith(
              color: netColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
