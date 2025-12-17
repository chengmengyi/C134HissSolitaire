import 'package:hiss_bbb/utils/hiss_b_routers.dart';
import 'package:hiss_bbb/utils/hiss_storage.dart';
import 'package:hiss_bbb/utils/utils.dart';
import 'package:hiss_root/hiss_ui/hiss_root_controller.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_code.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_data.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_send_event_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_routers_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_utils.dart';

class Money300700ResultDialogController extends HissRootController{

  clickPlayGame(){
    HissRoutersUtils.instance.close();
    if(!playGamePageOpen){
      HissRoutersUtils.instance.toNextPageByNamed(routerName: HissBBBRouters.play);
    }
  }

  clickCashOut(){
    HissRoutersUtils.instance.closeAllPageUntilNamed(str: HissBBBRouters.home);
    HissSendEventUtils.instance.sendEvent(data: HissEventData(eventCode: HissEventCode.showHomeTabIndex,intEventValue: 3));
  }

  String getProText(int index,int maxMoney){
    switch(index){
      case 0: return "Submit payment information";
      case 1:
        var d = doubleSub(maxMoney, bMoneyNum.getData());
        return "Just \$${d<0?0:d} away from payout!";
      case 2: return "Revenue received";
      default: return "";
    }
  }
}