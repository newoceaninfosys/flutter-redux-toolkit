import 'dart:async';

import '../async_redux.dart';

class ProcessPersistence<St> {
  //
  ProcessPersistence(this.persistor)
      : isPersisting = false,
        newStateAvailable = false,
        lastPersistTime = DateTime.now().toUtc();

  Persistor persistor;
  St lastPersistedState;
  St newestState;
  bool isPersisting;
  bool newStateAvailable;
  DateTime lastPersistTime;
  Timer timer;

  Duration get throttle => persistor.throttle ?? const Duration();

  void process(
    ReduxAction<St> action,
    St newState,
  ) {
    assert(newState != null);
    assert(lastPersistTime != null);
    assert(isPersisting != null);
    //

    newestState = newState;

    var now = DateTime.now().toUtc();

    if (isPersisting) {
      newStateAvailable = true;
      return;
    }
    // If action is PersistAction, persist immediately.
    else if (action is PersistAction) {
      if (timer != null) {
        timer.cancel();
        timer = null;
      }
    }
    //
    // If throttle period is not done, create a timer to persist as soon as it finishes.
    else if (now.difference(lastPersistTime) < throttle) {
      if (timer == null) {
        Duration duration = throttle - now.difference(lastPersistTime);
        timer = Timer(duration, () {
          timer = null;
          process(null, newestState);
        });
      }
      return;
    }

    isPersisting = true;
    lastPersistTime = now;
    newStateAvailable = false;

    persistor
        .persistDifference(
      lastPersistedState: lastPersistedState,
      newState: newState,
    )
        .whenComplete(() {
      lastPersistedState = newState;
      isPersisting = false;

      // If a new state became available while the present state was saving, save again.
      if (newStateAvailable) {
        newStateAvailable = false;
        process(null, newestState);
      }
    });
  }
}
