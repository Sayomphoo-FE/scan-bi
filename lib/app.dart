import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';

import 'core/theme/app_theme.dart';
import 'ui/home/home_screen.dart';
import 'ui/entry/add_edit_entry_screen.dart';
import 'ui/group/group_detail_screen.dart';
import 'ui/group/add_edit_group_screen.dart';
import 'ui/settings/settings_screen.dart';
import 'ui/settings/currency_management_screen.dart';
import 'ui/settings/backup_restore_screen.dart';

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/entry/add',
      builder: (context, state) {
        final groupId = state.uri.queryParameters['groupId'];
        return AddEditEntryScreen(groupId: groupId);
      },
    ),
    GoRoute(
      path: '/entry/:id/edit',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return AddEditEntryScreen(entryId: id);
      },
    ),
    GoRoute(
      path: '/group/add',
      builder: (context, state) => const AddEditGroupScreen(),
    ),
    GoRoute(
      path: '/group/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return GroupDetailScreen(groupId: id);
      },
    ),
    GoRoute(
      path: '/group/:id/edit',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return AddEditGroupScreen(groupId: id);
      },
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: '/settings/currency',
      builder: (context, state) => const CurrencyManagementScreen(),
    ),
    GoRoute(
      path: '/settings/backup',
      builder: (context, state) => const BackupRestoreScreen(),
    ),
  ],
);

class ScanBiApp extends StatelessWidget {
  const ScanBiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'scan-bi',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      locale: const Locale('th'),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('th'),
      ],
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}
