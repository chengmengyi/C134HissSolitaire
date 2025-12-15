import 'package:hiss_root/hiss_utils/hiss_point/hiss_dine.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_slander.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_sou.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_travesty.dart';

class HissTopData{
  Future<Map<String,dynamic>> initData(String logId)async => {
    "sou":await HissSou().initData(logId),
    "dine":await HissDine().initData(),
    "travesty":await HissTravesty().initData(),
    "slander":await HissSlander().initData(),
  };
}