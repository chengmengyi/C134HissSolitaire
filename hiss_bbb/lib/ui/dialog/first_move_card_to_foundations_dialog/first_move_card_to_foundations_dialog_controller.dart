import 'package:hiss_bbb/utils/hiss_value_config_utils.dart';
import 'package:hiss_root/hiss_ui/hiss_root_controller.dart';
import 'package:hiss_root/hiss_utils/hiss_routers_utils.dart';

class FirstMoveCardToFoundationsDialogController extends HissRootController{
  var reward=HissValueConfigUtils.instance.getFlipCardAddNum();

  clickClose(Function() callback){
    HissRoutersUtils.instance.close();
    callback.call();
  }
}