import 'dart:math';

import 'package:hiss_aaa/utils/hiss_enum/hiss_prop_type.dart';
import 'package:hiss_aaa/utils/hiss_user_info_utils.dart';
import 'package:hiss_aaa/utils/hiss_value_utils.dart';
import 'package:hiss_root/hiss_ui/hiss_root_controller.dart';
import 'package:hiss_root/hiss_utils/hiss_routers_utils.dart';

class RandomPropController extends HissRootController{

  clickGet(Function(HissPropType propType) dismissCallback){
    var hissPropType = Random().nextBool()?HissPropType.back:HissPropType.tips;
    HissUserInfoUtils.instance.updatePropNum(hissPropType: hissPropType, addNum: HissValueUtils.instance.propAddNum());
    HissRoutersUtils.instance.close();
    dismissCallback.call(hissPropType);
  }
}