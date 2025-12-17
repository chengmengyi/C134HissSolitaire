import 'dart:convert';
import 'dart:math';

import 'package:hiss_bbb/bean/hiss_task_queue_config_bean.dart';
import 'package:hiss_root/hiss_utils/hiss_local.dart';
import 'package:hiss_root/hiss_utils/hiss_utils.dart';

class HissTaskQueueConfigUtils{
  static final HissTaskQueueConfigUtils _configUtils=HissTaskQueueConfigUtils();
  static HissTaskQueueConfigUtils get instance => _configUtils;
  
  HissTaskQueueConfigBean? _configBean;
  
  initBean(){
    try{
      _configBean=HissTaskQueueConfigBean.fromJson(jsonDecode(HissLocal.taskQueueConfigLocalStrBase64.base64()));
    }catch(e){
      
    }
  }

  List<DailyTask> getDailyTask()=>_configBean?.dailyTask??[];

  int getGiftTaskPuzzleNum()=>_configBean?.giftTaskPuzzleNum??10;

  List<WithdrawalTask> getWithdrawalTaskList()=>_configBean?.withdrawalTask??[];

  WithdrawalTask getWithdrawalTaskByIndex(int index){
    try{
      return _configBean?.withdrawalTask?[index]??WithdrawalTask(name: "card",num: 5);
    }catch(e){
      return WithdrawalTask(name: "card",num: 5);
    }
  }

  WithdrawalTask? getNextWithdrawalTask(int index){
    try{
      return _configBean?.withdrawalTask?[index+1];
    }catch(e){
      return null;
    }
  }

  int getRandomRankReduceNum(){
    var ss = _configBean?.queue?.sS??[];
    if(ss.isEmpty){
      return 0;
    }
    if(ss.length==1){
      return ss.first;
    }
    var min = ss.first;
    var max = ss.last;
    final random = Random();
    return min + random.nextInt(max - min + 1);
  }
}