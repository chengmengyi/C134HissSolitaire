import 'dart:convert';
import 'dart:math';

import 'package:hiss_bbb/bean/hiss_ad_probability_bean.dart';
import 'package:hiss_bbb/utils/hiss_storage.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';
import 'package:hiss_root/hiss_utils/hiss_local.dart';
import 'package:hiss_root/hiss_utils/hiss_utils.dart';

class HissShowAdUtils{
  static final HissShowAdUtils _adUtils=HissShowAdUtils();
  static HissShowAdUtils get instance => _adUtils;

  HissAdProbabilityBean? _adProbabilityBean;

  initData(){
    try{
      _adProbabilityBean=HissAdProbabilityBean.fromJson(jsonDecode(HissLocal.adProbabilityBase64.base64()));
    }catch(e){
      _adProbabilityBean=HissAdProbabilityBean.fromJson(jsonDecode(HissLocal.adProbabilityBase64.base64()));
    }
  }

  bool showAd(AdType adType){
    if(adType==AdType.reward){
      return true;
    }
    var list = _adProbabilityBean?.intAd??[];
    if(list.isEmpty){
      return false;
    }
    var last = list.last;
    var myMoney = allMoneyNum.getData();
    if(myMoney>=(last.endNumber??1000)){
      return Random().nextInt(100)<(last.point??60);
    }
    for (var value in list) {
      if(myMoney>=(value.firstNumber??0)&&myMoney<(value.endNumber??0)){
        return Random().nextInt(100)<(value.point??60);
      }
    }
    return true;
  }
}