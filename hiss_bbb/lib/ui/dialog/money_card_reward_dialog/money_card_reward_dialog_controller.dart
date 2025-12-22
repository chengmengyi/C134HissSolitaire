import 'package:hiss_bbb/utils/hiss_show_ad_utils.dart';
import 'package:hiss_root/hiss_ui/hiss_root_controller.dart';
import 'package:hiss_root/hiss_utils/hiss_ad_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_ad_enum.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_point_enum.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_point_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_routers_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_utils.dart';

class MoneyCardRewardDialogController extends HissRootController{

  @override
  void onInit() {
    super.onInit();
    HissPointUtils.instance.pointEvent(hissPointEnum: HissPointEnum.game_moneycard);
  }

  double getOnlyReward(double reward){
    var d = doubleMul(reward, 0.1);
    if(d==0){
      return 0.1;
    }
    return d;
  }

  clickClaim(double reward,Function(double reward) callback){
    HissAdUtils.instance.showBBBAd(
      adType: AdType.reward,
      hissAdEnum: HissAdEnum.ccqes_card_rv,
      showAd: HissShowAdUtils.instance.showAd(AdType.reward),
      closeAdCallback: (give){
        if(give){
          HissRoutersUtils.instance.close();
          callback.call(reward);
        }
      },
    );
  }

  clickOnly(double reward,Function(double reward) callback){
    HissAdUtils.instance.showBBBAd(
      adType: AdType.interstitial,
      hissAdEnum: HissAdEnum.ccqes_card_int,
      showAd: HissShowAdUtils.instance.showAd(AdType.interstitial),
      closeAdCallback: (give){
        HissRoutersUtils.instance.close();
        callback.call(getOnlyReward(reward));
      },
    );
  }
}