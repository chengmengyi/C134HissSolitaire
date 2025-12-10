import 'dart:math';

import 'package:flutter_ad_ios_plugins/data/ad_info_data.dart';
import 'package:flutter_ad_ios_plugins/data/config_ad_data.dart';
import 'package:flutter_ad_ios_plugins/flutter_ios_ad_hep.dart';
import 'package:flutter_ad_ios_plugins/hep/ad_type.dart';
import 'package:flutter_ad_ios_plugins/hep/ios_ad_callback.dart';
import 'package:flutter_ad_ios_plugins/hep/ios_load_ad_result_callback.dart';
import 'package:hiss_root/hiss_utils/hiss_local.dart';
import 'package:hiss_root/hiss_utils/hiss_mp3_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_utils.dart';

class HissAdUtils{
  static final HissAdUtils _adUtils=HissAdUtils();
  static HissAdUtils get instance => _adUtils;


  initAd(){
    FlutterIosAdHep.instance.initMax(
      maxKey: HissLocal.maxAdKeyBase64.base64(),
      data: _getConfigAdData(),
      fengKongLogic: (){
        return false;
      },
      iosLoadAdResultCallback: IosLoadAdResultCallback(
        startLoadAdCallback: (info){
        },
        loadAdSuccessCallback: (maxAd,info){
        },
        loadAdFailCallback: (info){
        },
      ),
    );
  }

  showAAAAd({
    required AdType adType,
    required Function() closeAdCallback,
  }){
    if(adType==AdType.interstitial&&Random().nextBool()){
      closeAdCallback.call();
      return;
    }
    var resultData = FlutterIosAdHep.instance.getCacheResultData(adType);
    if(null==resultData){
      if(adType==AdType.reward){
        showToast("Failed to fetch ads. Please try again later");
      }else{
        closeAdCallback.call();
      }
      return;
    }
    FlutterIosAdHep.instance.showAd(
      adType: adType,
      iosAdCallback: IosAdCallback(
        showSuccess: (ad,info){
          HissMp3Utils.instance.stopBgm();
        },
        showFail: (ad){
          HissMp3Utils.instance.playBgm();
          if(adType==AdType.reward){
            showToast("Failed to fetch ads. Please try again later");
          }else{
            closeAdCallback.call();
          }
        },
        closeAd: (){
          HissMp3Utils.instance.playBgm();
          closeAdCallback.call();
        },
        revenuePaid: (ad,info){

        },
      ),
    );
  }

  showBBBAd({
    required Function(bool giveReward) closeAdCallback,
  }){
    closeAdCallback.call(true);
  }

  ConfigAdData _getConfigAdData(){
    return ConfigAdData(
      maxShowNum: 100,
      maxClickNum: 100,
      priceSwitch: false,
      newInterList: [AdInfoData(adId: HissLocal.intAdId, adPlat: "max", adType: AdType.interstitial, expireTime: 3000)],
      newRewardList: [AdInfoData(adId: HissLocal.rvAdId, adPlat: "max", adType: AdType.reward, expireTime: 3000)],
    );
  }
}