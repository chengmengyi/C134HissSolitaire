import 'dart:io';

import 'package:flutter_tba_info/flutter_tba_info.dart';

class HissTravesty{
  var plat;
  var polaron;
  var serious;
  var leaf;

  Future<Map<String,dynamic>> initData()async{
    plat=await FlutterTbaInfo.instance.getDistinctId();
    polaron=await FlutterTbaInfo.instance.getOperator();
    serious=await FlutterTbaInfo.instance.getIdfv();
    leaf=await FlutterTbaInfo.instance.getOsCountry();
    return {
      "plat":plat,
      "polaron":polaron,
      "serious":serious,
      "leaf":leaf,
    };
  }
}