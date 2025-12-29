import 'dart:convert';

import 'package:flutter_android_ad_plugins/data/ad_money_info_bean.dart';
import 'package:flutter_custom_facebook/flutter_custom_facebook.dart';

class HissFacebookUtils{
  static final HissFacebookUtils _facebookUtils=HissFacebookUtils();
  static HissFacebookUtils get instance => _facebookUtils;

  bool _inited=false;

  initFacebook(String s)async{
    try{
      if(_inited){
        return;
      }
      var json = jsonDecode(s);
      var result = await FlutterCustomFacebook.instance.initFaceBook(
        facebookId: json["app_id"].toString(),
        facebookToken: json["client_token"],
        facebookAppName: json["app_name"],
      );
      _inited=true;
    }catch(e){

    }
  }

  uploadRevenueToFacebook(AdMoneyInfoBean? ad){
    FlutterCustomFacebook.instance.logPurchase(amount: ad?.revenue??0.0, currency: "USD",);
  }
}