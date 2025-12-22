import 'package:hiss_root/hiss_ui/hiss_root_controller.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_point_enum.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_point_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_routers_utils.dart';

class LoadAdFailDialogController extends HissRootController{
  @override
  void onInit() {
    super.onInit();
    HissPointUtils.instance.pointEvent(hissPointEnum: HissPointEnum.ad_retry);
  }

  clickTryAgain(Function() tryAgainCallback){
    HissPointUtils.instance.pointEvent(hissPointEnum: HissPointEnum.ad_retry_c);
    HissRoutersUtils.instance.close();
    tryAgainCallback.call();
  }
}