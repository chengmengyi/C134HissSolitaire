import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:hiss_root/hiss_utils/hiss_ad_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_root_staorage.dart';

class HissFirebaseUtils{
  static final HissFirebaseUtils _firebaseUtils=HissFirebaseUtils();
  static HissFirebaseUtils get instance => _firebaseUtils;

  Function(String s)? adProbabilityConfigCallback;
  Function(String s)? valueConfigCallback;
  Function(String s)? taskQueueConfigCallback;

  initFirebase()async{
    try{
      await Firebase.initializeApp();
      var remoteConfig = FirebaseRemoteConfig.instance;
      await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(seconds: 1),
      ));
      await remoteConfig.fetchAndActivate();
      _getConfig(remoteConfig);
    }catch(e){
      await Future.delayed(const Duration(milliseconds: 1000));
      initFirebase();
    }
  }

  _getConfig(FirebaseRemoteConfig remoteConfig){
    var c134_ad_int = remoteConfig.getString("c134_ad_int");
    if(c134_ad_int.isNotEmpty){
      adProbabilityConfigCallback?.call(c134_ad_int);
    }
    var c134_winning_reward = remoteConfig.getString("c134_winning_reward");
    if(c134_winning_reward.isNotEmpty){
      valueConfigCallback?.call(c134_winning_reward);
    }
    var c134_task_queue = remoteConfig.getString("c134_task_queue");
    if(c134_task_queue.isNotEmpty){
      taskQueueConfigCallback?.call(c134_task_queue);
    }
    var ccqes_ad_config = remoteConfig.getString("ccqes_ad_config");
    if(ccqes_ad_config.isNotEmpty){
      hissAdJsonConfig.saveData(ccqes_ad_config);
      HissAdUtils.instance.updateConfigData();
    }
  }
}