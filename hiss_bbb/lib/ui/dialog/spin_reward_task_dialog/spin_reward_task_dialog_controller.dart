import 'package:hiss_bbb/bean/hiss_gift_reward_task_bean.dart';
import 'package:hiss_bbb/utils/hiss_enum/hiss_gift_reward_task_type.dart';
import 'package:hiss_bbb/utils/hiss_home_gift_utils.dart';
import 'package:hiss_bbb/utils/hiss_show_ad_utils.dart';
import 'package:hiss_bbb/utils/utils.dart';
import 'package:hiss_root/hiss_ui/hiss_root_controller.dart';
import 'package:hiss_root/hiss_utils/hiss_ad_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_ad_enum.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_point_enum.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_point_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_routers_utils.dart';

class SpinRewardTaskDialogController extends HissRootController{
  String? type;
  HissGiftRewardTaskBean? rewardTaskBean;

  SpinRewardTaskDialogController({
    required this.type,
  });

  @override
  void onReady() {
    super.onReady();
    _queryTaskInfo();
  }

  _queryTaskInfo()async{
    rewardTaskBean=await HissHomeGiftUtils.instance.queryGiftRewardTaskInfo(type);
    update(["text","pro","task"]);
    await HissHomeGiftUtils.instance.updateGiftRewardKuaiDiPro(type);
    update(["pro"]);
  }

  String getText(){
    if(rewardTaskBean?.taskType==HissGiftRewardTaskType.task){
      return "We appreciate your participation! Your gift will be shipped promptly. Finish specific tasks to fast-track the delivery!";
    }
    return "Delivery speed and progress are controlled by the carrier, not our app. Thanks for your patience.";
  }

  double getPro(){
    if(rewardTaskBean?.taskType==HissGiftRewardTaskType.task){
      return getProgress(rewardTaskBean?.currentPro??0, rewardTaskBean?.totalPro??0)/2;
    }
    if(rewardTaskBean?.taskType==HissGiftRewardTaskType.kuaidi){
      var d = getProgress(rewardTaskBean?.currentPro??0, rewardTaskBean?.totalPro??0)/2;
      return d+0.5;
    }
    return 0.0;
  }

  double kuaidiMargeLeft(){
    var pro = getPro();
    if(pro<0.65){
      return 0.65;
    }else if(pro>0.9){
      return 0.9;
    }else{
      return pro;
    }
  }

  clickClose(){
    HissPointUtils.instance.pointEvent(hissPointEnum: HissPointEnum.gift_check_close);
    HissAdUtils.instance.showBBBAd(
      adType: AdType.interstitial,
      hissAdEnum: HissAdEnum.ccqes_awardprocess_int,
      showAd: HissShowAdUtils.instance.showAd(AdType.interstitial),
      closeAdCallback: (give)async{
        HissRoutersUtils.instance.close();
      },
    );
  }

  clickSpin(Function() clickSpinCallback){
    HissRoutersUtils.instance.close();
    clickSpinCallback.call();
  }
}