import 'dart:io';

import 'package:flutter_tba_info/flutter_tba_info.dart';

class HissSou{
  var pliocene;
  var hijack;
  var thimble;
  var loamy;

  Future<Map<String,dynamic>> initData(String logId)async{
    pliocene=await FlutterTbaInfo.instance.getBundleId();
    hijack=Platform.isAndroid?"lake":"yakima";
    thimble=logId;
    loamy=await FlutterTbaInfo.instance.getBrand();
    return {
      "pliocene":pliocene,
      "hijack":hijack,
      "thimble":thimble,
      "loamy":loamy,
    };
  }
}