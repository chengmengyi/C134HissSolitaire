import 'package:hiss_bbb/bean/hiss_cash_task_bean.dart';
import 'package:hiss_bbb/bean/hiss_task_queue_config_bean.dart';
import 'package:hiss_bbb/utils/hiss_enum/hiss_task_type.dart';
import 'package:hiss_bbb/utils/hiss_task_queue_config_utils.dart';
import 'package:hiss_root/hiss_ui/hiss_root_controller.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_code.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_data.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_send_event_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_routers_utils.dart';

class CashTaskDialogController extends HissRootController{
  HissCashTaskBean? cashTaskBean;
  List<WithdrawalTask> taskList=[];

  CashTaskDialogController({
    required this.cashTaskBean,
});

  @override
  void onReady() {
    super.onReady();
    _initList();
  }

  clickConfirm(){
    HissRoutersUtils.instance.close();
    HissSendEventUtils.instance.sendEvent(data: HissEventData(eventCode: HissEventCode.showHomeTabIndex,intEventValue: 1));
  }

  clickClose(){
    HissRoutersUtils.instance.close();
  }

  _initList(){
    taskList.clear();
    taskList.addAll(HissTaskQueueConfigUtils.instance.getWithdrawalTaskList());
    update(["list"]);
  }

  bool checkCompleted(int index)=>index<(cashTaskBean?.taskIndex??0);

  String getTaskIcon(String? taskName){
    switch(taskName){
      case HissTaskType.game: return "icon_task_game";
      case HissTaskType.card: return "icon_task_card";
      case HissTaskType.tool: return "icon_task_tool";
      case HissTaskType.rank: return "icon_task_rank";
      case HissTaskType.puzzle: return "icon_task_puzzle";
      case HissTaskType.bubbles: return "icon_task_bubble";
      default: return "icon_task_card";
    }
  }
}