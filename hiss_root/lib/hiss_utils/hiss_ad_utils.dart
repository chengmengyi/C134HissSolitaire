import 'dart:convert';
import 'dart:math';

import 'package:flutter_ios_ad_plugins/data/ad_info_data.dart';
import 'package:flutter_ios_ad_plugins/data/ad_money_info_bean.dart';
import 'package:flutter_ios_ad_plugins/data/config_ad_data.dart';
import 'package:flutter_ios_ad_plugins/flutter_ios_ad_plugins.dart';
import 'package:flutter_ios_ad_plugins/hep/ad_type.dart';
import 'package:flutter_ios_ad_plugins/hep/ios_ad_callback.dart';
import 'package:flutter_ios_ad_plugins/hep/ios_load_ad_result_callback.dart';
import 'package:hiss_root/hiss_ui/dialog/load_ad_fail_dialog/load_ad_fail_dialog.dart';
import 'package:hiss_root/hiss_utils/hiss_local.dart';
import 'package:hiss_root/hiss_utils/hiss_mp3_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_ad_enum.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_point_enum.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_point_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_root_staorage.dart';
import 'package:hiss_root/hiss_utils/hiss_routers_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_utils.dart';

class HissAdUtils{
  static final HissAdUtils _adUtils=HissAdUtils();
  static HissAdUtils get instance => _adUtils;


