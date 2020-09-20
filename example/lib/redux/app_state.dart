import 'package:example/features/signIn/actions.dart';
import 'package:example/features/signIn/state.dart';
import 'package:example/features/signOut/state.dart';
import 'package:example/redux/auth/actions.dart';
import 'package:example/redux/auth/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux_toolkit/flutter_redux_toolkit.dart';

class AppState extends ReduxAppState<AppState> {
  final SignInState signIn;
  final SignOutState signOut;
  final AuthState auth;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  AppState({
    @required this.signIn,
    @required this.signOut,
    @required this.auth,
  });

  factory AppState.initial() {
    return AppState(
        signIn: SignInState.initial(),
        signOut: SignOutState.initial(),
        auth: AuthState.initial(
            observers: [DoLoginObserve(), DoLogOutObserve()]));
  }

  AppState copyWith({
    SignInState signIn,
    SignOutState signOut,
    AuthState auth,
  }) {
    if ((signIn == null || identical(signIn, this.signIn)) &&
        (signOut == null || identical(signOut, this.signOut)) &&
        (auth == null || identical(auth, this.auth))) {
      return this;
    }

    return new AppState(
      signIn: signIn ?? this.signIn,
      signOut: signOut ?? this.signOut,
      auth: auth ?? this.auth,
    );
  }

  @override
  String toString() {
    return 'AppState{signIn: $signIn, signOut: $signOut, auth: $auth}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppState &&
          runtimeType == other.runtimeType &&
          signIn == other.signIn &&
          signOut == other.signOut &&
          auth == other.auth);

  @override
  int get hashCode => signIn.hashCode ^ signOut.hashCode ^ auth.hashCode;

  factory AppState.fromMap(Map<String, dynamic> map) {
    return new AppState(
      signIn: map['signIn'] as SignInState,
      signOut: map['signOut'] as SignOutState,
      auth: map['auth'] as AuthState,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'signIn': this.signIn,
      'signOut': this.signOut,
      'auth': this.auth,
    } as Map<String, dynamic>;
  }

//</editor-fold>

}
