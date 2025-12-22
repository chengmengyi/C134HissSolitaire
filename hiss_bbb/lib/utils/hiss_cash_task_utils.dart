import 'dart:math';

import 'package:hiss_bbb/bean/hiss_account_bean.dart';
import 'package:hiss_bbb/bean/hiss_cash_rank_bean.dart';
import 'package:hiss_bbb/bean/hiss_cash_task_bean.dart';
import 'package:hiss_bbb/utils/hiss_task_queue_config_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_code.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_data.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_send_event_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_point_enum.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_point_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_sql/hiss_sql_name.dart';
import 'package:hiss_root/hiss_utils/hiss_sql/hiss_sql_utils.dart';

class HissCashTaskUtils{
  static final HissCashTaskUtils _cashTaskUtils=HissCashTaskUtils();
  static HissCashTaskUtils get instance => _cashTaskUtils;

  Future<HissCashTaskBean?> queryCashTaskByCashTypeMoney(String cashType,int cashMoney)async{
    var database = await HissSqlUtils.instance.initSql();
    var list = await database.query(HissSqlName.bCashTaskInfo,where: '"cashType" = ? AND "cashMoney" = ?',whereArgs: [cashType,cashMoney]);
    if(list.isEmpty){
      return null;
    }
    return HissCashTaskBean.fromJson(list.first);
  }

  createCashTask(String cashType,int cashMoney)async{
    var database = await HissSqlUtils.instance.initSql();
    var list = await database.query(HissSqlName.bCashTaskInfo,where: '"cashType" = ? AND "cashMoney" = ?',whereArgs: [cashType,cashMoney]);
    if(list.isNotEmpty){
      return;
    }
    var withdrawalTask = HissTaskQueueConfigUtils.instance.getWithdrawalTaskByIndex(0);
    var taskBean = HissCashTaskBean(cashType: cashType,cashMoney: cashMoney,taskIndex: 0,currentPro: 0,totalPro: withdrawalTask.num,);
    await database.insert(HissSqlName.bCashTaskInfo, taskBean.toJson());
    HissSendEventUtils.instance.sendEvent(data: HissEventData(eventCode: HissEventCode.updateCashTaskInfo));
  }

  updateCashTask(String taskType)async{
    var database = await HissSqlUtils.instance.initSql();
    var list = await database.query(HissSqlName.bCashTaskInfo);
    if(list.isEmpty){
      return;
    }
    for (var value in list) {
      var taskBean = HissCashTaskBean.fromJson(value);
      var withdrawalTask = HissTaskQueueConfigUtils.instance.getWithdrawalTaskByIndex(taskBean.taskIndex??0);
      if(withdrawalTask.name!=taskType){
        continue;
      }
      taskBean.currentPro=(taskBean.currentPro??0)+1;
      if((taskBean.currentPro??0)>=(taskBean.totalPro??0)){
        var nextWithdrawalTask = HissTaskQueueConfigUtils.instance.getNextWithdrawalTask(taskBean.taskIndex??0);
        //没有下一个任务了，任务完成了
        if(null==nextWithdrawalTask){
          await database.delete(HissSqlName.bCashTaskInfo,where: '"id" = ?',whereArgs: [value["id"]]);
          await _createCashRankInfo(taskBean.cashType, taskBean.cashMoney);
        }else{
          taskBean.taskIndex=(taskBean.taskIndex??0)+1;
          taskBean.currentPro=0;
          taskBean.totalPro=nextWithdrawalTask.num;
          await database.update(HissSqlName.bCashTaskInfo,taskBean.toJson(),where: '"id" = ?',whereArgs: [value["id"]]);
        }
      }else{
        await database.update(HissSqlName.bCashTaskInfo,taskBean.toJson(),where: '"id" = ?',whereArgs: [value["id"]]);
      }
    }
    HissSendEventUtils.instance.sendEvent(data: HissEventData(eventCode: HissEventCode.updateCashTaskInfo));
  }

  _createCashRankInfo(String? cashType,int? cashMoney)async{
    var database = await HissSqlUtils.instance.initSql();
    var rankBean = HissCashRankBean(cashType: cashType,cashMoney: cashMoney,currentPro: Random().nextInt(100)+400,totalPro: 500);
    await database.insert(HissSqlName.bCashRankInfo, rankBean.toJson());
    HissPointUtils.instance.pointEvent(hissPointEnum: HissPointEnum.cash_queue);
  }

  Future<HissCashRankBean?> queryCashRankInfoByCashTypeMoney(String? cashType,int? cashMoney)async{
    var database = await HissSqlUtils.instance.initSql();
    var list = await database.query(HissSqlName.bCashRankInfo,where: '"cashType" = ? AND "cashMoney" = ?',whereArgs: [cashType,cashMoney]);
    if(list.isEmpty){
      return null;
    }
    return HissCashRankBean.fromJson(list.first);
  }

  Future<HissCashRankBean?> updateCashRankInfo(String? cashType,int? cashMoney,int reduceNum)async{
    var database = await HissSqlUtils.instance.initSql();
    var list = await database.query(HissSqlName.bCashRankInfo,where: '"cashType" = ? AND "cashMoney" = ?',whereArgs: [cashType,cashMoney]);
    if(list.isEmpty){
      return null;
    }
    var rankBean = HissCashRankBean.fromJson(list.first);
    rankBean.currentPro=(rankBean.currentPro??0)-reduceNum;
    if((rankBean.currentPro??0)<1){
      rankBean.currentPro=1;
    }
    await database.update(HissSqlName.bCashRankInfo,rankBean.toJson(),where: '"id" = ?',whereArgs: [list.first["id"]]);
    return rankBean;
  }

  deleteCashRankInfo(String? cashType,int? cashMoney)async{
    var database = await HissSqlUtils.instance.initSql();
    await database.delete(HissSqlName.bCashRankInfo,where: '"cashType" = ? AND "cashMoney" = ?',whereArgs: [cashType,cashMoney]);
    HissSendEventUtils.instance.sendEvent(data: HissEventData(eventCode: HissEventCode.updateCashTaskInfo));
  }

  saveAccount(String cashType,String account)async{
    var database = await HissSqlUtils.instance.initSql();
    var list = await database.query(HissSqlName.bCashAccountInfo,where: '"cashType" = ? ',whereArgs: [cashType]);
    if(list.isNotEmpty){
      return;
    }
    var hissAccountBean = HissAccountBean(cashType: cashType,account: account);
    await database.insert(HissSqlName.bCashAccountInfo, hissAccountBean.toJson());
  }

  Future<String> queryAccount(String? cashType)async{
    var database = await HissSqlUtils.instance.initSql();
    var list = await database.query(HissSqlName.bCashAccountInfo,where: '"cashType" = ? ',whereArgs: [cashType]);
    if(list.isEmpty){
      return "";
    }
    return HissAccountBean.fromJson(list.first).account??"";
  }
}