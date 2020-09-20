import 'package:event_bus/event_bus.dart';

class EventEmitter {
  static EventBus eventBus;
  static void initialize() {
    eventBus = EventBus();
  }
}