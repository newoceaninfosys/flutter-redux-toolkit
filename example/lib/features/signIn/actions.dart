import 'dart:async';

import 'package:example/features/signIn/state.dart';
import 'package:example/redux/app_state.dart';
import 'package:flutter_redux_toolkit/flutter_redux_toolkit.dart';

class SignActions {
  SignActions();
}

class DoLogin extends ThunkAction<AppState, SignInState> {
  final String email;
  final String password;

  DoLogin({this.email, this.password});

  @override
  FutureOr<dynamic> execute() async {
    // this.email, this.password
    new Future.delayed(const Duration(seconds: 5), () => "1");
    Map<String, dynamic> result = new Map();
    result['token'] = '123';
    return result;
  }

  @override
  FutureOr<SignInState> onFailed(SignInState state, dynamic error) {
    return state.copyWith(submitStatus: THUNK_STATUS.FAILED, submitError: error.msg);
  }

  @override
  FutureOr<SignInState> onFulfilled(SignInState state, dynamic response) {
    return state.copyWith(submitStatus: THUNK_STATUS.SUCCEED);
  }

  @override
  FutureOr<SignInState> onLoading(SignInState state) {
    return state.copyWith(submitStatus: THUNK_STATUS.LOADING, submitError: null);
  }
}

class Reset extends ReduxAction<AppState> {
  Reset();

  @override
  AppState reduce() {
    return state.copyWith(signIn: SignInState.initial());
  }
}
