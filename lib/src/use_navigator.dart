import 'package:flutter/material.dart';

class useNavigator {
  final BuildContext context;

  useNavigator(this.context);

  bool canPop() {
    return Navigator.of(context).canPop();
  }

  Future<bool> maybePop<T extends Object>([T result]) {
    return Navigator.of(context).maybePop<T>(result);
  }

  void pop<T extends Object>([T result]) {
    Future.delayed(Duration.zero, () {
      return Navigator.of(context).pop<T>(result);
    });
  }

  Future<T> popAndPushNamed<T extends Object, TO extends Object>(
      String routeName,
      {TO result,
      Object arguments}) {
    return Future.delayed(Duration.zero, () {
      return Navigator.of(context).popAndPushNamed<T, TO>(routeName,
          arguments: arguments, result: result);
    });
  }

  void popUntil(RoutePredicate predicate) {
    Future.delayed(Duration.zero, () {
      return Navigator.of(context).popUntil(predicate);
    });
  }

  Future<T> push<T extends Object>(Route<T> route) {
    return Future.delayed(Duration.zero, () {
      return Navigator.of(context).push<T>(route);
    });
  }

  Future<T> pushAndRemoveUntil<T extends Object>(
      Route<T> newRoute, RoutePredicate predicate) {
    return Future.delayed(Duration.zero, () {
      return Navigator.of(context).pushAndRemoveUntil<T>(newRoute, predicate);
    });
  }

  Future<T> pushNamed<T extends Object>(String routeName, {Object arguments}) {
    return Future.delayed(Duration.zero, () {
      return Navigator.of(context)
          .pushNamed<T>(routeName, arguments: arguments);
    });
  }

  Future<T> pushNamedAndRemoveUntil<T extends Object>(
      String newRouteName, RoutePredicate predicate,
      {Object arguments}) {
    return Future.delayed(Duration.zero, () {
      return Navigator.of(context).pushNamedAndRemoveUntil<T>(
          newRouteName, predicate,
          arguments: arguments);
    });
  }

  Future<T> pushReplacement<T extends Object, TO extends Object>(
      Route<T> newRoute,
      {TO result}) {
    return Future.delayed(Duration.zero, () {
      return Navigator.of(context)
          .pushReplacement<T, TO>(newRoute, result: result);
    });
  }

  Future<T> pushReplacementNamed<T extends Object, TO extends Object>(
      String routeName,
      {TO result,
      Object arguments}) {
    return Future.delayed(Duration.zero, () {
      return Navigator.of(context).pushReplacementNamed<T, TO>(routeName,
          result: result, arguments: arguments);
    });
  }

  void removeRoute(Route route) {
    Future.delayed(Duration.zero, () {
      Navigator.of(context).removeRoute(route);
    });
  }

  void removeRouteBelow(Route anchorRoute) {
    Future.delayed(Duration.zero, () {
      Navigator.of(context).removeRouteBelow(anchorRoute);
    });
  }

  void replace<T extends Object>({Route oldRoute, Route<T> newRoute}) {
    Future.delayed(Duration.zero, () {
      return Navigator.of(context)
          .replace(newRoute: newRoute, oldRoute: oldRoute);
    });
  }

  void replaceRouteBelow<T extends Object>(
      {Route anchorRoute, Route<T> newRoute}) {
    Future.delayed(Duration.zero, () {
      return Navigator.of(context)
          .replaceRouteBelow(newRoute: newRoute, anchorRoute: anchorRoute);
    });
  }
}
