import 'dart:convert';

import 'package:flutter_check_adjust/dio/dio_hep.dart';
import 'package:flutter_tba_info/flutter_tba_info.dart';
import 'package:hiss_root/hiss_utils/hiss_local.dart';
import 'package:hiss_root/hiss_utils/hudong/hu_dong_url_bean.dart';
import '../hiss_export.dart';

class HissHudongUtils{
  static final HissHudongUtils _hissHudongUtils=HissHudongUtils();
  static HissHudongUtils get instance=>_hissHudongUtils;

  Future<HuDongUrlBean?> getHuDongUrl()async{
    var dioResult = await DioHep.instance.requestGet(
      path: "${HissLocal.hudongPath}/api/obligati",
      header: await _getHeader(),
      data: {"principl":"71b578b20ed34027b202ba8fb17d2207"},
    );
    try{
      if(!dioResult.success){
        return null;
      }
      return HuDongUrlBean.fromJson(jsonDecode(dioResult.msg));
    }catch(e){
      return null;
    }
  }

  uploadShowData(String url)async{
    var dioResult = await DioHep.instance.requestGet(path: url, data: null,header: await _getHeader(),);
  }

  uploadClickData(String url)async{
    var map = await _getHeader();
    var dioResult = await DioHep.instance.requestGet(path: url, data: null,header: map);
  }

  Future<Map<String,dynamic>> _getHeader()async{
    var networkType = await FlutterTbaInfo.instance.getNetworkType();
    return {
      "garage": await FlutterTbaInfo.instance.getBundleId(),
      "bread": await FlutterTbaInfo.instance.getDistinctId(),
      "republic": await FlutterTbaInfo.instance.getGaid(),
      "friendsh": Get.deviceLocale?.countryCode,
      "activity": networkType=="wifi"?"1":"0",
      "shame": "7",
    };
  }
}