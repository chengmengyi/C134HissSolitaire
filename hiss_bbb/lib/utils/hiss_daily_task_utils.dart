import 'package:hiss_bbb/bean/hiss_daily_task_bean.dart';
import 'package:hiss_bbb/utils/hiss_enum/hiss_task_status.dart';
import 'package:hiss_bbb/utils/hiss_task_queue_config_utils.dart';
import 'package:hiss_bbb/utils/hiss_user_info_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_sql/hiss_sql_name.dart';
import 'package:hiss_root/hiss_utils/hiss_sql/hiss_sql_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_utils.dart';

class HissDailyTaskUtils {
  static final HissDailyTaskUtils _dailyTaskUtils=HissDailyTaskUtils();
  static HissDailyTaskUtils get instance => _dailyTaskUtils;

  initTodayDailyTask()async{
    var database = await HissSqlUtils.instance.initSql();
    var todayTime = getTodayTime();
    var list = await database.query(HissSqlName.bDailyTask,where: '"timer" = ?',whereArgs: [todayTime]);
    if(list.isNotEmpty){
      return;
    }
    var dailyTask = HissTaskQueueConfigUtils.instance.getDailyTask();
    for (var value in dailyTask) {
      var taskBean = HissDailyTaskBean(
        type: value.name,
        totalPro: value.num,
        currentPro: 0,
        reward: value.award,
        timer: todayTime,
        status: HissTaskStatus.notClaim,
      );
      await database.insert(HissSqlName.bDailyTask, taskBean.toJson(),);
    }
  }

  Future<List<HissDailyTaskBean>> queryTodayDailyTaskList()async{
    var database = await HissSqlUtils.instance.initSql();
    var todayTime = getTodayTime();
    var list = await database.query(HissSqlName.bDailyTask,where: '"timer" = ?',whereArgs: [todayTime]);
    List<HissDailyTaskBean> result=[];
    for (var value in list) {
      result.add(HissDailyTaskBean.fromJson(value));
    }
    return result;
  }

  updateDailyTaskProgress(String taskType)async{
    var database = await HissSqlUtils.instance.initSql();
    var todayTime = getTodayTime();
    var list = await database.query(HissSqlName.bDailyTask,where: '"timer" = ? AND "type" = ?',whereArgs: [todayTime,taskType]);
    if(list.isEmpty){
      return;
    }
    var taskBean = HissDailyTaskBean.fromJson(list.first);
    taskBean.currentPro=(taskBean.currentPro??0)+1;
    if((taskBean.currentPro??0)>(taskBean.totalPro??0)){
      taskBean.currentPro=taskBean.totalPro;
      if(taskBean.status==HissTaskStatus.notClaim){
        taskBean.status=HissTaskStatus.canClaim;
      }
    }
    await database.update(HissSqlName.bDailyTask, taskBean.toJson(),where: '"id" = ?',whereArgs: [list.first["id"]]);
  }

  claimReward(HissDailyTaskBean bean)async{
    if(bean.status!=HissTaskStatus.canClaim){
      return;
    }
    var database = await HissSqlUtils.instance.initSql();
    var todayTime = getTodayTime();
    var list = await database.query(HissSqlName.bDailyTask,where: '"timer" = ? AND "type" = ?',whereArgs: [todayTime,bean.type]);
    if(list.isEmpty){
      return;
    }
    var taskBean = HissDailyTaskBean.fromJson(list.first);
    HissUserInfoUtils.instance.updateMoney(taskBean.reward??0);
    taskBean.status=HissTaskStatus.claimed;
    await database.update(HissSqlName.bDailyTask, taskBean.toJson(),where: '"id" = ?',whereArgs: [list.first["id"]]);
  }
}