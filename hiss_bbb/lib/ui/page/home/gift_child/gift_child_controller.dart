import 'package:hiss_bbb/bean/hiss_home_gift_progress_bean.dart';
import 'package:hiss_bbb/ui/dialog/spin_reward_dialog/spin_reward_dialog.dart';
import 'package:hiss_bbb/ui/dialog/spin_reward_task_dialog/spin_reward_task_dialog.dart';
import 'package:hiss_bbb/utils/hiss_enum/hiss_home_gift_type.dart';
import 'package:hiss_bbb/utils/hiss_home_gift_utils.dart';
import 'package:hiss_root/hiss_ui/hiss_root_controller.dart';
import 'package:hiss_root/hiss_utils/hiss_ad_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_routers_utils.dart';

class GiftChildController extends HissRootController{
  List<HissHomeGiftProgressBean> topGiftList=[];
  List<String> centerGiftTypeList=[];

  @override
  void onInit() {
    super.onInit();
    _initCenterGiftTypeList();
  }

  @override
  void onReady() {
    super.onReady();
    _queryTopGiftList();
  }

  _queryTopGiftList()async{
    var list = await HissHomeGiftUtils.instance.queryGiftList();
    topGiftList.clear();
    topGiftList.addAll(list);
    topGiftList.addAll(list);
    topGiftList.addAll(list);
    topGiftList.addAll(list);
    topGiftList.addAll(list);
    topGiftList.addAll(list);
    update(["top_list"]);
  }

  String getGiftName(String? type){
    switch(type){
      case HissHomeGiftType.pay: return "PayPal \$200";
      case HissHomeGiftType.phone: return "iPhone 17 Pro Max";
      case HissHomeGiftType.game: return "Switch 2";
      case HissHomeGiftType.package23: return "IDOL No. 23 Handbag";
      case HissHomeGiftType.card: return "\$500 Amazon";
      case HissHomeGiftType.chuifengji: return "Dyson Hair Dryer";
      case HissHomeGiftType.package2025: return " CHANEL 2026 Handbag";
      default: return "";
    }
  }

  clickTopGiftItem(HissHomeGiftProgressBean item){
    if((item.currentPro??0)>=(item.totalPro??0)){
      HissRoutersUtils.instance.showDialog(
        child: SpinRewardTaskDialog(
          rewardType: item.type,
        ),
      );
    }
  }

  clickCenterGift(String type){
    HissAdUtils.instance.showBBBAd(
      closeAdCallback: (give)async{
        if(give){
          var progress = await HissHomeGiftUtils.instance.updateHomeGiftProgress(type);
          for (var value in topGiftList) {
            if(value.type==type){
              value.currentPro=progress;
            }
          }
          update(["top_list"]);
        }
      },
    );
  }

  clickSpin(){
    HissRoutersUtils.instance.showDialog(
      child: SpinRewardDialog(),
    );
  }

  _initCenterGiftTypeList(){
    centerGiftTypeList.clear();
    centerGiftTypeList.add(HissHomeGiftType.phone);
    centerGiftTypeList.add(HissHomeGiftType.package23);
    centerGiftTypeList.add(HissHomeGiftType.card);
    centerGiftTypeList.add(HissHomeGiftType.chuifengji);
    centerGiftTypeList.add(HissHomeGiftType.package2025);
    centerGiftTypeList.add(HissHomeGiftType.game);
    centerGiftTypeList.add(HissHomeGiftType.pay);
    centerGiftTypeList.shuffle();
  }
}