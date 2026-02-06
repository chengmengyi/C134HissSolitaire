import 'package:hiss_bbb/bean/hiss_cash_task_bean.dart';
import 'package:hiss_bbb/bean/hiss_task_queue_config_bean.dart';
import 'package:hiss_bbb/utils/hiss_b_routers.dart';
import 'package:hiss_bbb/utils/hiss_enum/hiss_task_type.dart';
import 'package:hiss_bbb/utils/hiss_task_queue_config_utils.dart';
import 'package:hiss_bbb/utils/utils.dart';
import 'package:hiss_root/hiss_ui/hiss_root_controller.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_code.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_data.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_send_event_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_point_enum.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_point_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_routers_utils.dart';

class CashTaskDialogController extends HissRootController{
  HissCashTaskBean? cashTaskBean;
  // List<WithdrawalTask> taskList=[];

  CashTaskDialogController({
    required this.cashTaskBean,
});

  @override
  void onInit() {
    super.onInit();
    HissPointUtils.instance.pointEvent(hissPointEnum: HissPointEnum.cash_task_pop);
  }

  clickConfirm(){
    var withdrawalTask = HissTaskQueueConfigUtils.instance.getWithdrawalTaskByIndex(cashTaskBean?.taskIndex??0);
    if(withdrawalTask.name==HissTaskType.puzzle){
      if(playGamePageOpen){
        HissRoutersUtils.instance.closeAllPageUntilNamed(str: HissBBBRouters.play);
        HissSendEventUtils.instance.sendEvent(data: HissEventData(eventCode: HissEventCode.toPuzzlePageInPlayPage));
      }else{
        HissRoutersUtils.instance.close();
        HissSendEventUtils.instance.sendEvent(data: HissEventData(eventCode: HissEventCode.showHomeTabIndex,intEventValue: 2));
      }
    }else{
      if(playGamePageOpen){
        HissRoutersUtils.instance.closeAllPageUntilNamed(str: HissBBBRouters.play);
      }else{
        HissRoutersUtils.instance.close();
        HissRoutersUtils.instance.toNextPageByNamed(routerName: HissBBBRouters.play);
      }
    }
  }

  clickClose(){
    HissRoutersUtils.instance.close();
  }

  bool checkCompleted(int index)=>index<(cashTaskBean?.taskIndex??0);

  String getTaskIcon(){
    var withdrawalTask = HissTaskQueueConfigUtils.instance.getWithdrawalTaskByIndex(cashTaskBean?.taskIndex??0);
    switch(withdrawalTask.name){
      case HissTaskType.game: return "icon_task_game";
      case HissTaskType.card: return "icon_task_card";
      case HissTaskType.tool: return "icon_task_tool";
      case HissTaskType.rank: return "icon_task_rank";
      case HissTaskType.puzzle: return "icon_task_puzzle";
      case HissTaskType.bubbles: return "icon_task_bubble";
      default: return "icon_task_card";
    }
  }


  String getTaskTitle(){
    var withdrawalTask = HissTaskQueueConfigUtils.instance.getWithdrawalTaskByIndex(cashTaskBean?.taskIndex??0);
    var pro="${cashTaskBean?.currentPro??0}/${cashTaskBean?.totalPro??0}";
    switch(withdrawalTask.name){
      case HissTaskType.game: return "Complete $pro games";
      case HissTaskType.card: return "$pro cash cards";
      case HissTaskType.tool: return "Use $pro tools";
      case HissTaskType.bubbles: return "$pro ad bubble rewards";
      case HissTaskType.rank: return "Rank top $pro today";
      case HissTaskType.puzzle: return "$pro puzzle pieces";
      default: return "";
    }
  }
}