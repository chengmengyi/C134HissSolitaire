import 'package:flutter_ios_ad_plugins/data/ad_info_data.dart';
import 'package:flutter_ios_ad_plugins/data/ad_money_info_bean.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_ad_enum.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_top_data.dart';

class HissAd {
  Future<Map<String, dynamic>> initData(String logId,AdMoneyInfoBean? ad,HissAdEnum hissAdEnum,AdInfoData? adInfoData) async {
    var map = await HissTopData().initData(logId);
    map["workday"] = {
      "agleam": (ad?.revenue ?? 0) * 1000000,
      "elves": "USD",
      "flout": ad?.networkName ?? "",
      "viburnum": adInfoData?.adPlat ?? "",
      "maestro": adInfoData?.adId ?? "",
      "coronate": hissAdEnum.name,
      "conjoint": adInfoData?.adType.name,
      "bobble": ad?.revenuePrecision ?? "",
    };
    return map;
  }
}