import 'package:flutter_tba_info/flutter_tba_info.dart';

class HissHeader{
  var thimble;
  var yogurt;

  Future<Map<String,dynamic>> initData(String logId)async{
    thimble=logId;
    yogurt=await FlutterTbaInfo.instance.getGaid();
    return {
      "thimble":thimble,
    };
  }
}