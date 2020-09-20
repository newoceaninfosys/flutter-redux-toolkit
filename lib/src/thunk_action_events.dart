abstract class BaseEvent<S> {
  final Function dispatch;
  final S state;
  final String action;

  BaseEvent(this.dispatch, this.state, this.action);
}

class ThunkActionLoadingEvent<S> extends BaseEvent<S> {
  ThunkActionLoadingEvent(dispatch, state, action): super(dispatch, state, action);
}

class ThunkActionFailedEvent<S> extends BaseEvent<S> {
  final dynamic data;
  ThunkActionFailedEvent(dispatch, state, action, {this.data}): super(dispatch, state, action);
}

class ThunkActionFulfilledEvent<S> extends BaseEvent<S> {
  final dynamic data;
  ThunkActionFulfilledEvent(dispatch, state, action, {this.data}): super(dispatch, state, action);
}