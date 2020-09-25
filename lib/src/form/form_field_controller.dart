import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../event_emitter.dart';
import 'base_async_validator.dart';
import 'base_validator.dart';
import 'form_controller.dart';
import 'form_hook_events.dart';

//
// T useListenableState<T extends ChangeNotifier>(T data) {
//   final state = useState<T>(data);
//   return useListenable(state.value);
// }
//
// class DataClass with ChangeNotifier {
//   dynamic _value;
//
//   dynamic get cnt => _value;
//
//   set value(int val) {
//     _value = val;
//     notifyListeners();
//   }
//
//   DataClass(dynamic value) : _value = value;
// }

class FormFieldController extends HookWidget {
  final String name;
  final FormController controller;
  final Function child;
  final List<BaseValidator> validators;
  final List<BaseAsyncValidator> asyncValidators;

  FormFieldController(
      {@required this.controller,
      @required this.name,
      @required this.child,
      this.validators,
      this.asyncValidators}) {
    controller.setValidators(name, validators);
    controller.setAsyncValidators(name, asyncValidators);
  }

  @override
  Widget build(BuildContext context) {
    final defaultValue = useState(controller.getValue(name));
    final data = useState(defaultValue.value);
    final textController = TextEditingController();

    useValueChanged(data.value, (_, __) {
      controller.setValue(name, data.value);
      textController.text = data.value;
    });

    // ignore: missing_return
    useEffect(() {
      controller.setValue(name, defaultValue.value, triggerValidation: false);

      StreamSubscription formResetSub =
          EventEmitter.eventBus.on<FormReset>().listen((event) {
        if (event.id == controller.id) {
          data.value = controller.getValue(name);
        }
      });

      return () => formResetSub.cancel();
    }, []);

    var widget = this.child((value) {
      data.value = value;
    }, textController);

    return Focus(
      child: widget,
      onFocusChange: (hasFocus) {
        log(name + ' focus ' + hasFocus.toString());
      },
    );
  }
}
