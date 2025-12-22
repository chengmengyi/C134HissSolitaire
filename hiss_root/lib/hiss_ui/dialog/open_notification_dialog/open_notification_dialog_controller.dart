import 'package:app_settings/app_settings.dart';
import 'package:hiss_root/hiss_ui/hiss_root_controller.dart';
import 'package:hiss_root/hiss_utils/hiss_app_life_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_point_enum.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_point_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_routers_utils.dart';

class OpenNotificationDialogController extends HissRootController{
  @override
  void onInit() {
    super.onInit();
    HissPointUtils.instance.pointEvent(hissPointEnum: HissPointEnum.noti_confirm_pop);
  }

  clickOpen(){
    HissAppLifeUtils.instance.toOpen=true;
    HissPointUtils.instance.pointEvent(hissPointEnum: HissPointEnum.noti_confirm_pop_allow);
    HissRoutersUtils.instance.close();
    AppSettings.openAppSettings(type: AppSettingsType.notification);
  }

  clickClose(){
    HissPointUtils.instance.pointEvent(hissPointEnum: HissPointEnum.noti_confirm_pop_skip);
    HissRoutersUtils.instance.close();
  }
}