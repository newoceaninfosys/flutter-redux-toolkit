import 'package:flutter_toolkit/flutter_toolkit.dart';

class SignOutState extends ReduxState<SignOutState> {
//<editor-fold desc="Data Methods" defaultstate="collapsed">
  SignOutState();

  factory SignOutState.initial({List<ObserveThunkAction> observers}) {
    return new SignOutState();
  }

  SignOutState copyWith() {
    if (true) {
      return this;
    }

    return new SignOutState();
  }

  @override
  String toString() {
    return 'SignOutState{}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SignOutState && runtimeType == other.runtimeType);

  @override
  int get hashCode => 0;

  factory SignOutState.fromMap(Map<String, dynamic> map) {
    return new SignOutState();
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return new Map<String, dynamic>.from({});
  }

//</editor-fold>

}
