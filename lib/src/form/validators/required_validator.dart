import 'package:flutter_redux_toolkit/src/form/base_validator.dart';

class RequiredValidator extends BaseValidator {
  RequiredValidator(message) : super('required', message);

  @override
  bool execute(dynamic value) {
    return value == null || value == '';
  }
}
