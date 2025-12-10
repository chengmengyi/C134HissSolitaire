import 'package:hiss_bbb/utils/hiss_enum/hiss_prop_type.dart';
import 'package:hiss_bbb/utils/hiss_rank_utils.dart';
import 'package:hiss_bbb/utils/hiss_storage.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_code.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_data.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_send_event_utils.dart';
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
    HissSendEventUtils.instance.sendEvent(data: HissEventData(eventCode: HissEventCode.aUpdateMoneyNum));
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
}