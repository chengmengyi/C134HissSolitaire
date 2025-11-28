import 'dart:math';

import 'package:hiss_aaa/utils/hiss_enum/hiss_prop_type.dart';
import 'package:hiss_aaa/utils/hiss_user_info_utils.dart';
import 'package:hiss_aaa/utils/hiss_value_utils.dart';
import 'package:hiss_root/hiss_ui/hiss_root_controller.dart';
import 'package:hiss_root/hiss_utils/hiss_ad_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';
import 'package:hiss_root/hiss_utils/hiss_routers_utils.dart';

class SuperPropDialogController extends HissRootController{

  clickClaim(Function() claimCallback){
    HissAdUtils.instance.showAAAAd(
      adType: AdType.reward,
      closeAdCallback: (){
        var hissPropType = Random().nextBool()?HissPropType.back:HissPropType.tips;
        HissUserInfoUtils.instance.updatePropNum(hissPropType: hissPropType, addNum: HissValueUtils.instance.propAddNum());
        HissRoutersUtils.instance.close();
        claimCallback.call();
      },
    );
  }

  clickClose(Function() cancelCallback){
    HissRoutersUtils.instance.close();
    cancelCallback.call();
  }
}