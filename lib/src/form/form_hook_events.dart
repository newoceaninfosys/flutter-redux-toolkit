abstract class FormBaseEvent {
  final String id;

  FormBaseEvent(this.id);
}

class FormValueChanged extends FormBaseEvent {
  final Map<String, dynamic> values;

  FormValueChanged(id, this.values) : super(id);
}

class FormErrorChanged extends FormBaseEvent {
  final Map<String, Map<String, String>> errors;

  FormErrorChanged(id, this.errors) : super(id);
}

class FormReset extends FormBaseEvent {
  FormReset(id) : super(id);
}
