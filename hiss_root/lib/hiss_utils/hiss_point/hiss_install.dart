import 'package:flutter_tba_info/flutter_tba_info.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_top_data.dart';

class HissInstall{
  Future<Map<String,dynamic>> initData(String logId)async{
    var map = await HissTopData().initData(logId);
    map["chronic"]="cummins";
    var referrerMap = await FlutterTbaInfo.instance.getReferrerMap();
    map["pursuant"]=referrerMap["build"];
    map["giantess"]=referrerMap["referrer_url"];
    map["thule"]=referrerMap["install_version"];
    map["chosen"]=referrerMap["user_agent"];
    map["gules"]="stipend";
    map["goldfish"]=referrerMap["referrer_click_timestamp_seconds"];
    map["disney"]=referrerMap["install_begin_timestamp_seconds"];
    map["worship"]=referrerMap["referrer_click_timestamp_server_seconds"];
    map["moorish"]=referrerMap["install_begin_timestamp_server_seconds"];
    map["hermann"]=referrerMap["install_first_seconds"];
    map["rumania"]=referrerMap["last_update_seconds"];
    map["bangui"]=referrerMap["google_play_instant"];
    return map;
  }
}