
import 'package:example/features/signIn/actions.dart';
import 'package:example/features/signOut/actions.dart';
import 'package:example/redux/app_state.dart';
import 'package:example/redux/auth/state.dart';
import 'package:flutter_redux_toolkit/flutter_redux_toolkit.dart';

class DoLoginObserve extends ObserveThunkAction<AppState, DoLogin> {
  DoLoginObserve() : super();

  @override
  void onFulfilled(dynamic data, AppState state, Function dispatch) {
    dispatch(SetState<AppState, AuthState>((AuthState authState) => AuthState.fromMap(data)));
  }
}

class DoLogOutObserve extends ObserveThunkAction<AppState, DoLogout> {
  DoLogOutObserve() : super();

  @override
  void onFulfilled(dynamic data, AppState state, Function dispatch) {
    dispatch(SetState<AppState, AuthState>((AuthState authState) => AuthState.initial()));
  }
}