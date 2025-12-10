import 'dart:convert';

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
}