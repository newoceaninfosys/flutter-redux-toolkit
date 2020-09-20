import 'package:localstorage/localstorage.dart';

import 'async_redux/async_redux.dart';

class StatePersistor<S> extends Persistor<S> {
  LocalStorage _storage;

  LocalStorage get storage {
    _storage = _storage ?? new LocalStorage('persistor');
    return _storage;
  }

  S appState;
  S initialState;

  StatePersistor(this.initialState);

  /// Public factory (Trick to use async)
  static Future<List> initial<S1>(S1 initialState) async {
    var persistor = new StatePersistor<S1>(initialState);
    var state = await persistor.readState();
    if (state == null) {
      state = initialState;
    }

    return [persistor, state];
  }

  @override
  Future<void> deleteState() async {
    await storage.ready;
    await storage.clear();
  }

  @override
  Future<void> persistDifference({lastPersistedState, newState}) async {
    List<String> keys = [];
    var appState = newState as dynamic;
    appState.toMap().entries.forEach((element) {
      Map<String, dynamic> save_state = new Map();
      if(element.value != null) {
        Map<String, dynamic> state = element.value.toMap();

        // Whitelist handler
        if(element.value.whitelist != null) {
          (element.value.whitelist as List<String>).forEach((element) {
            if(state.containsKey(element) != null) {
              save_state[element] = state[element];
            }
          });
        }
      }

      String key = element.key.toString();

      storage.setItem(key, save_state);

      keys.add(key);
    });

    storage.setItem("__keys", keys);
  }

  @override
  Future<S> readState() async {
    await storage.ready;
    Map<String, dynamic> state = new Map();
    List<dynamic> persist_keys = storage.getItem("__keys") ?? [];
    persist_keys.forEach((element) {
      Map<String, dynamic> data = storage.getItem(element);
      if(data != null) {
        state[element] = data;
      } else {
        state[element] = new Map<String, dynamic>();
      }
    });
    if(state.length > 0) {
      return (initialState as dynamic).replaceWith(state);
    }
    return null;
  }

}