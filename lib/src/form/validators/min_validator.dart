import 'package:flutter_redux_toolkit/src/form/base_validator.dart';

class MinValidator extends BaseValidator {
  int min;
  MinValidator(message, this.min) : super('min', message);

  @override
  bool execute(dynamic value) {
    return value < min;
  }
}
