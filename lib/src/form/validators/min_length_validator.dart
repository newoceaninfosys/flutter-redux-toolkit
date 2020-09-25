import 'package:flutter_redux_toolkit/src/form/base_validator.dart';

class MinLengthValidator extends BaseValidator {
  int min;
  MinLengthValidator(message, this.min) : super('minLength', message);

  @override
  bool execute(dynamic value) {
    return value != null && value.length < min;
  }
}
