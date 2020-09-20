import 'package:example/redux/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux_toolkit/flutter_redux_toolkit.dart';


class SignInState extends ReduxState<SignInState> {
  final THUNK_STATUS submitStatus;
  final String submitError;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  SignInState({
    @required this.submitStatus,
    @required this.submitError,
  });

  factory SignInState.initial({List<ObserveThunkAction> observers}) {
    return new SignInState(submitStatus: THUNK_STATUS.IDLE, submitError: null);
  }

  SignInState copyWith({
    THUNK_STATUS submitStatus,
    String submitError,
  }) {
    if ((submitStatus == null || identical(submitStatus, this.submitStatus)) &&
        (submitError == null || identical(submitError, this.submitError))) {
      return this;
    }

    return new SignInState(
      submitStatus: submitStatus ?? this.submitStatus,
      submitError: submitError ?? this.submitError,
    );
  }

  @override
  String toString() {
    return 'SignInState{submitStatus: $submitStatus, submitError: $submitError}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SignInState &&
          runtimeType == other.runtimeType &&
          submitStatus == other.submitStatus &&
          submitError == other.submitError);

  @override
  int get hashCode => submitStatus.hashCode ^ submitError.hashCode;

  factory SignInState.fromMap(Map<String, dynamic> map) {
    return new SignInState(
      submitStatus: map['submitStatus'] as THUNK_STATUS,
      submitError: map['submitError'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return new Map<String, dynamic>.from({
      'submitStatus': this.submitStatus,
      'submitError': this.submitError,
    });
  }

//</editor-fold>

}

// SELECTORS
class SignInSelectors {
  static final selectSignIn = (AppState state) => state.signIn;

  static final selectIsLoading = (AppState state) => createSelector1(
      selectSignIn,
      (SignInState state) =>
          state.submitStatus == THUNK_STATUS.LOADING)(state);
  static final selectIsSucceed = (AppState state) => createSelector1(
      selectSignIn,
      (SignInState state) =>
          state.submitStatus == THUNK_STATUS.SUCCEED)(state);
  static final selectIsFailed = (AppState state) => createSelector1(
      selectSignIn,
      (SignInState state) => state.submitStatus == THUNK_STATUS.FAILED)(state);
  static final selectError = (AppState state) => createSelector1(
      selectSignIn, (SignInState state) => state.submitError)(state);
}
