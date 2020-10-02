import 'package:flutter/material.dart';

class TimeConfig {
  final TimePickerEntryMode initialEntryMode;
  final String helpText;
  final String cancelText;
  final String confirmText;
  final TextDirection textDirection;
  final DatePickerMode initialDatePickerMode;
  final String errorFormatText;
  final String errorInvalidText;
  final String fieldHintText;
  final String fieldLabelText;

  TimeConfig({
    this.initialEntryMode = TimePickerEntryMode.dial,
    this.helpText,
    this.cancelText,
    this.confirmText,
    this.textDirection,
    this.initialDatePickerMode = DatePickerMode.day,
    this.errorFormatText,
    this.errorInvalidText,
    this.fieldHintText,
    this.fieldLabelText,
  });
}
