import 'dart:math';

import 'package:hiss_bbb/utils/hiss_enum/hiss_prop_type.dart';
import 'package:hiss_bbb/utils/hiss_user_info_utils.dart';
import 'package:hiss_bbb/utils/hiss_value_config_utils.dart';
import 'package:hiss_root/hiss_ui/hiss_root_controller.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_point_enum.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_point_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_routers_utils.dart';

class RandomPropController extends HissRootController{
  @override
  void onInit() {
    super.onInit();
    HissPointUtils.instance.pointEvent(hissPointEnum: HissPointEnum.game_newpop);
  }

  clickGet(Function(HissPropType propType) dismissCallback){
    var hissPropType = Random().nextBool()?HissPropType.back:HissPropType.tips;
    HissUserInfoUtils.instance.updatePropNum(hissPropType: hissPropType, addNum: HissValueConfigUtils.instance.propAddNum());
    HissRoutersUtils.instance.close();
    dismissCallback.call(hissPropType);
  }
}