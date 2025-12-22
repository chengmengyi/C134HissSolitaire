import 'package:hiss_bbb/utils/hiss_home_gift_utils.dart';
import 'package:hiss_bbb/utils/hiss_show_ad_utils.dart';
import 'package:hiss_root/hiss_ui/hiss_root_controller.dart';
import 'package:hiss_root/hiss_utils/hiss_ad_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_ad_enum.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_point_enum.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_point_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_routers_utils.dart';

class SpinRewardDialogController extends HissRootController{

  clickReceive(String type, Function(int progress) receiveCallback){
    HissPointUtils.instance.pointEvent(hissPointEnum: HissPointEnum.gift_pop_c);
    HissAdUtils.instance.showBBBAd(
      adType: AdType.interstitial,
      hissAdEnum: HissAdEnum.ccqes_awardpop_int,
      showAd: HissShowAdUtils.instance.showAd(AdType.interstitial),
      closeAdCallback: (give)async{
        if(give){
          var progress = await HissHomeGiftUtils.instance.updateHomeGiftProgress(type);
          HissRoutersUtils.instance.close();
          receiveCallback.call(progress);
        }else{
          HissRoutersUtils.instance.close();
        }
      },
    );
  }

  clickClose(){
    HissPointUtils.instance.pointEvent(hissPointEnum: HissPointEnum.gift_pop_close);
    HissAdUtils.instance.showBBBAd(
      adType: AdType.interstitial,
      hissAdEnum: HissAdEnum.ccqes_awardpop_int,
      showAd: HissShowAdUtils.instance.showAd(AdType.interstitial),
      closeAdCallback: (give)async{
        HissRoutersUtils.instance.close();
      },
    );
  }
}