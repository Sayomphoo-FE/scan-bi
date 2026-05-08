import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/currency.dart';
import '../../../providers/currency_providers.dart';
import '../../../l10n/app_localizations.dart';

class CurrencySelector extends ConsumerWidget {
  final String selectedCode;
  final void Function(String code) onChanged;

  const CurrencySelector({
    super.key,
    required this.selectedCode,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currenciesAsync = ref.watch(allCurrenciesProvider);

    return currenciesAsync.when(
      data: (currencies) {
        if (currencies.isEmpty) {
          return const SizedBox.shrink();
        }

        // Ensure selectedCode is in list
        final validCode = currencies.any((c) => c.code == selectedCode)
            ? selectedCode
            : currencies.first.code;

        return DropdownButtonFormField<String>(
          value: validCode,
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context)!.currency,
          ),
          items: currencies.map((c) {
            return DropdownMenuItem(
              value: c.code,
              child: Text('${c.symbol} ${c.code} - ${c.name}'),
            );
          }).toList(),
          onChanged: (v) {
            if (v != null) onChanged(v);
          },
        );
      },
      loading: () => const LinearProgressIndicator(),
      error: (e, _) => Text('Error: $e'),
    );
  }
}
