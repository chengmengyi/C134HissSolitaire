import 'package:hiss_bbb/utils/hiss_value_config_utils.dart';
import 'package:hiss_root/hiss_ui/hiss_root_controller.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_point_enum.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_point_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_routers_utils.dart';

class FirstMoveCardToFoundationsDialogController extends HissRootController{
  var reward=HissValueConfigUtils.instance.getFlipCardAddNum();

  @override
  void onInit() {
    super.onInit();
    HissPointUtils.instance.pointEvent(hissPointEnum: HissPointEnum.move_card_reward);
  }

  clickClose(Function() callback){
    HissPointUtils.instance.pointEvent(hissPointEnum: HissPointEnum.move_card_reward_c);
    HissRoutersUtils.instance.close();
    callback.call();
  }
}