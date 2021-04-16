// Credit to https://github.com/hnvn/flutter_pattern_formatter/blob/master/lib/numeric_formatter.dart

import 'dart:math';

import 'package:flutter/services.dart';

TextEditingValue textManipulation(
  TextEditingValue oldValue,
  TextEditingValue newValue, {
  TextInputFormatter? textInputFormatter,
  String formatPattern(String filteredString)?,
}) {
  final originalUserInput = newValue.text;

  /// remove all invalid characters
  newValue = textInputFormatter != null
      ? textInputFormatter.formatEditUpdate(oldValue, newValue)
      : newValue; // remove separators?

  /// current selection
  int selectionIndex = newValue.selection.end;

  /// format original string, this step would add some separator characters
  final newText =
      formatPattern != null ? formatPattern(newValue.text) : newValue.text;

  if (newText == newValue.text) {
    return newValue;
  }

  /// count number of inserted character in new string
  int insertCount = 0;

  /// count number of original input character in new string
  int inputCount = 0;

  bool _isUserInput(String s) {
    if (textInputFormatter == null) return originalUserInput.contains(s);
    return newValue.text.contains(s);
  }

  for (int i = 0; i < newText.length && inputCount < selectionIndex; i++) {
    final character = newText[i];
    if (_isUserInput(character)) {
      inputCount++;
    } else {
      insertCount++;
    }
  }

  /// adjust selection according to number of inserted characters staying before selection
  selectionIndex += insertCount;
  selectionIndex = min(selectionIndex, newText.length);

  /// if selection is right after an inserted character, it should be moved
  /// backward, this adjustment prevents an issue that user cannot delete
  /// characters when cursor stands right after inserted characters
  if (selectionIndex - 1 >= 0 &&
      selectionIndex - 1 < newText.length &&
      !_isUserInput(newText[selectionIndex - 1])) {
    selectionIndex--;
  }
  // print('inputCount: $inputCount');
  // print('insertCount: $insertCount');

  return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: selectionIndex),
      composing: TextRange.empty);
}

TextEditingValue textManipulationV2(
  TextEditingValue oldValue,
  TextEditingValue newValue, {
  TextInputFormatter? textInputFormatter,
  String formatPattern(String filteredString)?,
}) {
  /// remove all invalid characters
  newValue = textInputFormatter != null
      ? textInputFormatter.formatEditUpdate(oldValue, newValue)
      : newValue;

  /// format original string, this step would add some separator characters
  final newText =
      formatPattern != null ? formatPattern(newValue.text) : newValue.text;

  if (newText == newValue.text) {
    return newValue;
  }

  return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
      composing: TextRange.empty);
}
