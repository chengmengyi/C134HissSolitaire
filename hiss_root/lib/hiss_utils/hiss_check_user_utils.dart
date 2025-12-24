import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_check_adjust/flutter_check_adjust.dart';
import 'package:flutter_check_adjust/request_adjust/request_adjust_callback.dart';
import 'package:flutter_check_adjust/request_cloak/request_cloak_callback.dart';
import 'package:flutter_tba_info/flutter_tba_info.dart';
import 'package:hiss_root/hiss_utils/hiss_local.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_point_enum.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_point_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_utils.dart';

class HissCheckUserUtils{
  static final HissCheckUserUtils _checkUserUtils=HissCheckUserUtils();
  static HissCheckUserUtils get instance=>_checkUserUtils;

  Function()? aPackageCheckCallback;

  initCheck()async{
    var distinctId = await FlutterTbaInfo.instance.getDistinctId();
    FlutterCheckAdjust.instance.init(
      adjustAppToken: HissLocal.adjustKeyBase64.base64(),
      distinctId: distinctId,
      clockUrl: HissLocal.cloakUrl,
      cloakWhiteKey: "those",
      cloakData: await _initCloakMap(distinctId),
      referrerConfList: ["fb4a","gclid","not%20set","youtubeads","%7B%22","bytedance","adjust"],
      requestAdjustCallback: RequestAdjustCallback(
        startRequestAdjust: (){
          HissPointUtils.instance.pointEvent(hissPointEnum: HissPointEnum.adjust_req);
        },
        requestSuccess: (bool isB){
          HissPointUtils.instance.pointEvent(hissPointEnum: HissPointEnum.adjust_suc,params: {"cloak_user":isB?1:0});
          _delayCheckUser();
        },
        firstRequestAdjustB: (){
        },
      ),
      requestCloakCallback: RequestCloakCallback(
        startRequestCloak: (){
          HissPointUtils.instance.pointEvent(hissPointEnum: HissPointEnum.cloak_req);
        },
        requestSuccess: (bool isWhite){
          HissPointUtils.instance.pointEvent(hissPointEnum: HissPointEnum.cloak_suc,params: {"cloak_user":isWhite?1:0});
          _delayCheckUser();
        },
      ),
    );
  }

  bool getUser(){
    // if(kDebugMode){
    //   return true;
    // }
    if(Platform.isAndroid){
      return true;
    }
    return FlutterCheckAdjust.instance.checkUser();
  }

  test(){
    aPackageCheckCallback?.call();
    aPackageCheckCallback=null;
  }

  _delayCheckUser(){
    if(getUser()&&Platform.isIOS){
      aPackageCheckCallback?.call();
      aPackageCheckCallback=null;
    }
  }

  _initCloakMap(String distinctId)async => {
    "pliocene": await FlutterTbaInfo.instance.getBundleId(),
    "hijack": Platform.isAndroid?"lake":"yakima",
    "bernet": await FlutterTbaInfo.instance.getAppVersion(),
    "plat": distinctId,
    "auger": DateTime.now().millisecondsSinceEpoch,
    "eliot": await FlutterTbaInfo.instance.getDeviceModel(),
    "arcsine": await FlutterTbaInfo.instance.getOsVersion(),
    "serious": await FlutterTbaInfo.instance.getIdfv(),
    "yogurt": await FlutterTbaInfo.instance.getGaid(),
    "phobic": await FlutterTbaInfo.instance.getAndroidId(),
    "creche": await FlutterTbaInfo.instance.getIdfa(),
    "polaron": await FlutterTbaInfo.instance.getOperator(),
    "loamy": await FlutterTbaInfo.instance.getBrand(),
  };
}