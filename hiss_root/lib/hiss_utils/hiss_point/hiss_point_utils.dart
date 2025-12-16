
import 'dart:convert';

import 'package:flutter_check_adjust/dio/dio_hep.dart';
import 'package:flutter_check_adjust/flutter_check_adjust.dart';
import 'package:flutter_ios_ad_plugins/data/ad_info_data.dart';
import 'package:flutter_ios_ad_plugins/data/ad_money_info_bean.dart';
import 'package:flutter_tba_info/flutter_tba_info.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_ad.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_ad_enum.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_header.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_install.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_point_enum.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_top_data.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_url.dart';
import 'package:hiss_root/hiss_utils/hiss_root_staorage.dart';

class HissPointUtils{
  static final HissPointUtils _hissPointUtils=HissPointUtils();
  static HissPointUtils get instance => _hissPointUtils;

  installEvent({int tryNum=5})async{
    if(alreadyUploadInstallEvent.getData()){
      return;
    }
    var logId = await FlutterTbaInfo.instance.getLogId();
    var map = await HissInstall().initData(logId);
    FlutterCheckAdjust.instance.log("tba--->install--->params:${jsonEncode(map)}");
    var dioResult = await DioHep.instance.requestPost(
      path: await HissUrl().initData(),
      data: map,
      header: await HissHeader().initData(logId),
    );
    FlutterCheckAdjust.instance.log("tba--->install--->result:${dioResult.success}--->paras:$map");
    if(dioResult.success){
      alreadyUploadInstallEvent.saveData(true);
    }else{
      await Future.delayed(Duration(milliseconds: 1000));
      if(tryNum>0){
        installEvent(tryNum: tryNum-1);
      }
    }
  }

  sessionEvent({int tryNum=5})async{
    var logId = await FlutterTbaInfo.instance.getLogId();
    var map = await HissTopData().initData(logId);
    map["chronic"]="chester";
    FlutterCheckAdjust.instance.log("tba--->session--->params:${jsonEncode(map)}");
    var dioResult = await DioHep.instance.requestPost(
      path: await HissUrl().initData(),
      data: map,
      header: await HissHeader().initData(logId),
    );
    FlutterCheckAdjust.instance.log("tba--->session--->result:${dioResult.success}--->paras:$map");
    if(!dioResult.success){
      await Future.delayed(Duration(milliseconds: 1000));
      if(tryNum>0){
        sessionEvent(tryNum: tryNum-1);
      }
    }
  }

  pointEvent({
    required HissPointEnum hissPointEnum,
    Map<String,dynamic>? params,
    int tryNum=5,
})async{
    var logId = await FlutterTbaInfo.instance.getLogId();
    var map = await HissTopData().initData(logId);
    map["chronic"]=hissPointEnum.name;
    if(null!=params){
      map["adoptive"]=params;
    }
    FlutterCheckAdjust.instance.log("tba--->point--->params:${jsonEncode(map)}");
    var dioResult = await DioHep.instance.requestPost(
      path: await HissUrl().initData(),
      data: map,
      header: await HissHeader().initData(logId),
    );
    FlutterCheckAdjust.instance.log("tba--->point--->result:${dioResult.success}--->paras:$map");
    if(!dioResult.success){
      await Future.delayed(Duration(milliseconds: 1000));
      if(tryNum>0){
        pointEvent(hissPointEnum: hissPointEnum,params: params,tryNum: tryNum-1);
      }
    }
  }

  adEvent({
    required AdMoneyInfoBean? ad,
    required HissAdEnum hissAdEnum,
    required AdInfoData? adInfoData,
    int tryNum=5,
  })async{
    var logId = await FlutterTbaInfo.instance.getLogId();
    var map = await HissAd().initData(logId, ad, hissAdEnum, adInfoData);
    FlutterCheckAdjust.instance.log("tba--->ad--->params:${jsonEncode(map)}");
    var dioResult = await DioHep.instance.requestPost(
      path: await HissUrl().initData(),
      data: map,
      header: await HissHeader().initData(logId),
    );
    FlutterCheckAdjust.instance.log("tba--->ad--->result:${dioResult.success}--->paras:$map");
    if(!dioResult.success){
      await Future.delayed(Duration(milliseconds: 1000));
      if(tryNum>0){
        adEvent(ad: ad, hissAdEnum: hissAdEnum, adInfoData: adInfoData,tryNum: tryNum-1);
      }
    }
  }
}