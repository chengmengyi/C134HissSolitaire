import 'package:hiss_root/hiss_ui/hiss_root_controller.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_code.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_data.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_send_event_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_routers_utils.dart';

class NoMoneyDialogController extends HissRootController{

  clickSpin(){
    HissRoutersUtils.instance.close();
    HissSendEventUtils.instance.sendEvent(data: HissEventData(eventCode: HissEventCode.showHomeTabIndex,intEventValue: 2));
  }
}