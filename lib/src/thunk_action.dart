import 'dart:async';

import 'async_redux/async_redux.dart';
import 'event_emitter.dart';
import 'set_state_action.dart';
import 'thunk_action_events.dart';

abstract class ThunkAction<S1, S2> extends ReduxAction<S1> {
  bool _hasError = false;
  dynamic _error;
  dynamic _response;

  @override
  Future<S1> reduce() async {
    dynamic response = await execute();
    _response = response;

    return state;
  }

  @override
  void before() {
    if (onLoading != null) {
      dispatch(SetState<S1, S2>(onLoading));

      EventEmitter.eventBus.fire(ThunkActionLoadingEvent<S1>(dispatch, state, this.runtimeType.toString()));
    }
  }

  @override
  void after() {
    if (!_hasError) {
      if (onFulfilled != null) {
        dispatch(SetState<S1, S2>((S2 state) => onFulfilled(state, _response)));
        EventEmitter.eventBus.fire(ThunkActionFulfilledEvent<S1>(dispatch, state, this.runtimeType.toString(), data: _response));
      }
    } else {
      if (onFailed != null) {
        dispatch(SetState<S1, S2>((S2 state) => onFailed(state, _response)));
        EventEmitter.eventBus.fire(ThunkActionFailedEvent<S1>(dispatch, state, this.runtimeType.toString(), data: _error));
      }
    }

    _hasError = false;
    _error = null;
    _response = null;
  }

  @override
  Object wrapError(error) {
    _hasError = true;
    _error = error;

    return error;
  }

  FutureOr<dynamic> execute() {}

  FutureOr<S2> onLoading(S2 state) => state;

  FutureOr<S2> onFulfilled(S2 state, dynamic response) => state;

  FutureOr<S2> onFailed(S2 state, dynamic error) => state;
}
