import 'package:hiss_bbb/ui/dialog/spin_reward_dialog/spin_reward_dialog.dart';
import 'package:hiss_bbb/ui/dialog/spin_reward_task_dialog/spin_reward_task_dialog.dart';
import 'package:hiss_root/hiss_ui/hiss_root_controller.dart';
import 'package:hiss_root/hiss_utils/hiss_routers_utils.dart';

class GiftChildController extends HissRootController{
  clickSpin(){
    // HissRoutersUtils.instance.showDialog(
    //   child: SpinRewardDialog(),
    // );

    HissRoutersUtils.instance.showDialog(
      child: SpinRewardTaskDialog(),
    );
  }
}