  initAd(){
    FlutterIosAdPlugins.instance.initMax(
      maxKey: HissLocal.maxAdKeyBase64.base64(),
      data: _getConfigAdData(),
      topOnAppId: "",
      topOnAppKey: "",
      iosLoadAdResultCallback: IosLoadAdResultCallback(
        startLoadAdCallback: (info){
          HissPointUtils.instance.pointEvent(
            hissPointEnum: HissPointEnum.ad_request,
            params: {
              "ad_code_id":info?.adId,
              "ad_format":info?.adType.name,
              "ad_platform":info?.adPlat,
            },
          );
        },
        loadAdSuccessCallback: (maxAd,info,int loadTime){
          HissPointUtils.instance.pointEvent(
            hissPointEnum: HissPointEnum.ccqes_ad_return,
            params: {
              "ad_code_id":info?.adId,
              "ad_format":info?.adType.name,
              "ad_platform":info?.adPlat,
              "ad_request_time":loadTime,
            },
          );
        },
        loadAdFailCallback: (info){
          HissPointUtils.instance.pointEvent(
            hissPointEnum: HissPointEnum.ccqes_ad_return_fail,
            params: {
              "ad_code_id":info?.adId,
              "ad_format":info?.adType.name,
              "ad_platform":info?.adPlat,
            },
          );
        },
        initSdkSuccess: (int time, String platForm) {
          HissPointUtils.instance.pointEvent(
            hissPointEnum: HissPointEnum.ccqes_ad_initsuc,
            params: {
              "ad_platform":platForm,
              "ad_init_time":time,
            },
          );
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
    var resultData = FlutterIosAdPlugins.instance.getCacheResultData(adType);
    if(null==resultData){
      if(adType==AdType.reward){
        showToast("Failed to fetch ads. Please try again later");
      }else{
        closeAdCallback.call();
      }
      return;
    }
    FlutterIosAdPlugins.instance.showAd(
      adType: adType,
      iosAdCallback: IosAdCallback(
        showSuccess: (ad,info){
          HissMp3Utils.instance.stopBgm();
        },
        showFail: (){
          HissMp3Utils.instance.playBgm();
          if(adType==AdType.reward){
            showToast("Failed to fetch ads. Please try again later");
          }else{
            closeAdCallback.call();
          }
        },
        closeAd: (AdMoneyInfoBean? ad,AdInfoData? bean,bool hasReward){
          HissMp3Utils.instance.playBgm();
          closeAdCallback.call();
        },
        revenuePaid: (ad,info){

        },
      ),
    );
  }

  showBBBAd({
    required AdType adType,
    required HissAdEnum hissAdEnum,
    required bool showAd,
    required Function(bool giveReward) closeAdCallback,
    bool isOpen=false,
  }){
    if(!showAd){
      closeAdCallback.call(adType==AdType.interstitial);
      return;
    }
    HissPointUtils.instance.pointEvent(hissPointEnum: HissPointEnum.ccqes_ad_chance,params: {"ad_pos_id":hissAdEnum.name});
    var resultData = FlutterIosAdPlugins.instance.getCacheResultData(adType);
    if(null==resultData){
      HissPointUtils.instance.pointEvent(
        hissPointEnum: HissPointEnum.ccqes_ad_impression_fail,
        params: {
          "ad_pos_id":hissAdEnum.name,
          "reason":"no cache",
        },
      );
      FlutterIosAdPlugins.instance.loadAdWhenNoCache(adType);
      if(isOpen||adType==AdType.interstitial){
        closeAdCallback.call(true);
        return;
      }
      HissRoutersUtils.instance.showDialog(
        child: LoadAdFailDialog(
          tryAgainCallback: (){
            var data = FlutterIosAdPlugins.instance.getCacheResultData(adType);
            if(null==data){
              closeAdCallback.call(adType==AdType.interstitial);
              return;
            }
            _showAd(adType: adType, hissAdEnum: hissAdEnum, showAd: showAd, closeAdCallback: closeAdCallback,isOpen: isOpen,);
          },
          closeCallback: (){
            closeAdCallback.call(adType==AdType.interstitial);
          },
        ),
      );
      return;
    }
    _showAd(adType: adType, hissAdEnum: hissAdEnum, showAd: showAd, closeAdCallback: closeAdCallback,isOpen: isOpen,);
  }

  _showAd({
    required AdType adType,
    required HissAdEnum hissAdEnum,
    required bool showAd,
    required Function(bool giveReward) closeAdCallback,
    bool isOpen=false,
}){
    FlutterIosAdPlugins.instance.showAd(
      adType: adType,
      iosAdCallback: IosAdCallback(
        showSuccess: (ad,info){
          HissPointUtils.instance.adEvent(ad: ad, hissAdEnum: hissAdEnum, adInfoData: info);
        },
        showFail: (){
          HissPointUtils.instance.pointEvent(
            hissPointEnum: HissPointEnum.ccqes_ad_impression_fail,
            params: {
              "ad_pos_id":hissAdEnum.name,
              "reason":"impfail",
            },
          );
          if(isOpen){
            closeAdCallback.call(false);
            return;
          }
          if(adType==AdType.reward){
            showToast("Advertisement display failed, please try again later");
          }else{
            closeAdCallback.call(false);
          }
        },
        closeAd: (ad,info,hasReward){
          HissPointUtils.instance.pointEvent(
            hissPointEnum: HissPointEnum.ccqes_ad_imp_close,
            params: {
              "ad_code_id":info?.adId,
              "ad_format":info?.adType.name,
              "ad_platform":info?.adPlat,
            },
          );
          closeAdCallback.call(true);
        },
        revenuePaid: (ad,info){
        },
      ),
    );
  }

  ConfigAdData _getConfigAdData(){
    var data = hissAdJsonConfig.getData();
    if(data.isEmpty){
      data=HissLocal.adJsonBase64.base64();
    }
    var json = jsonDecode(data);
    return ConfigAdData(
      maxShowNum: json["vpmsydhi"],
      maxClickNum: json["dtcukgha"],
      priceSwitch: json["ccqes_switch"]??false,
      newInterList: _getNewAdList(json["ccqes_int"]),
      newRewardList: _getNewAdList(json["ccqes_rv"]),
    );
  }

  List<AdInfoData> _getNewAdList(List? list){
    if(null==list){
      return [];
    }
    List<AdInfoData> resultList=[];
    for (var value in list) {
      resultList.add(
          AdInfoData(
            adId: value["lmxrgdoa"],
            adPlat: value["fdpwdjcj"],
            adType: value["yioxspqr"]=="reward"?AdType.reward:AdType.interstitial,
            expireTime: value["kdbmxwot"],
          )
      );
    }
    return resultList;
  }


  updateConfigData(){
    FlutterIosAdPlugins.instance.updateAdData(_getConfigAdData());
  }
}