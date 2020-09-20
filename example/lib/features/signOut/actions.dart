import 'dart:async';

import 'package:example/features/signOut/state.dart';
import 'package:example/redux/app_state.dart';
import 'package:flutter_redux_toolkit/flutter_redux_toolkit.dart';

class SignOutActions {
  SignOutActions();

  factory SignOutActions.initialize() {

    return new SignOutActions();
  }
}

class DoLogout extends ThunkAction<AppState, SignOutState> {
  DoLogout();

  @override
  FutureOr<dynamic> execute() async {
    return null;
  }
}
