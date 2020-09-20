import 'package:flutter/material.dart';

class useNavigator {
  final BuildContext context;

  useNavigator(this.context);

  Future<T> pushNamedAndRemoveUntil<T extends Object>(
      String newRouteName, RoutePredicate predicate,
      {Object arguments}) {
    return Future.delayed(Duration.zero, () {
      return Navigator.pushNamedAndRemoveUntil(context, newRouteName, predicate,
          arguments: arguments);
    });
  }

  Future<T> pushNamed<T extends Object>(
      String routeName, {
        Object arguments,
      }) {
    return Future.delayed(Duration.zero, () {
      return Navigator.of(context)
          .pushNamed<T>(routeName, arguments: arguments);
    });
  }
}
