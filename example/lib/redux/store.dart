import 'package:example/redux/app_state.dart';
import 'package:flutter_toolkit/flutter_toolkit.dart';

Future<Store<AppState>> createStore() async {
  var persistor = await StatePersistor.initial<AppState>(AppState.initial());

  return Store<AppState>(
    initialState: persistor[1],
    persistor: persistor[0],
  );
}
