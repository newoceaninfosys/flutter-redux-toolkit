import 'package:flutter/material.dart';
import 'package:flutter_redux_toolkit/src/form/form_provider.dart';

import 'base_async_validator.dart';
import 'base_validator.dart';

class FormController with ChangeNotifier {
  FormProvider provider;

  bool _submitting = false;
  // ignore: unnecessary_getters_setters
  set submitting(bool value) {
    _submitting = value;
    notifyChanges();
  }

  // ignore: unnecessary_getters_setters
  bool get submitting => _submitting;

  FormController({this.provider});

  Map<String, Map<String, String>> get errors {
    return provider.getErrors();
  }

  Map<String, dynamic> get values {
    return provider.getValues();
  }

  String get id {
    return provider.id;
  }

  void notifyChanges() {
    notifyListeners();
  }

  dynamic getValue(String fieldName) {
    return provider.getValue(fieldName);
  }

  void setValue(String fieldName, dynamic value,
      {bool triggerValidation = true}) {
    provider.setValue(fieldName, value, triggerValidation: triggerValidation);
  }

  Map<String, String> getFieldErrors(String fieldName) {
    return errors != null
        ? errors[fieldName] != null ? errors[fieldName] : {}
        : {};
  }

  String getFirstFieldError(String fieldName) {
    var error = getFieldErrors(fieldName);
    return error.isNotEmpty ? error.entries.first.value : null;
  }

  void setValidators(String fieldName, List<BaseValidator> validators) {
    provider.setValidators(fieldName, validators);
  }

  void setAsyncValidators(
      String fieldName, List<BaseAsyncValidator> validators) {
    provider.setAsyncValidators(fieldName, validators);
  }

  void reset([Map<String, dynamic> values]) {
    provider.reset(values);
  }

  bool isValid([String fieldName]) {
    if (fieldName != null) {
      return errors == null ||
          errors.isEmpty ||
          errors[fieldName] == null ||
          errors[fieldName].isEmpty;
    }
    return errors == null || errors.isEmpty;
  }

  void triggerValidation() {
    provider.triggerValidation();
  }

  String buildErrorMessage(
      String fieldName, Map<String, String> errorMessages) {
    if (errors[fieldName] != null) {
      var error = errors[fieldName].entries.first;
      if (error != null) {
        var errorMessage = errorMessages[error.key];
        if (errorMessage != null) return errorMessage;
        return error.key;
      }
    }

    return 'N/A';
  }

  void submit(Function onSubmit) {
    submitting = true;
    triggerValidation();
    onSubmit(values, isValid(), errors);
  }

  void complete() {
    submitting = false;
  }
}
