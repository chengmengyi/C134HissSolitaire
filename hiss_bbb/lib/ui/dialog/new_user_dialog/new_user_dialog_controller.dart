import 'package:hiss_root/hiss_ui/hiss_root_controller.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_point_enum.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_point_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_routers_utils.dart';

class NewUserDialogController extends HissRootController{
  @override
  void onInit() {
    super.onInit();
    HissPointUtils.instance.pointEvent(hissPointEnum: HissPointEnum.new_guide);
  }

  clickClose(){
    HissRoutersUtils.instance.close();
  }

  clickPlay(Function() toPlayCallback){
    HissPointUtils.instance.pointEvent(hissPointEnum: HissPointEnum.new_guide_c);
    HissRoutersUtils.instance.close();
    toPlayCallback.call();
  }
}