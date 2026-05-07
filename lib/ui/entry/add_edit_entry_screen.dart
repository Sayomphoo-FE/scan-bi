import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../data/models/entry.dart';
import '../../data/models/currency.dart';
import '../../providers/entry_providers.dart';
import '../../providers/currency_providers.dart';
import '../../core/constants.dart';
import 'widgets/icon_picker_widget.dart';
import 'widgets/currency_selector.dart';
import 'widgets/receipt_scan_sheet.dart';

class AddEditEntryScreen extends ConsumerStatefulWidget {
  final String? entryId; // null = add mode
  final String? groupId; // pre-assign to a group

  const AddEditEntryScreen({super.key, this.entryId, this.groupId});

  @override
  ConsumerState<AddEditEntryScreen> createState() =>
      _AddEditEntryScreenState();
}

class _AddEditEntryScreenState extends ConsumerState<AddEditEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleCtrl = TextEditingController();
  final _amountCtrl = TextEditingController();

  String _type = 'expense';
  String _iconType = 'emoji';
  String _iconValue = '💰';
  String _currencyCode = 'THB';
  DateTime _occurredAt = DateTime.now();
  bool _isLoading = false;
  bool _isLoadingEntry = true;
  EntryModel? _originalEntry;

  bool get _isEditMode => widget.entryId != null;

  @override
  void initState() {
    super.initState();
    if (_isEditMode) {
      _loadEntry();
    } else {
      _isLoadingEntry = false;
    }
  }

  Future<void> _loadEntry() async {
    final entry = await ref
        .read(entryRepositoryProvider)
        .getEntryById(widget.entryId!);
    if (entry != null && mounted) {
      setState(() {
        _originalEntry = entry;
        _type = entry.type;
        _titleCtrl.text = entry.title;
        _iconType = entry.iconType;
        _iconValue = entry.iconValue;
        _amountCtrl.text = entry.amount.toString();
        _currencyCode = entry.currencyCode;
        _occurredAt = DateTime.tryParse(entry.occurredAt) ?? DateTime.now();
        _isLoadingEntry = false;
      });
    } else {
      if (mounted) setState(() => _isLoadingEntry = false);
    }
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _amountCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    try {
      final amount = double.tryParse(_amountCtrl.text.trim()) ?? 0;
      final currencies = await ref
          .read(currencyRepositoryProvider)
          .getAllCurrencies();
      final currency = currencies.firstWhere(
        (c) => c.code == _currencyCode,
        orElse: () => const CurrencyModel(
          code: 'THB',
          name: 'Thai Baht',
          symbol: '฿',
          rateToBase: 1.0,
        ),
      );
      final amountBase = amount / currency.rateToBase;
      final dateStr = DateFormat('yyyy-MM-dd').format(_occurredAt);

      final entryRepo = ref.read(entryRepositoryProvider);

      if (_isEditMode && _originalEntry != null) {
        final updated = _originalEntry!.copyWith(
          type: _type,
          title: _titleCtrl.text.trim(),
          iconType: _iconType,
          iconValue: _iconValue,
          amount: amount,
          currencyCode: _currencyCode,
          amountBase: amountBase,
          occurredAt: dateStr,
          updatedAt: DateTime.now().toIso8601String(),
        );
        await entryRepo.updateEntry(updated);
      } else {
        await entryRepo.addEntry(
          type: _type,
          title: _titleCtrl.text.trim(),
          iconType: _iconType,
          iconValue: _iconValue,
          amount: amount,
          currencyCode: _currencyCode,
          amountBase: amountBase,
          occurredAt: dateStr,
          groupId: widget.groupId,
        );
      }

      if (mounted) context.pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _delete() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Entry'),
        content: const Text('Are you sure you want to delete this entry?'),
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
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      await ref.read(entryRepositoryProvider).deleteEntry(widget.entryId!);
      if (mounted) context.pop();
    }
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _occurredAt,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) setState(() => _occurredAt = picked);
  }

  void _openReceiptScan() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => ReceiptScanSheet(
        onParsed: (parsed) {
          if (parsed.title != null) _titleCtrl.text = parsed.title!;
          if (parsed.amount != null) {
            _amountCtrl.text = parsed.amount!.toString();
          }
          if (parsed.currencyCode != null) {
            setState(() => _currencyCode = parsed.currencyCode!);
          }
          if (parsed.date != null) {
            final d = DateTime.tryParse(parsed.date!);
            if (d != null) setState(() => _occurredAt = d);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (_isLoadingEntry) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditMode ? 'Edit Entry' : 'Add Entry'),
        actions: [
          IconButton(
            icon: const Icon(Icons.document_scanner_outlined),
            onPressed: _openReceiptScan,
            tooltip: 'Scan Receipt',
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Type toggle
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(
                  value: 'income',
                  label: Text('Income'),
                  icon: Icon(Icons.arrow_upward, color: Color(0xFF4CAF50)),
                ),
                ButtonSegment(
                  value: 'expense',
                  label: Text('Expense'),
                  icon: Icon(Icons.arrow_downward, color: Color(0xFFF44336)),
                ),
              ],
              selected: {_type},
              onSelectionChanged: (s) => setState(() => _type = s.first),
            ),
            const SizedBox(height: 16),

            // Title
            TextFormField(
              controller: _titleCtrl,
              decoration: const InputDecoration(
                labelText: 'Title',
                hintText: 'e.g. Lunch at restaurant',
              ),
              validator: (v) =>
                  v == null || v.trim().isEmpty ? 'Title is required' : null,
            ),
            const SizedBox(height: 12),

            // Icon picker
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
            const SizedBox(height: 12),

            // Amount
            TextFormField(
              controller: _amountCtrl,
              decoration: const InputDecoration(
                labelText: 'Amount',
                hintText: '0.00',
              ),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Amount is required';
                if (double.tryParse(v.trim()) == null) {
                  return 'Enter a valid number';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),

            // Currency selector
            CurrencySelector(
              selectedCode: _currencyCode,
              onChanged: (code) => setState(() => _currencyCode = code),
            ),
            const SizedBox(height: 12),

            // Date picker
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.calendar_today_outlined),
              title: Text(
                DateFormat('dd MMM yyyy').format(_occurredAt),
                style: theme.textTheme.bodyLarge,
              ),
              subtitle: const Text('Date'),
              onTap: _pickDate,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              tileColor: theme.colorScheme.surfaceContainerHighest
                  .withOpacity(0.5),
            ),
            const SizedBox(height: 24),

            // Save button
            FilledButton(
              onPressed: _isLoading ? null : _save,
              child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(_isEditMode ? 'Save Changes' : 'Add Entry'),
            ),

            // Delete button (edit mode only)
            if (_isEditMode) ...[
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: _isLoading ? null : _delete,
                style: OutlinedButton.styleFrom(
                  foregroundColor: theme.colorScheme.error,
                  side: BorderSide(color: theme.colorScheme.error),
                  minimumSize: const Size.fromHeight(48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Delete Entry'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
