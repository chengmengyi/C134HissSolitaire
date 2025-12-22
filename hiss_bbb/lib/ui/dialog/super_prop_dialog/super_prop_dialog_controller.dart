import 'dart:math';

import 'package:hiss_bbb/utils/hiss_enum/hiss_prop_type.dart';
import 'package:hiss_bbb/utils/hiss_show_ad_utils.dart';
import 'package:hiss_bbb/utils/hiss_user_info_utils.dart';
import 'package:hiss_bbb/utils/hiss_value_config_utils.dart';
import 'package:hiss_root/hiss_ui/hiss_root_controller.dart';
import 'package:hiss_root/hiss_utils/hiss_ad_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_ad_enum.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_point_enum.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_point_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_routers_utils.dart';

class SuperPropDialogController extends HissRootController{

  @override
  void onInit() {
    super.onInit();
    HissPointUtils.instance.pointEvent(hissPointEnum: HissPointEnum.game_couriertools);
  }


  clickClaim(Function() claimCallback){
    HissPointUtils.instance.pointEvent(hissPointEnum: HissPointEnum.game_couriertools_c);
    HissAdUtils.instance.showBBBAd(
      adType: AdType.reward,
      hissAdEnum: HissAdEnum.ccqes_couriertools_rv,
      showAd: HissShowAdUtils.instance.showAd(AdType.reward),
      closeAdCallback: (give){
        if(give){
          var hissPropType = Random().nextBool()?HissPropType.back:HissPropType.tips;
          HissUserInfoUtils.instance.updatePropNum(hissPropType: hissPropType, addNum: HissValueConfigUtils.instance.propAddNum());
        }
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