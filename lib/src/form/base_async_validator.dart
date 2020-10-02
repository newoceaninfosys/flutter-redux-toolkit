abstract class BaseAsyncValidator {
  String message;
  String name;
  Map<String, dynamic> formValues;
  BaseAsyncValidator(this.name, this.message);

  Future<bool> execute(dynamic value);
}
