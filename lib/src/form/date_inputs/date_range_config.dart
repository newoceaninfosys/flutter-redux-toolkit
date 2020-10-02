import 'dart:core';

import 'package:flutter/material.dart';

class DateRangeConfig {
  DateRangeConfig(
      {firstDate,
      lastDate,
      this.currentDate,
      this.initialEntryMode = DatePickerEntryMode.calendar,
      this.helpText,
      this.cancelText,
      this.confirmText,
      this.textDirection,
      this.initialDatePickerMode = DatePickerMode.day,
      this.errorFormatText,
      this.errorInvalidText,
      this.fieldHintText,
      this.fieldLabelText})
      : firstDate = firstDate ?? new DateTime(1970, 1),
        lastDate = lastDate ?? new DateTime(2101);

  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime currentDate;
  final DatePickerEntryMode initialEntryMode;
  final String helpText;
  final String cancelText;
  final String confirmText;
  final TextDirection textDirection;
  final DatePickerMode initialDatePickerMode;
  final String errorFormatText;
  final String errorInvalidText;
  final String fieldHintText;
  final String fieldLabelText;
}
