
import 'event_emitter.dart';
import 'thunk_action_events.dart';

abstract class ObserveThunkAction<S, A> {
  ObserveThunkAction() {
    EventEmitter.eventBus.on<ThunkActionFulfilledEvent>().listen((event) {
      if (event.action == A.toString()) {
        onFulfilled(event.data, event.state, event.dispatch);
      }
    });

    EventEmitter.eventBus.on<ThunkActionFailedEvent>().listen((event) {
      if (event.action == A.toString()) {
        onFulfilled(event.data, event.state, event.dispatch);
      }
    });

    EventEmitter.eventBus.on<ThunkActionLoadingEvent>().listen((event) {
      if (event.action == A.toString()) {
        onLoading(event.state, event.dispatch);
      }
    });
  }

  void onFulfilled(dynamic data, S state, Function dispatch) {}

  void onFailed(dynamic data, S state, Function dispatch) {}

  void onLoading(S state, Function dispatch) {}
}