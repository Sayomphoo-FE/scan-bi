import 'package:flutter/material.dart';

import '../../../data/services/receipt_scan_service.dart';

class ReceiptScanSheet extends StatefulWidget {
  final void Function(ParsedReceipt parsed) onParsed;

  const ReceiptScanSheet({super.key, required this.onParsed});

  @override
  State<ReceiptScanSheet> createState() => _ReceiptScanSheetState();
}

class _ReceiptScanSheetState extends State<ReceiptScanSheet> {
  final _service = ReceiptScanService();
  bool _isScanning = false;
  String? _errorMessage;
  String? _imagePath;

  Future<void> _scan(bool fromCamera) async {
    setState(() {
      _isScanning = true;
      _errorMessage = null;
    });

    try {
      final file = fromCamera
          ? await _service.pickImageFromCamera()
          : await _service.pickImageFromGallery();

      if (file == null) {
        setState(() => _isScanning = false);
        return;
      }

      setState(() => _imagePath = file.path);

      final parsed = await _service.scanReceipt(file.path);

      if (parsed == null || !parsed.hasAnyData) {
        setState(() {
          _errorMessage = 'Could not extract data from receipt.';
          _isScanning = false;
        });
        return;
      }

      if (mounted) {
        Navigator.pop(context);
        widget.onParsed(parsed);
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Scan failed: $e';
        _isScanning = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Scan Receipt', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            const Text(
              'Take a photo or select from gallery to auto-fill entry details.',
            ),
            const SizedBox(height: 24),
            if (_isScanning)
              const Center(
                child: Column(
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 12),
                    Text('Scanning receipt...'),
                  ],
                ),
              )
            else ...[
              FilledButton.icon(
                onPressed: () => _scan(true),
                icon: const Icon(Icons.camera_alt_outlined),
                label: const Text('Take Photo'),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: () => _scan(false),
                icon: const Icon(Icons.photo_library_outlined),
                label: const Text('Choose from Gallery'),
              ),
            ],
            if (_errorMessage != null) ...[
              const SizedBox(height: 16),
              Text(
                _errorMessage!,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
