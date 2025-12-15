import 'package:flutter_tba_info/flutter_tba_info.dart';
import 'package:hiss_root/hiss_utils/hiss_local.dart';

class HissUrl{
  Future<String> initData()async{
    var arcsine = await FlutterTbaInfo.instance.getOsVersion();
    return "${HissLocal.tbaUrl}?arcsine=$arcsine";
  }
}