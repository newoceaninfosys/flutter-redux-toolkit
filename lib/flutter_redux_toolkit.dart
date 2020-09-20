library flutter_redux_toolkit;

export 'package:reselect/reselect.dart';
export 'package:flutter_hooks/flutter_hooks.dart'
    show
        useEffect,
        useState,
        useMemoized,
        useContext,
        useValueChanged,
        useStream,
        useStreamController,
        useFuture,
        useSingleTickerProvider,
        useAnimation,
        useAnimationController,
        useListenable,
        useValueListenable,
        useValueNotifier,
        usePrevious,
        useTextEditingController,
        useFocusNode,
        useTabController,
        useScrollController,
        useIsMounted,
        HookBuilder,
        HookWidget,
        HookState,
        HookElement,
        StatefulHookWidget;
export 'src/async_redux/async_redux.dart';
export 'src/redux_app_state.dart';
export 'src/persistor.dart';
export 'src/thunk_action.dart';
export 'src/thunk_action_observe.dart';
export 'src/thunk_action_events.dart';
export 'src/common.dart';
export 'src/redux_state.dart';
export 'src/set_state_action.dart';

import 'src/event_emitter.dart';

/// A Calculator.
class ReduxToolkit {
  static initialize() async {
    EventEmitter.initialize();
  }
}