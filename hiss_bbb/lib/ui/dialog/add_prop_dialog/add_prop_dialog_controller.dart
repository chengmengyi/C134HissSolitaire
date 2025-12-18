import 'package:hiss_bbb/utils/hiss_enum/hiss_prop_type.dart';
import 'package:hiss_bbb/utils/hiss_show_ad_utils.dart';
import 'package:hiss_bbb/utils/hiss_storage.dart';
import 'package:hiss_bbb/utils/hiss_user_info_utils.dart';
import 'package:hiss_bbb/utils/hiss_value_config_utils.dart';
import 'package:hiss_root/hiss_ui/hiss_root_controller.dart';
import 'package:hiss_root/hiss_utils/hiss_ad_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';
import 'package:hiss_root/hiss_utils/hiss_mp3_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_ad_enum.dart';
import 'package:hiss_root/hiss_utils/hiss_routers_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_utils.dart';

class AddPropDialogController extends HissRootController{

  @override
  void onInit() {
    super.onInit();
    HissMp3Utils.instance.playOtherMp3(HissMp3Type.prop);
  }

  clickFree(HissPropType hissPropType, Function() dismissCallback){
    HissAdUtils.instance.showBBBAd(
      adType: AdType.reward,
      hissAdEnum: HissAdEnum.ccqes_tools_rv,
      showAd: HissShowAdUtils.instance.showAd(AdType.reward),
      closeAdCallback: (give){
        if(give){
          HissUserInfoUtils.instance.updatePropNum(hissPropType: hissPropType, addNum: HissValueConfigUtils.instance.propAddNum());
        }
        HissRoutersUtils.instance.close();
        dismissCallback.call();
      },
    );
  }

  clickMoney(HissPropType hissPropType, Function() dismissCallback){
    if(bMoneyNum.getData()<HissValueConfigUtils.instance.propCostMoney()){
      "Not enough gold coins".showToast();
      return;
    }
    HissAdUtils.instance.showBBBAd(
      adType: AdType.interstitial,
      hissAdEnum: HissAdEnum.ccqes_tools_int,
      showAd: HissShowAdUtils.instance.showAd(AdType.interstitial),
      closeAdCallback: (give){
        HissUserInfoUtils.instance.updateMoney(-HissValueConfigUtils.instance.propCostMoney());
        HissUserInfoUtils.instance.updatePropNum(hissPropType: hissPropType, addNum: HissValueConfigUtils.instance.propAddNum());
        HissRoutersUtils.instance.close();
        dismissCallback.call();
      },
    );
  }

  clickClose(){
    HissAdUtils.instance.showBBBAd(
      adType: AdType.interstitial,
      hissAdEnum: HissAdEnum.ccqes_tools_int,
      showAd: HissShowAdUtils.instance.showAd(AdType.interstitial),
      closeAdCallback: (give){
        HissRoutersUtils.instance.close();
      },
    );
  }
}