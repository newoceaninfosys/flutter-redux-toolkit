import 'async_redux/async_redux.dart';
import 'redux_state.dart';

abstract class ReduxAppState<T> extends ReduxState<T> {
  T setState<T>(Function(T) func) {
    String state_name = T.toString();
    MapEntry entry = this.toMap().entries.firstWhere(
            (element) => element.value.runtimeType.toString() == state_name,
        orElse: () => null);

    if (entry != null) {
      Symbol sym = new Symbol(entry.key);
      T newState = func(entry.value);
      return Function.apply(copyWith, [], {sym: newState});
    }

    throw UserException("setState failed: State '$state_name' not found");
  }

  T replaceWith(Map<String, dynamic> newState) {
    var new_map = new Map<Symbol, dynamic>();
    newState.entries.forEach((e1) {
      var state = this.toMap().entries.firstWhere((e2) => e2.key == e1.key, orElse: () => null);

      if(state != null) {
        var updated_state = new Map<Symbol, dynamic>.from({});
        var state_value = new Map<String, dynamic>.from(e1.value);
        if(state_value.length > 0) {
          state_value.entries.forEach((element) {
            updated_state[new Symbol(element.key.toString())] = element.value;
          });
        }
        new_map[new Symbol(state.key.toString())] = Function.apply((state.value as dynamic).copyWith, [], updated_state);
      }
    });

    return Function.apply(copyWith, [], new_map);
  }
}