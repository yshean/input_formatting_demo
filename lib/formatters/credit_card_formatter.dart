import 'dart:math';

import 'package:flutter/services.dart';

import 'utils.dart';

class CreditCardFormatter extends TextInputFormatter {
  final String separator;

  CreditCardFormatter({this.separator = ' '});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return textManipulation(
      oldValue,
      newValue,
      textInputFormatter: FilteringTextInputFormatter.digitsOnly,
      formatPattern: (String filteredString) {
        int offset = 0;
        StringBuffer buffer = StringBuffer();
        for (int i = min(4, filteredString.length);
            i <= filteredString.length;
            i += min(4, max(1, filteredString.length - i))) {
          buffer.write(filteredString.substring(offset, i));
          if (i < filteredString.length) {
            buffer.write(separator);
          }
          offset = i;
        }
        return buffer.toString();
      },
    );
  }
}

// or directly put TextInputFormatter.withFunction(formatFunction) into inputFormatters list
