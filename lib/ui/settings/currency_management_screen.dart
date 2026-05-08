import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants.dart';
import '../../data/models/currency.dart';
import '../../providers/currency_providers.dart';

class CurrencyManagementScreen extends ConsumerStatefulWidget {
  const CurrencyManagementScreen({super.key});

  @override
  ConsumerState<CurrencyManagementScreen> createState() =>
      _CurrencyManagementScreenState();
}

class _CurrencyManagementScreenState
    extends ConsumerState<CurrencyManagementScreen> {
  bool _isRefreshing = false;

  Future<void> _refreshRates() async {
    setState(() => _isRefreshing = true);
    try {
      final service = ref.read(exchangeRateServiceProvider);
      final rates = await service.fetchRates(base: 'USD');

      final repo = ref.read(currencyRepositoryProvider);
      final currencies = await repo.getAllCurrencies();

      // USD rate for THB (base currency) — from AppConstants
      final usdToThb = AppConstants.usdToThbFallbackRate;
      for (final currency in currencies) {
        final usdRate = rates[currency.code];
        if (usdRate != null && usdRate != 0) {
          // rate_to_base = how many of base (THB) per 1 unit of this currency
          // 1 USD = usdToThb THB, 1 XYZ = (usdToThb / usdRate) THB
          final rateToBase = usdToThb / usdRate;
          await repo.upsertCurrency(currency.copyWith(rateToBase: rateToBase));
        }
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Exchange rates updated!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to refresh rates: $e')));
      }
    } finally {
      if (mounted) setState(() => _isRefreshing = false);
    }
  }

  Future<void> _addCurrency(BuildContext context) async {
    final service = ref.read(exchangeRateServiceProvider);
    String query = '';
    List<CurrencyModel> results = service.searchCurrencies('');

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setModalState) => DraggableScrollableSheet(
          initialChildSize: 0.7,
          expand: false,
          builder: (ctx, scrollCtrl) => Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  decoration: const InputDecoration(
                    labelText: 'Search currency',
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (v) {
                    setModalState(() {
                      query = v;
                      results = service.searchCurrencies(v);
                    });
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  controller: scrollCtrl,
                  itemCount: results.length,
                  itemBuilder: (ctx, i) {
                    final c = results[i];
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text(
                          c.symbol,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                      title: Text('${c.code} — ${c.name}'),
                      subtitle: Text(
                        'Rate to THB: ${c.rateToBase.toStringAsFixed(4)}',
                      ),
                      onTap: () async {
                        await ref
                            .read(currencyRepositoryProvider)
                            .upsertCurrency(c);
                        if (ctx.mounted) Navigator.pop(ctx);
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Added ${c.code}')),
                          );
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currenciesAsync = ref.watch(allCurrenciesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Management'),
        actions: [
          if (_isRefreshing)
            const Padding(
              padding: EdgeInsets.all(16),
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            )
          else
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: _refreshRates,
              tooltip: 'Refresh rates',
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addCurrency(context),
        child: const Icon(Icons.add),
      ),
      body: currenciesAsync.when(
        data: (currencies) {
          if (currencies.isEmpty) {
            return const Center(child: Text('No currencies saved.'));
          }
          return ListView.builder(
            padding: const EdgeInsets.only(bottom: 100),
            itemCount: currencies.length,
            itemBuilder: (ctx, i) {
              final c = currencies[i];
              return ListTile(
                leading: CircleAvatar(
                  child: Text(c.symbol, style: const TextStyle(fontSize: 12)),
                ),
                title: Text('${c.code} — ${c.name}'),
                subtitle: Text(
                  '1 ${c.code} = ${c.rateToBase.toStringAsFixed(4)} THB',
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () => _deleteCurrency(context, c),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }

  Future<void> _deleteCurrency(
    BuildContext context,
    CurrencyModel currency,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Remove ${currency.code}'),
        content: const Text('Remove this currency?'),
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
            child: const Text('Remove'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await ref.read(currencyRepositoryProvider).deleteCurrency(currency.code);
    }
  }
}
