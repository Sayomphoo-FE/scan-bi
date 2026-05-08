import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../data/models/entry.dart';

class StandaloneEntryRow extends StatelessWidget {
  final EntryModel entry;

  const StandaloneEntryRow({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isIncome = entry.isIncome;
    final amountColor =
        isIncome ? const Color(0xFF4CAF50) : const Color(0xFFF44336);
    final prefix = isIncome ? '+' : '-';

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      leading: _buildIcon(theme),
      title: Text(entry.title, style: theme.textTheme.bodyMedium),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '$prefix${entry.currencyCode} ${entry.amount.toAmountString()}',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: amountColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (entry.currencyCode != 'THB')
            Text(
              entry.amountBase.toCurrencyString(),
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
        ],
      ),
      onTap: () => context.push('/entry/${entry.id}/edit'),
    );
  }

  Widget _buildIcon(ThemeData theme) {
    if (entry.iconType == 'emoji') {
      return CircleAvatar(
        backgroundColor: theme.colorScheme.surfaceContainerHighest,
        child: Text(entry.iconValue, style: const TextStyle(fontSize: 20)),
      );
    }
    return CircleAvatar(
      backgroundColor: theme.colorScheme.surfaceContainerHighest,
      child: Icon(
        _getMaterialIcon(entry.iconValue),
        color: theme.colorScheme.onSurfaceVariant,
      ),
    );
  }

  IconData _getMaterialIcon(String name) {
    const iconMap = {
      'shopping_cart': Icons.shopping_cart,
      'restaurant': Icons.restaurant,
      'directions_car': Icons.directions_car,
      'home': Icons.home,
      'local_hospital': Icons.local_hospital,
      'school': Icons.school,
      'flight': Icons.flight,
      'sports_esports': Icons.sports_esports,
      'work': Icons.work,
      'attach_money': Icons.attach_money,
    };
    return iconMap[name] ?? Icons.receipt;
  }
}
