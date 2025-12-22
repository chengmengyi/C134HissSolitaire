import 'package:hiss_bbb/utils/hiss_b_routers.dart';
import 'package:hiss_root/hiss_ui/hiss_root_controller.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_code.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_data.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_send_event_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_point_enum.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_point_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_routers_utils.dart';

class FirstReachCashMoneyDialogController extends HissRootController{

  @override
  void onInit() {
    super.onInit();
    HissPointUtils.instance.pointEvent(hissPointEnum: HissPointEnum.meet_withdraw);
  }

  clickGoto(){
    HissPointUtils.instance.pointEvent(hissPointEnum: HissPointEnum.meet_withdraw_c);
    HissRoutersUtils.instance.closeAllPageUntilNamed(str: HissBBBRouters.home);
    HissSendEventUtils.instance.sendEvent(data: HissEventData(eventCode: HissEventCode.showHomeTabIndex,intEventValue: 3));
  }

  clickClose(){
    HissRoutersUtils.instance.close();
  }
}