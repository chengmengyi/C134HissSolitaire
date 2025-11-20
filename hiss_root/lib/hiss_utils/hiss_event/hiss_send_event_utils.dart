import 'package:event_bus/event_bus.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_data.dart';

class HissSendEventUtils{
  static final HissSendEventUtils _eventUtils=HissSendEventUtils();
  static HissSendEventUtils get instance => _eventUtils;

  final EventBus _eventBus=EventBus();

  sendEvent({
    required HissEventData data,
  }){
    _eventBus.fire(data);
  }

  EventBus getEventBus()=>_eventBus;
}