import 'package:flutter/foundation.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

/// Parsed receipt data extracted by ML Kit
class ParsedReceipt {
  final String? title;
  final double? amount;
  final String? currencyCode;
  final String? date; // ISO 8601 "YYYY-MM-DD"

  const ParsedReceipt({this.title, this.amount, this.currencyCode, this.date});

  bool get hasAnyData =>
      title != null || amount != null || currencyCode != null || date != null;
}

class ReceiptScanService {
  final _imagePicker = ImagePicker();

  Future<XFile?> pickImageFromCamera() async {
    try {
      return await _imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
      );
    } catch (e) {
      debugPrint('Camera error: $e');
      return null;
    }
  }

  Future<XFile?> pickImageFromGallery() async {
    try {
      return await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );
    } catch (e) {
      debugPrint('Gallery error: $e');
      return null;
    }
  }

  Future<ParsedReceipt?> scanReceipt(String imagePath) async {
    final inputImage = InputImage.fromFilePath(imagePath);
    final recognizer = TextRecognizer(script: TextRecognitionScript.latin);
    try {
      final recognizedText = await recognizer.processImage(inputImage);
      return _parseText(recognizedText.text);
    } catch (e) {
      debugPrint('OCR error: $e');
      return null;
    } finally {
      recognizer.close();
    }
  }

  ParsedReceipt _parseText(String text) {
    final lines = text
        .split('\n')
        .map((l) => l.trim())
        .where((l) => l.isNotEmpty)
        .toList();

    String? title;
    double? amount;
    String? currencyCode;
    String? date;

    // Extract merchant name (first significant text block)
    if (lines.isNotEmpty) {
      title = lines.first;
    }

    // Extract amount — look for "Total", "ยอดรวม", "รวม" followed by number
    final amountPatterns = [
      RegExp(
        r'(?:total|ยอดรวม|รวมทั้งสิ้น|รวม|ยอดชำระ|grand total)[^\d]*([0-9,]+(?:\.[0-9]{1,2})?)',
        caseSensitive: false,
      ),
      RegExp(r'([0-9,]+\.[0-9]{2})\s*$', multiLine: true),
    ];
    for (final pattern in amountPatterns) {
      final match = pattern.firstMatch(text);
      if (match != null) {
        final raw = match.group(1)?.replaceAll(',', '') ?? '';
        amount = double.tryParse(raw);
        if (amount != null) break;
      }
    }

    // Extract currency — look for symbols or codes
    final currencyPatterns = {
      '฿': 'THB',
      '\$': 'USD',
      '€': 'EUR',
      '£': 'GBP',
      '¥': 'JPY',
      'THB': 'THB',
      'USD': 'USD',
      'EUR': 'EUR',
      'GBP': 'GBP',
      'JPY': 'JPY',
      'SGD': 'SGD',
      'CNY': 'CNY',
    };
    for (final entry in currencyPatterns.entries) {
      if (text.contains(entry.key)) {
        currencyCode = entry.value;
        break;
      }
    }

    // Extract date — support DD/MM/YYYY, YYYY-MM-DD, DD-MM-YYYY
    final dateRegexes = [
      RegExp(r'(\d{4}[-/]\d{2}[-/]\d{2})'),
      RegExp(r'(\d{2}[-/]\d{2}[-/]\d{4})'),
    ];
    for (final regex in dateRegexes) {
      final match = regex.firstMatch(text);
      if (match != null) {
        final raw = match.group(1)!;
        // Normalize to YYYY-MM-DD
        if (raw.length == 10) {
          if (raw[4] == '-' || raw[4] == '/') {
            date = raw.replaceAll('/', '-');
          } else {
            // DD-MM-YYYY → YYYY-MM-DD
            final parts = raw.split(RegExp(r'[-/]'));
            date = '${parts[2]}-${parts[1]}-${parts[0]}';
          }
        }
        break;
      }
    }

    return ParsedReceipt(
      title: title,
      amount: amount,
      currencyCode: currencyCode,
      date: date,
    );
  }
}
