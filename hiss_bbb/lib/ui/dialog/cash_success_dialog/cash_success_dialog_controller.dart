import 'package:hiss_root/hiss_ui/hiss_root_controller.dart';
import 'package:hiss_root/hiss_utils/hiss_routers_utils.dart';

class CashSuccessDialogController extends HissRootController{
  clickOk(Function() callback){
    HissRoutersUtils.instance.close();
    callback.call();
  }
}