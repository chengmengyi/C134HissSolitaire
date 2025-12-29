import 'package:hiss_bbb/ui/dialog/first_reach_cash_money_dialog/first_reach_cash_money_dialog.dart';
import 'package:hiss_bbb/ui/dialog/good_comment/good_comment_dialog.dart';
import 'package:hiss_bbb/ui/dialog/money300_700_result_dialog/money300_700_result_dialog.dart';
import 'package:hiss_bbb/ui/dialog/money_300_700_animator_dialog/money_300_700_animator_dialog.dart';
import 'package:hiss_bbb/utils/hiss_enum/hiss_prop_type.dart';
import 'package:hiss_bbb/utils/hiss_money_overlay_utils.dart';
import 'package:hiss_bbb/utils/hiss_rank_utils.dart';
import 'package:hiss_bbb/utils/hiss_storage.dart';
import 'package:hiss_bbb/utils/hiss_value_config_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_code.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_data.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_send_event_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_fk/hiss_fk_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_mp3_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_point_enum.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_point_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_root_staorage.dart';
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

  updateMoney(addNum,{bool showAnimator=false}){
    bMoneyNum.saveData(doubleAdd(bMoneyNum.getData(), addNum));
    if(addNum>0){
      if(showAnimator){
        HissMp3Utils.instance.playOtherMp3(HissMp3Type.money);
        HissMoneyOverlayUtils.instance.showOverlay();
      }
      var firstCashMoney = HissValueConfigUtils.instance.cashList().first;
      allMoneyNum.saveData(allMoneyNum.getData()+addNum);
      var currentMoneyNum = bMoneyNum.getData();
      _handleMoneyLevel(currentMoneyNum);
      if(currentMoneyNum>=300&&show300AnimatorTips.getData()){
        show300AnimatorTips.saveData(false);
        _show300700AnimatorDialog(300);
      }else if(currentMoneyNum>=700&&show700AnimatorTips.getData()){
        show700AnimatorTips.saveData(false);
        _show300700AnimatorDialog(700);
      }else if(currentMoneyNum>=firstCashMoney&&show1000MoneyDialog.getData()){
        show1000MoneyDialog.saveData(false);
        _show1000MoneyDialog();
      }

      var getRewardNum = hissGetTwoRvAdRewardNumCount.getData();
      var adLess = HissFkUtils.instance.getAdsfsdfsLessHiss();
      if(currentMoneyNum>=firstCashMoney&&getRewardNum<adLess){
        hissHasMoneyToCashRvAdNumLess3.saveData(true);
      }
      var adMore = HissFkUtils.instance.getAdMffwfworeHIss();
      if(currentMoneyNum<firstCashMoney&&getRewardNum>=adMore){
        hissNoMoneyToCashRvAdNumMore90.saveData(true);
      }
    }
    HissSendEventUtils.instance.sendEvent(data: HissEventData(eventCode: HissEventCode.aUpdateMoneyNum));
  }

  _handleMoneyLevel(double currentMoneyNum){
    var moneyLevel = bLastUploadMoneyLevel.getData()+100;
    if(currentMoneyNum>=moneyLevel){
      var max = ((currentMoneyNum-moneyLevel)~/100)+1;
      for(var index=0; index<max; index++){
        HissPointUtils.instance.pointEvent(hissPointEnum: HissPointEnum.cash_dall,params: {"money":moneyLevel});
        bLastUploadMoneyLevel.saveData(moneyLevel);
        moneyLevel+=100;
      }
    }
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

  showGoodCommentDialog({
    required Function() callback,
}){
    if(showGoodComment.getData()){
      HissRoutersUtils.instance.showDialog(
        child: GoodCommentDialog(
          callback: callback,
        ),
      );
      showGoodComment.saveData(false);
    }else{
      callback.call();
    }
  }
}