import '../base_validator.dart';

class MaxValidator extends BaseValidator {
  int max;
  MaxValidator(message, this.max) : super('max', message);

  @override
  bool execute(dynamic value) {
    return value > max;
  }
}
