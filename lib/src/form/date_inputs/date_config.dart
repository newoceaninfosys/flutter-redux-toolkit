import 'package:flutter/material.dart';

class DateConfig {
  final String helpText;
  final String cancelText;
  final String confirmText;
  final TextDirection textDirection;
  final DatePickerMode initialDatePickerMode;
  final String errorFormatText;
  final String errorInvalidText;
  final String fieldHintText;
  final String fieldLabelText;
  final DateTime minDate;
  final DateTime maxDate;
  final DateTime firstDate;
  final DateTime lastDate;

  DateConfig(
      {this.helpText,
      this.cancelText,
      this.confirmText,
      this.textDirection,
      this.initialDatePickerMode = DatePickerMode.day,
      this.errorFormatText,
      this.errorInvalidText,
      this.fieldHintText,
      this.fieldLabelText,
      this.minDate,
      this.maxDate,
      firstDate,
      lastDate})
      : firstDate = firstDate ?? new DateTime(1970, 1),
        lastDate = lastDate ?? new DateTime(2101);
}
