import 'async_redux/async_redux.dart';
import 'redux_state.dart';

class SetState<S1, S2> extends ReduxAction<S1> {
  Function(S2) func;

  SetState(this.func);

  @override
  S1 reduce() {
    var appState = state as ReduxState;
    MapEntry entry = appState.toMap().entries.firstWhere(
            (element) => element.value.runtimeType.toString() == S2.toString(),
        orElse: () => null);

    if (entry != null) {
      Symbol sym = new Symbol(entry.key);
      S2 newState = func(entry.value);
      return Function.apply(appState.copyWith, [], {sym: newState});
    }

    throw UserException("setState failed: State not found");
  }
}