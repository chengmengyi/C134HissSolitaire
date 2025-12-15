import 'package:hiss_bbb/utils/hiss_home_gift_utils.dart';
import 'package:hiss_root/hiss_ui/hiss_root_controller.dart';
import 'package:hiss_root/hiss_utils/hiss_ad_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_routers_utils.dart';

class SpinRewardDialogController extends HissRootController{

  clickReceive(String type, Function(int progress) receiveCallback){
    HissAdUtils.instance.showBBBAd(
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
    HissAdUtils.instance.showBBBAd(
      closeAdCallback: (give)async{
        HissRoutersUtils.instance.close();
      },
    );
  }
}