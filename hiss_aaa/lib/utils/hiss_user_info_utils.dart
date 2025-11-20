import 'package:hiss_aaa/utils/hiss_enum/hiss_prop_type.dart';
import 'package:hiss_aaa/utils/hiss_storage.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_code.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_data.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_send_event_utils.dart';

class HissUserInfoUtils {
  static final HissUserInfoUtils _hissUserInfoUtils=HissUserInfoUtils();
  static HissUserInfoUtils get instance=>_hissUserInfoUtils;

  updateMoney(int addNum){
    aMoney.saveData(aMoney.getData()+addNum);
    HissSendEventUtils.instance.sendEvent(data: HissEventData(eventCode: HissEventCode.aUpdateMoneyNum));
  }

  updatePropNum({
    required HissPropType hissPropType,
    required int addNum,
  }){
    switch(hissPropType){
      case HissPropType.back:
        aBackPropNum.saveData(aBackPropNum.getData()+addNum);
        break;
      case HissPropType.tips:
        aTipsPropNum.saveData(aTipsPropNum.getData()+addNum);
        break;
    }
    HissSendEventUtils.instance.sendEvent(data: HissEventData(eventCode: HissEventCode.aUpdatePropNum));
  }
}