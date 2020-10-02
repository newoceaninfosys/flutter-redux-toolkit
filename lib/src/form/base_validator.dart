abstract class BaseValidator {
  String message;
  String name;
  Map<String, dynamic> formValues;
  BaseValidator(this.name, this.message);

  bool execute(dynamic value);
}
