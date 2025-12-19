import 'package:hiss_bbb/ui/dialog/first_reach_cash_money_dialog/first_reach_cash_money_dialog.dart';
import 'package:hiss_bbb/ui/dialog/money300_700_result_dialog/money300_700_result_dialog.dart';
import 'package:hiss_bbb/ui/dialog/money_300_700_animator_dialog/money_300_700_animator_dialog.dart';
import 'package:hiss_bbb/utils/hiss_enum/hiss_prop_type.dart';
import 'package:hiss_bbb/utils/hiss_rank_utils.dart';
import 'package:hiss_bbb/utils/hiss_storage.dart';
import 'package:hiss_bbb/utils/hiss_value_config_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_code.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_data.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_send_event_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_routers_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_utils.dart';

class HissUserInfoUtils {
  static final HissUserInfoUtils _hissUserInfoUtils=HissUserInfoUtils();
  static HissUserInfoUtils get instance=>_hissUserInfoUtils;

  initMyInfo(){
    if(bMyName.getData().isEmpty){
      bMyName.saveData(HissRankUtils.instance.getRandomName());
    }
    if(bMyHead.getData().isEmpty){
      bMyHead.saveData(HissRankUtils.instance.getRandomHead());
    }
  }

  updateMoney(addNum){
    bMoneyNum.saveData(doubleAdd(bMoneyNum.getData(), addNum));
    if(addNum>0){
      allMoneyNum.saveData(allMoneyNum.getData()+addNum);
      var currentMoneyNum = bMoneyNum.getData();
      if(currentMoneyNum>=300&&show300AnimatorTips.getData()){
        show300AnimatorTips.saveData(false);
        _show300700AnimatorDialog(300);
      }else if(currentMoneyNum>=700&&show700AnimatorTips.getData()){
        show700AnimatorTips.saveData(false);
        _show300700AnimatorDialog(700);
      }else if(currentMoneyNum>=HissValueConfigUtils.instance.cashList().first&&show1000MoneyDialog.getData()){
        show1000MoneyDialog.saveData(false);
        _show1000MoneyDialog();
      }
    }
    HissSendEventUtils.instance.sendEvent(data: HissEventData(eventCode: HissEventCode.aUpdateMoneyNum));
  }

  _show300700AnimatorDialog(int maxMoney){
    HissRoutersUtils.instance.showDialog(
      child: Money300700AnimatorDialog(
        dismissCallback: (){
          HissRoutersUtils.instance.showDialog(
            child: Money300700ResultDialog(maxMoney: maxMoney),
          );
        },
      ),
    );
  }

  _show1000MoneyDialog(){
    HissRoutersUtils.instance.showDialog(
      child: FirstReachCashMoneyDialog(),
    );
  }

  updateDiamondNum(int addNum){
    bDiamondNum.saveData(bDiamondNum.getData()+addNum);
    HissSendEventUtils.instance.sendEvent(data: HissEventData(eventCode: HissEventCode.aUpdateDiamondNum));
  }

  updatePropNum({
    required HissPropType hissPropType,
    required int addNum,
  }){
    switch(hissPropType){
      case HissPropType.back:
        bBackPropNum.saveData(bBackPropNum.getData()+addNum);
        break;
      case HissPropType.tips:
        bTipsPropNum.saveData(bTipsPropNum.getData()+addNum);
        break;
    }
    HissSendEventUtils.instance.sendEvent(data: HissEventData(eventCode: HissEventCode.aUpdatePropNum));
  }

  updateUserLevel(){
    bLevel.saveData(bLevel.getData()+1);
    HissSendEventUtils.instance.sendEvent(data: HissEventData(eventCode: HissEventCode.aUpdateLevel));
  }

  updateWheelNum(int addNum){
    wheelNum.saveData(wheelNum.getData()+addNum);
    HissSendEventUtils.instance.sendEvent(data: HissEventData(eventCode: HissEventCode.updateWheelNum));
  }
}