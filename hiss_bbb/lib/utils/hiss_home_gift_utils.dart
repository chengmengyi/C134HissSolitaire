import 'dart:math';

import 'package:hiss_bbb/bean/hiss_gift_reward_task_bean.dart';
import 'package:hiss_bbb/bean/hiss_home_gift_progress_bean.dart';
import 'package:hiss_bbb/utils/hiss_enum/hiss_gift_reward_task_type.dart';
import 'package:hiss_bbb/utils/hiss_enum/hiss_home_gift_type.dart';
import 'package:hiss_bbb/utils/hiss_task_queue_config_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_sql/hiss_sql_name.dart';
import 'package:hiss_root/hiss_utils/hiss_sql/hiss_sql_utils.dart';

class HissHomeGiftUtils{
  static final HissHomeGiftUtils _giftUtils=HissHomeGiftUtils();
  static HissHomeGiftUtils get instance => _giftUtils;

  initGift()async{
    var database = await HissSqlUtils.instance.initSql();
    var list = await database.query(HissSqlName.bGiftProgress,);
    if(list.isNotEmpty){
      return;
    }
    List<HissHomeGiftProgressBean> result=[
      HissHomeGiftProgressBean(currentPro: 0,totalPro: 20,type: HissHomeGiftType.pay,status: HissHomeGiftStatus.notClaim,),
      HissHomeGiftProgressBean(currentPro: 0,totalPro: 50,type: HissHomeGiftType.phone,status: HissHomeGiftStatus.notClaim,),
      HissHomeGiftProgressBean(currentPro: 0,totalPro: 30,type: HissHomeGiftType.game,status: HissHomeGiftStatus.notClaim,),
      HissHomeGiftProgressBean(currentPro: 0,totalPro: 30,type: HissHomeGiftType.package23,status: HissHomeGiftStatus.notClaim,),
      HissHomeGiftProgressBean(currentPro: 0,totalPro: 25,type: HissHomeGiftType.card,status: HissHomeGiftStatus.notClaim,),
      HissHomeGiftProgressBean(currentPro: 0,totalPro: 40,type: HissHomeGiftType.chuifengji,status: HissHomeGiftStatus.notClaim,),
      HissHomeGiftProgressBean(currentPro: 0,totalPro: 50,type: HissHomeGiftType.package2025,status: HissHomeGiftStatus.notClaim,),
    ];
    for (var value in result) {
      await database.insert(HissSqlName.bGiftProgress, value.toJson());
    }
  }

  Future<List<HissHomeGiftProgressBean>> queryGiftList()async{
    var database = await HissSqlUtils.instance.initSql();
    var list = await database.query(HissSqlName.bGiftProgress,);
    if(list.isEmpty){
      return [];
    }
    List<HissHomeGiftProgressBean> result=[];
    for (var value in list) {
      result.add(HissHomeGiftProgressBean.fromJson(value));
    }
    return result;
  }

  Future<int> updateHomeGiftProgress(String? type)async{
    _updateGiftRewardTaskPro();
    var database = await HissSqlUtils.instance.initSql();
    var list = await database.query(HissSqlName.bGiftProgress,where: '"type" = ? ',whereArgs: [type]);
     if(list.isEmpty){
      return 0;
    }
    var progressBean = HissHomeGiftProgressBean.fromJson(list.first);
    progressBean.currentPro=(progressBean.currentPro??0)+1;
    await database.update(HissSqlName.bGiftProgress, progressBean.toJson(),where: '"id" = ?',whereArgs: [list.first["id"]]);
    if((progressBean.currentPro??0)>=(progressBean.totalPro??0)){
      await _createGiftRewardTaskInfo(type);
    }
    return progressBean.currentPro??0;
  }

  //创建礼物奖励的任务信息
  _createGiftRewardTaskInfo(String? type)async{
    var database = await HissSqlUtils.instance.initSql();
    var list = await database.query(HissSqlName.bGiftRewardTaskInfo,where: '"type" = ? ',whereArgs: [type]);
    if(list.isNotEmpty){
      return;
    }
    var bean = HissGiftRewardTaskBean(
      currentPro: 0,
      totalPro: HissTaskQueueConfigUtils.instance.getGiftTaskPuzzleNum(),
      type: type,
      taskType: HissGiftRewardTaskType.task,
    );
    await database.insert(HissSqlName.bGiftRewardTaskInfo, bean.toJson(),);
  }

  Future<HissGiftRewardTaskBean?> queryGiftRewardTaskInfo(String? type)async{
    var database = await HissSqlUtils.instance.initSql();
    var list = await database.query(HissSqlName.bGiftRewardTaskInfo,where: '"type" = ? ',whereArgs: [type]);
    if(list.isEmpty){
      return null;
    }
    return HissGiftRewardTaskBean.fromJson(list.first);
  }

  _updateGiftRewardTaskPro()async{
    var database = await HissSqlUtils.instance.initSql();
    var list = await database.query(HissSqlName.bGiftRewardTaskInfo,where: '"taskType" = ? ',whereArgs: [HissGiftRewardTaskType.task]);
    if(list.isEmpty){
      return;
    }
    for (var value in list) {
      var taskBean = HissGiftRewardTaskBean.fromJson(value);
      taskBean.currentPro=(taskBean.currentPro??0)+1;
      if((taskBean.currentPro??0)>=(taskBean.totalPro??0)){
        taskBean.currentPro=0;
        taskBean.totalPro=100;
        taskBean.taskType=HissGiftRewardTaskType.kuaidi;
      }
      await database.update(HissSqlName.bGiftRewardTaskInfo, taskBean.toJson(),where: '"id" = ?',whereArgs: [value["id"]]);
    }
  }

  updateGiftRewardKuaiDiPro(String? type)async{
    var database = await HissSqlUtils.instance.initSql();
    var list = await database.query(HissSqlName.bGiftRewardTaskInfo,where: '"taskType" = ? AND type = ?',whereArgs: [HissGiftRewardTaskType.kuaidi,type]);
    if(list.isEmpty){
      return;
    }
    for (var value in list) {
      var taskBean = HissGiftRewardTaskBean.fromJson(value);
      taskBean.currentPro=(taskBean.currentPro??0)+Random().nextInt(5);
      if((taskBean.currentPro??0)>=(taskBean.totalPro??0)){
        taskBean.currentPro=taskBean.totalPro;
      }
      await database.update(HissSqlName.bGiftRewardTaskInfo, taskBean.toJson(),where: '"id" = ?',whereArgs: [value["id"]]);
    }
  }
}