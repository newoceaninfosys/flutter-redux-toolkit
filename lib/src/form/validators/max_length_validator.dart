import '../base_validator.dart';

class MaxLengthValidator extends BaseValidator {
  int max;
  MaxLengthValidator(message, this.max) : super('maxLength', message);

  @override
  bool execute(dynamic value) {
    return value != null && value.length > max;
  }
}
