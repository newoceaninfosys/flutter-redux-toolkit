import 'dart:developer';

import 'package:async/async.dart';

import '../event_emitter.dart';
import 'base_async_validator.dart';
import 'base_validator.dart';
import 'form_hook_events.dart';

class FormProvider {
  final String id;
  Map<String, dynamic> values = {};
  Map<String, Map<String, String>> errors = {};
  Map<String, List<BaseValidator>> validators = {};
  Map<String, List<BaseAsyncValidator>> asyncValidators = {};
  Map<String, CancelableOperation<dynamic>> asyncs = {};

  List<String> watchFields = [];

  FormProvider(this.id, {defaultValues, this.watchFields})
      : values = defaultValues {
    log('FormProvider const');
  }

  void setValues(Map<String, dynamic> data) {
    values = data;
  }

  dynamic getValue(String fieldName) {
    return values[fieldName];
  }

  Map<String, dynamic> getValues() {
    return values;
  }

  Map<String, dynamic> setValue(String fieldName, dynamic value,
      {bool triggerValidation = true}) {
    values[fieldName] = value;

    // Watched fields handler
    String watchField = watchFields
        .firstWhere((element) => element == fieldName, orElse: () => null);
    if (watchField != null) {
      EventEmitter.eventBus.fire(FormValueChanged(id, values));
    }

    // Validation handler
    if (triggerValidation) {
      var oldErrors = new Map.from(errors); // clone current error
      var newErrors = executeValidation(fieldName);
      if (newErrors.toString() != oldErrors.toString()) {
        // compare new vs current
        EventEmitter.eventBus.fire(FormErrorChanged(id, errors));
      }
    }

    return values;
  }

  Map<String, Map<String, String>> getErrors() {
    return errors;
  }

  void reset(Map<String, dynamic> initialValues) {
    errors = {};
    if (initialValues != null) {
      values = initialValues;
    }

    EventEmitter.eventBus.fire(FormReset(id));
  }

  void setValidators(String fieldName, List<BaseValidator> validations) {
    validators[fieldName] = validations;
  }

  void setAsyncValidators(
      String fieldName, List<BaseAsyncValidator> validations) {
    asyncValidators[fieldName] = validations;
  }

  Map<String, Map<String, String>> executeValidation(String fieldName) {
    List<BaseValidator> fieldValidators = validators[fieldName];
    if (fieldValidators != null && fieldValidators.length > 0) {
      fieldValidators.forEach((validator) {
        validator.formValues = getValues();
        bool isTrue = validator.execute(getValue(fieldName));
        if (isTrue) {
          // isTrue: mean the validator is correct
          var newError = new Map<String, String>();
          newError[validator.name] = validator.message;
          errors[fieldName] = new Map<String, String>.from(
              {...(errors[fieldName] ?? {}), ...newError});
        } else {
          if (errors[fieldName] != null) {
            errors[fieldName].remove(validator.name);
          }
        }

        // Async
        // asyncs[fieldName] = CancelableOperation.fromFuture(
        //     element.value(getValue(fieldName)), onCancel: () {
        //   asyncs[fieldName] = null;
        // });
        //
        // asyncs[fieldName].value.then((value) {
        //   if (value != null) {
        //     errors.remove(fieldName);
        //   } else {
        //     errors[fieldName] = value;
        //   }
        // });
        // asyncs[fieldName].value.whenComplete(() {
        //   log('onDone');
        //   asyncs[fieldName] = null;
        // });
      });
    }

    if (errors[fieldName] != null) {
      // Remove null(s)
      errors[fieldName].removeWhere((key, value) => value == null);

      // Keeps ordering
      var newErrors = new Map<String, String>.from({});
      fieldValidators.forEach((validator) {
        if (errors[fieldName][validator.name] != null) {
          newErrors[validator.name] = errors[fieldName][validator.name];
        }
      });
      errors[fieldName] = newErrors;
    }

    return errors;
  }

  void setErrors(String fieldName, Map<String, String> fieldErrors) {
    errors[fieldName] = fieldErrors;
  }

  void triggerValidation() {
    values.entries.forEach((element) {
      executeValidation(element.key);
    });

    EventEmitter.eventBus.fire(FormErrorChanged(id, errors));
  }
}
