import 'package:hiss_bbb/utils/hiss_user_info_utils.dart';
import 'package:hiss_root/hiss_ui/hiss_root_controller.dart';
import 'package:hiss_root/hiss_utils/hiss_routers_utils.dart';

class FirstInputAccountRewardDialogController extends HissRootController{
  clickClose(Function() callback){
    HissRoutersUtils.instance.close();
    callback.call();
  }

  clickClaim(Function() callback){
    HissUserInfoUtils.instance.updateMoney(100);
    HissRoutersUtils.instance.close();
    callback.call();
  }
}