import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants.dart';
import '../../data/repositories/backup_repository.dart';
import '../../providers/auth_provider.dart';
import '../../providers/database_provider.dart';

class BackupRestoreScreen extends ConsumerStatefulWidget {
  const BackupRestoreScreen({super.key});

  @override
  ConsumerState<BackupRestoreScreen> createState() =>
      _BackupRestoreScreenState();
}

class _BackupRestoreScreenState extends ConsumerState<BackupRestoreScreen> {
  bool _isWorking = false;
  DateTime? _lastBackup;

  @override
  void initState() {
    super.initState();
    _loadLastBackup();
  }

  Future<void> _loadLastBackup() async {
    final prefs = await SharedPreferences.getInstance();
    final ts = prefs.getString(AppConstants.prefLastBackup);
    if (ts != null && mounted) {
      setState(() => _lastBackup = DateTime.tryParse(ts));
    }
  }

  Future<BackupRepository> _getRepo() async {
    final db = ref.read(databaseProvider);
    return BackupRepository(db);
  }

  Future<void> _backup() async {
    setState(() => _isWorking = true);
    try {
      final repo = await _getRepo();
      await repo.backupToFirestore();
      final now = DateTime.now();
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(AppConstants.prefLastBackup, now.toIso8601String());
      if (mounted) {
        setState(() {
          _lastBackup = now;
          _isWorking = false;
        });
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Backup successful!')));
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isWorking = false);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Backup failed: $e')));
      }
    }
  }

  Future<void> _restore() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Restore from Backup'),
        content: const Text(
          'This will overwrite local data with data from Firestore. Continue?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Restore'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    setState(() => _isWorking = true);
    try {
      final repo = await _getRepo();
      await repo.restoreFromFirestore();
      if (mounted) {
        setState(() => _isWorking = false);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Restore successful!')));
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isWorking = false);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Restore failed: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);
    final user = authState.valueOrNull;

    return Scaffold(
      appBar: AppBar(title: const Text('Backup & Restore')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Account info
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: user?.photoURL != null
                        ? NetworkImage(user!.photoURL!)
                        : null,
                    child: user?.photoURL == null
                        ? const Icon(Icons.person)
                        : null,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: user == null
                        ? const Text(
                            'Not signed in. Sign in from Settings to enable backup.',
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(user.displayName ?? 'Google Account'),
                              Text(
                                user.email ?? '',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Last backup time
          if (_lastBackup != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                'Last backup: ${_lastBackup!.toLocal()}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
            ),

          // Backup button
          FilledButton.icon(
            onPressed: _isWorking || user == null ? null : _backup,
            icon: _isWorking
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Icon(Icons.backup_outlined),
            label: const Text('Backup to Firestore'),
          ),
          const SizedBox(height: 12),

          // Restore button
          OutlinedButton.icon(
            onPressed: _isWorking || user == null ? null : _restore,
            icon: const Icon(Icons.restore_outlined),
            label: const Text('Restore from Firestore'),
          ),

          const SizedBox(height: 24),
          if (user == null)
            const Text(
              '⚠️ Sign in with Google in Settings to enable backup.',
              style: TextStyle(color: Colors.orange),
            ),
        ],
      ),
    );
  }
}
