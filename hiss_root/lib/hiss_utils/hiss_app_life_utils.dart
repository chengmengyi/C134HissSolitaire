import 'dart:async';

import 'package:flutter_app_lifecycle/app_state_observer.dart';
import 'package:flutter_app_lifecycle/flutter_app_lifecycle.dart';
import 'package:flutter_ios_ad_plugins/flutter_ios_ad_plugins.dart';
import 'package:flutter_ios_ad_plugins/hep/ad_type.dart';
import 'package:hiss_root/hiss_utils/hiss_ad_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_code.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_data.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_send_event_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_ios_notification_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_mp3_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_ad_enum.dart';

class HissAppLifeUtils{
  static final HissAppLifeUtils _appLifeUtils=HissAppLifeUtils();
  static HissAppLifeUtils get instance => _appLifeUtils;
  var toOpen=false,_back=false;
  Timer? _timer;

  addLife(){
    FlutterAppLifecycle.instance.setCallObserver(
      AppStateObserver(
        call: (back){
          if(back){
            HissMp3Utils.instance.stopBgm();
            _timer=Timer(Duration(milliseconds: 3000), (){
              _back=true;
            });
          }else{
            if(!FlutterIosAdPlugins.instance.adShowing()){
              HissMp3Utils.instance.playBgm();
            }
            _timer?.cancel();
            _timer=null;
            if(toOpen){
              HissIosNotificationUtils.instance.checkOpenNotification();
              toOpen=false;
            }else{
              if(_back&&!FlutterIosAdPlugins.instance.adShowing()){
                HissAdUtils.instance.showBBBAd(
                  adType: AdType.interstitial,
                  hissAdEnum: HissAdEnum.ccqes_launch,
                  showAd: true,
                  isOpen: true,
                  closeAdCallback: (give){

                  },
                );
              }
              _back=false;
            }
          }
          HissSendEventUtils.instance.sendEvent(data: HissEventData(eventCode: HissEventCode.onChangedAppLife,boolEventValue: back));
        },
      ),
    );
  }
}