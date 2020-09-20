import 'package:example/redux/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux_toolkit/flutter_redux_toolkit.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ReduxToolkit.initialize();

  final store = await createStore();
  runApp(MyApp(store));
}