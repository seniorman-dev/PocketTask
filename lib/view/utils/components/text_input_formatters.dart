import 'package:flutter/services.dart';
import 'package:intl/intl.dart';








class NumericTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Remove all non-digit characters
    final cleanText = newValue.text.replaceAll(RegExp(r'[^\d]'), '');
    
    // Don't format empty string
    if (cleanText.isEmpty) return newValue.copyWith(text: '');

    // Parse to integer and format with commas
    final number = int.tryParse(cleanText) ?? 0;
    final formattedText = NumberFormat('#,###').format(number);

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}