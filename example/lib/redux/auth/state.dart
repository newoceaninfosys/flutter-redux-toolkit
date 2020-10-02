import 'package:example/redux/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toolkit/flutter_toolkit.dart';

class AuthState extends ReduxState<AuthState> {
  final String token;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  AuthState({
    @required this.token,
  }) : super() {
    this.whitelist = [
      'token',
    ];
  }

  factory AuthState.initial({List<ObserveThunkAction> observers}) {
    return new AuthState(token: null);
  }

  AuthState copyWith({
    String token,
  }) {
    if ((token == null || identical(token, this.token))) {
      return this;
    }

    return new AuthState(
      token: token ?? this.token,
    );
  }

  @override
  String toString() {
    return 'AuthState{token: $token}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AuthState &&
          runtimeType == other.runtimeType &&
          token == other.token);

  @override
  int get hashCode => token.hashCode;

  factory AuthState.fromMap(Map<String, dynamic> map) {
    return new AuthState(
      token: map['token'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'token': this.token,
    } as Map<String, dynamic>;
  }

//</editor-fold>

}

// SELECTORS
class AuthSelectors {
  static final selectAuth = (AppState state) => state.auth;

  static final selectToken = (AppState state) =>
      createSelector1(selectAuth, (AuthState state) => state.token)(state);
}
