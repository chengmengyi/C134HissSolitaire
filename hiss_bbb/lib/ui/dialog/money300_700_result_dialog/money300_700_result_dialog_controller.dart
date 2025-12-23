import 'package:hiss_bbb/ui/dialog/input_account_dialog/input_account_dialog.dart';
import 'package:hiss_bbb/utils/hiss_b_routers.dart';
import 'package:hiss_bbb/utils/hiss_storage.dart';
import 'package:hiss_bbb/utils/hiss_value_config_utils.dart';
import 'package:hiss_bbb/utils/utils.dart';
import 'package:hiss_root/hiss_ui/hiss_root_controller.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_code.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_data.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_send_event_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_point_enum.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_point_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_routers_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_utils.dart';

class Money300700ResultDialogController extends HissRootController{

  @override
  void onInit() {
    super.onInit();
    HissPointUtils.instance.pointEvent(hissPointEnum: HissPointEnum.remind_pop);
  }

  clickPlayGame(){
    HissPointUtils.instance.pointEvent(hissPointEnum: HissPointEnum.remind_pop_c);
    HissRoutersUtils.instance.close();
    HissRoutersUtils.instance.showDialog(
      child: InputAccountDialog(cashMoney: HissValueConfigUtils.instance.cashList().first, callback: (){},),
    );
    // if(!playGamePageOpen){
    //   HissRoutersUtils.instance.toNextPageByNamed(routerName: HissBBBRouters.play);
    // }
  }

  clickCashOut(){
    HissRoutersUtils.instance.closeAllPageUntilNamed(str: HissBBBRouters.home);
    HissSendEventUtils.instance.sendEvent(data: HissEventData(eventCode: HissEventCode.showHomeTabIndex,intEventValue: 3));
  }

  String getProText(int index){
    switch(index){
      case 1: return "Submit payment information";
      case 0:
        var d = doubleSub(HissValueConfigUtils.instance.cashList().first, bMoneyNum.getData());
        return "Just \$${d<0?0:d} away from payout!";
      case 2: return "Revenue received";
      default: return "";
    }
  }
}