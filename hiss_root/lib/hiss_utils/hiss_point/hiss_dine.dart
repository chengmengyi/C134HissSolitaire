import 'dart:io';

import 'package:flutter_tba_info/flutter_tba_info.dart';

class HissDine{
  var bernet;
  var auger;
  var fussy;
  var litany;
  var yogurt;

  Future<Map<String,dynamic>> initData()async{
    bernet=await FlutterTbaInfo.instance.getAppVersion();
    auger=DateTime.now().millisecondsSinceEpoch;
    fussy=await FlutterTbaInfo.instance.getManufacturer();
    litany=await FlutterTbaInfo.instance.getSystemLanguage();
    yogurt=await FlutterTbaInfo.instance.getGaid();
    return {
      "bernet":bernet,
      "auger":auger,
      "fussy":fussy,
      "litany":litany,
      "yogurt":yogurt,
    };
  }
}