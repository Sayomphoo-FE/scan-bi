import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/auth_provider.dart';
import '../../providers/currency_providers.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  String _baseCurrency = AppConstants.defaultBaseCurrency;
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _loadBaseCurrency();
    _loadDarkMode();
  }

  Future<void> _loadDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool('dark_mode') ?? false;
    if (mounted) setState(() => _isDarkMode = isDark);
  }

  Future<void> _saveDarkMode(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('dark_mode', isDark);
    setState(() => _isDarkMode = isDark);
  }

  Future<void> _loadBaseCurrency() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(AppConstants.prefBaseCurrency) ??
        AppConstants.defaultBaseCurrency;
    if (mounted) setState(() => _baseCurrency = code);
  }

  Future<void> _saveBaseCurrency(String code) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConstants.prefBaseCurrency, code);
    setState(() => _baseCurrency = code);
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);
    final currenciesAsync = ref.watch(allCurrenciesProvider);

    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.settings)),
      body: ListView(
        children: [
          const _SectionHeader('Display'),
          // Dark mode toggle
          ListTile(
            leading: const Icon(Icons.dark_mode_outlined),
            title: Text(AppLocalizations.of(context)!.darkMode),
            subtitle: Text(_isDarkMode
                ? AppLocalizations.of(context)!.dark
                : AppLocalizations.of(context)!.light),
            trailing: Switch(
              value: _isDarkMode,
              onChanged: (value) => _saveDarkMode(value),
            ),
          ),
          const Divider(),
          const _SectionHeader('Finance'),
          // Base currency
          currenciesAsync.when(
            data: (currencies) => ListTile(
              leading: const Icon(Icons.swap_horiz_outlined),
              title: Text(AppLocalizations.of(context)!.currencyCode),
              subtitle: Text(_baseCurrency),
              trailing: DropdownButton<String>(
                value: currencies.any((c) => c.code == _baseCurrency)
                    ? _baseCurrency
                    : (currencies.isNotEmpty ? currencies.first.code : null),
                underline: const SizedBox.shrink(),
                items: currencies
                    .map((c) => DropdownMenuItem(
                          value: c.code,
                          child: Text(c.code),
                        ))
                    .toList(),
                onChanged: (v) {
                  if (v != null) _saveBaseCurrency(v);
                },
              ),
            ),
            loading: () => ListTile(
              title: Text(
                  AppLocalizations.of(context)!.loading),
            ),
            error: (e, _) => ListTile(title: Text('Error: $e')),
          ),
          ListTile(
            leading: const Icon(Icons.currency_exchange_outlined),
            title: const Text('Currency Management'),
            subtitle: const Text('Add, remove, refresh exchange rates'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push('/settings/currency'),
          ),

          const Divider(),
          const _SectionHeader('Account & Backup'),
          authState.when(
            data: (user) {
              if (user == null) {
                return ListTile(
                  leading: const Icon(Icons.account_circle_outlined),
                  title: const Text('Sign in with Google'),
                  subtitle: const Text('Enable Firestore backup'),
                  onTap: () async {
                    try {
                      await ref.read(authServiceProvider).signInWithGoogle();
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Sign-in failed: $e')),
                        );
                      }
                    }
                  },
                );
              }
              return Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: user.photoURL != null
                          ? NetworkImage(user.photoURL!)
                          : null,
                      child: user.photoURL == null
                          ? const Icon(Icons.person)
                          : null,
                    ),
                    title: Text(user.displayName ?? 'Signed in'),
                    subtitle: Text(user.email ?? ''),
                  ),
                  ListTile(
                    leading: const Icon(Icons.backup_outlined),
                    title: const Text('Backup & Restore'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => context.push('/settings/backup'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text('Sign Out'),
                    onTap: () async {
                      await ref.read(authServiceProvider).signOut();
                    },
                  ),
                ],
              );
            },
            loading: () =>
                const ListTile(title: Text('Checking sign-in status...')),
            error: (e, _) => ListTile(
              leading: const Icon(Icons.account_circle_outlined),
              title: const Text('Sign in with Google'),
              subtitle: const Text('Firebase not configured — sign-in unavailable'),
              enabled: false,
            ),
          ),

          const Divider(),
          const _SectionHeader('About'),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('scan-bi'),
            subtitle: const Text('Version 1.0.0'),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Text(
        title.toUpperCase(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
      ),
    );
  }
}
