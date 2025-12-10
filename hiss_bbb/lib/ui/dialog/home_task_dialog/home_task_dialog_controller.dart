import 'package:hiss_bbb/bean/hiss_daily_task_bean.dart';
import 'package:hiss_bbb/utils/hiss_daily_task_utils.dart';
import 'package:hiss_bbb/utils/hiss_enum/hiss_task_status.dart';
import 'package:hiss_bbb/utils/hiss_enum/hiss_task_type.dart';
import 'package:hiss_root/hiss_ui/hiss_root_controller.dart';
import 'package:hiss_root/hiss_utils/hiss_routers_utils.dart';

class HomeTaskDialogController extends HissRootController{
  List<HissDailyTaskBean> dailyList=[];

  @override
  void onReady() {
    super.onReady();
    _queryDailyList();
  }

  clickClaim(HissDailyTaskBean bean)async{
    await HissDailyTaskUtils.instance.claimReward(bean);
    _queryDailyList();
  }

  _queryDailyList()async{
    var list = await HissDailyTaskUtils.instance.queryTodayDailyTaskList();
    dailyList.clear();
    dailyList.addAll(list);
    update(["list"]);
  }

  String getTaskTitle(HissDailyTaskBean bean){
    switch(bean.type){
      case HissTaskType.game: return "Complete ${bean.totalPro??0} games";
      case HissTaskType.card: return "${bean.totalPro??0} cash cards";
      case HissTaskType.tool: return "Use ${bean.totalPro??0} tools";
      case HissTaskType.bubbles: return "${bean.totalPro??0} ad bubble rewards";
      case HissTaskType.rank: return "Rank top ${bean.totalPro??0} today";
      case HissTaskType.puzzle: return "${bean.totalPro??0} puzzle pieces";
      default: return "";
    }
  }

  String getBtnIcon(HissDailyTaskBean bean){
    switch(bean.status){
      case HissTaskStatus.canClaim: return "home_task5";
      case HissTaskStatus.notClaim: return "home_task4";
      case HissTaskStatus.claimed: return "home_task6";
      default: return "home_task6";
    }
  }

  String getBtnText(HissDailyTaskBean bean){
    switch(bean.status){
      case HissTaskStatus.claimed: return "Claimed";
      default: return "Claim";
    }
  }

  clickClose(){
    HissRoutersUtils.instance.close();
  }

  clickBottomIndex(int index, Function(int index) clickIndexCallback,){
    if(index==0){
      return;
    }
    HissRoutersUtils.instance.close();
    clickIndexCallback.call(index);
  }
}