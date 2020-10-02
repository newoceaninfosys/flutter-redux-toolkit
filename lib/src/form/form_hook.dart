import 'dart:async';

import 'package:flutter_hooks/flutter_hooks.dart';

import '../event_emitter.dart';
import 'form_controller.dart';
import 'form_hook_events.dart';
import 'form_provider.dart';

FormController useForm(
    {Map<String, dynamic> defaultValues, List<String> watch}) {
  final formId =
      useMemoized(() => DateTime.now().millisecondsSinceEpoch.toString());
  final provider = useMemoized(() =>
      FormProvider(formId, defaultValues: defaultValues, watchFields: watch));
  final formState = useState(FormController(provider: provider));
  final controller = useListenable(formState.value);

  useEffect(() {
    StreamSubscription valuesSub =
        EventEmitter.eventBus.on<FormValueChanged>().listen((event) {
      if (event.id == formId) {
        controller.notifyChanges();
      }
    });

    return () => valuesSub.cancel();
  }, []);

  useEffect(() {
    StreamSubscription errorsSub =
        EventEmitter.eventBus.on<FormErrorChanged>().listen((event) {
      if (event.id == formId) {
        controller.notifyChanges();
      }
    });

    return () => errorsSub.cancel();
  }, []);

  useEffect(() {
    StreamSubscription formResetSub =
        EventEmitter.eventBus.on<FormReset>().listen((event) {
      if (event.id == formId) {
        controller.notifyChanges();
      }
    });

    return () => formResetSub.cancel();
  }, []);

  return controller;
}
