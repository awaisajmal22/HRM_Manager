import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;
    String newText = '';

    if (text.length > 0) {
      newText += '(';
      newText += text.substring(0, text.length >= 3 ? 3 : text.length);
    }

    if (text.length >= 4) {
      newText += ') ';
      newText += text.substring(3, text.length >= 6 ? 6 : text.length);
    }

    if (text.length >= 7) {
      newText += '-';
      newText += text.substring(6, text.length >= 10 ? 10 : text.length);
    }

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}