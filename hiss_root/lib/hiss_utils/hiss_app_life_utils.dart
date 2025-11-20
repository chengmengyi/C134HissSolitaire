import 'package:flutter_app_lifecycle/app_state_observer.dart';
import 'package:flutter_app_lifecycle/flutter_app_lifecycle.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_code.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_data.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_send_event_utils.dart';

class HissAppLifeUtils{
  static final HissAppLifeUtils _appLifeUtils=HissAppLifeUtils();
  static HissAppLifeUtils get instance => _appLifeUtils;

  addLife(){
    FlutterAppLifecycle.instance.setCallObserver(
      AppStateObserver(
        call: (back){
          HissSendEventUtils.instance.sendEvent(data: HissEventData(eventCode: HissEventCode.onChangedAppLife,boolEventValue: back));
        },
      ),
    );
  }
}