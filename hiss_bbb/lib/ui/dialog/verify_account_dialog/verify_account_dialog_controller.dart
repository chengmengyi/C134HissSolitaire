import 'package:hiss_root/hiss_ui/hiss_root_controller.dart';
import 'package:hiss_root/hiss_utils/hiss_routers_utils.dart';

class VerifyAccountDialogController extends HissRootController{
  var account="";

  clickConfirm(){
    HissRoutersUtils.instance.close();
  }
}