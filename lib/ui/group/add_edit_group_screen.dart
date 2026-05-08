import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../l10n/app_localizations.dart';
import '../../providers/group_providers.dart';
import '../entry/widgets/icon_picker_widget.dart';

class AddEditGroupScreen extends ConsumerStatefulWidget {
  final String? groupId; // null = add mode

  const AddEditGroupScreen({super.key, this.groupId});

  @override
  ConsumerState<AddEditGroupScreen> createState() => _AddEditGroupScreenState();
}

class _AddEditGroupScreenState extends ConsumerState<AddEditGroupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  String _iconType = 'emoji';
  String _iconValue = '🗂️';
  DateTime _groupDate = DateTime.now();
  bool _isLoading = false;
  bool _isLoadingGroup = true;

  bool get _isEditMode => widget.groupId != null;

  @override
  void initState() {
    super.initState();
    if (_isEditMode) {
      _loadGroup();
    } else {
      _isLoadingGroup = false;
    }
  }

  Future<void> _loadGroup() async {
    final group =
        await ref.read(groupRepositoryProvider).getGroupById(widget.groupId!);
    if (group != null && mounted) {
      setState(() {
        _nameCtrl.text = group.name;
        _iconType = group.iconType;
        _iconValue = group.iconValue;
        _groupDate = DateTime.tryParse(group.createdAt) ?? DateTime.now();
        _isLoadingGroup = false;
      });
    } else {
      if (mounted) setState(() => _isLoadingGroup = false);
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    try {
      final groupRepo = ref.read(groupRepositoryProvider);

      if (_isEditMode) {
        final existing = await groupRepo.getGroupById(widget.groupId!);
        if (existing != null) {
          final updatedGroup = existing.copyWith(
            name: _nameCtrl.text.trim(),
            iconType: _iconType,
            iconValue: _iconValue,
            createdAt: _groupDate.toIso8601String(),
          );
          await groupRepo.updateGroup(updatedGroup);
          // Sync all entries' dates to match the group's new date
          await groupRepo.updateGroupDateAndSyncEntries(
            widget.groupId!,
            _groupDate,
          );
        }
      } else {
        final newId = await groupRepo.createGroup(
          name: _nameCtrl.text.trim(),
          iconType: _iconType,
          iconValue: _iconValue,
          createdAt: _groupDate,
        );
        if (mounted) {
          context.go('/group/$newId');
          return;
        }
      }

      if (mounted) context.pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoadingGroup) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isEditMode
              ? AppLocalizations.of(context)!.editGroup
              : AppLocalizations.of(context)!.addGroup,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nameCtrl,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.groupName,
                hintText: AppLocalizations.of(context)!.groupNameHint,
              ),
              validator: (v) => v == null || v.trim().isEmpty
                  ? AppLocalizations.of(context)!.groupNameRequired
                  : null,
            ),
            const SizedBox(height: 12),
            ListTile(
              contentPadding: const EdgeInsets.only(left: 0),
              leading: const Icon(Icons.calendar_today_outlined),
              title: Text(
                DateFormat('dd MMM yyyy').format(_groupDate),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              subtitle: Text(AppLocalizations.of(context)!.date),
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: _groupDate,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (picked != null) {
                  setState(() => _groupDate = picked);
                }
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              tileColor: Theme.of(
                context,
              ).colorScheme.surfaceContainerHighest.withOpacity(0.5),
            ),
            const SizedBox(height: 12),
            IconPickerWidget(
              iconType: _iconType,
              iconValue: _iconValue,
              onChanged: (type, value) {
                setState(() {
                  _iconType = type;
                  _iconValue = value;
                });
              },
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _isLoading ? null : _save,
              child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(AppLocalizations.of(context)!.saveChanges),
            ),
          ],
        ),
      ),
    );
  }
}
