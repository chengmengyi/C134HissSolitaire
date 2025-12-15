import 'dart:io';

import 'package:flutter_tba_info/flutter_tba_info.dart';

class HissSlander{
  var eliot;
  var arcsine;
  var prospect;
  var phobic;
  var creche;

  Future<Map<String,dynamic>> initData()async{
    eliot=await FlutterTbaInfo.instance.getDeviceModel();
    arcsine=await FlutterTbaInfo.instance.getOsVersion();
    prospect=await FlutterTbaInfo.instance.getNetworkType();
    phobic=await FlutterTbaInfo.instance.getAndroidId();
    creche=await FlutterTbaInfo.instance.getIdfa();
    return {
      "eliot":eliot,
      "arcsine":arcsine,
      "prospect":prospect,
      "phobic":phobic,
      "creche":creche,
    };
  }
}