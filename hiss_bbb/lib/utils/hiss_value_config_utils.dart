import 'dart:convert';
import 'dart:math';

import 'package:hiss_bbb/bean/hiss_value_config_bean.dart';
import 'package:hiss_root/hiss_utils/hiss_local.dart';
import 'package:hiss_root/hiss_utils/hiss_utils.dart';

class HissValueConfigUtils{
  static final HissValueConfigUtils _configUtils=HissValueConfigUtils();
  static HissValueConfigUtils get instance => _configUtils;

  HissValueConfigBean? _configBean;

  initBean(){
    try{
      _configBean=HissValueConfigBean.fromJson(jsonDecode(HissLocal.localRewardBase64.base64()));
    }catch(e){
      _configBean=HissValueConfigBean.fromJson(jsonDecode(HissLocal.localRewardBase64.base64()));
    }
  }

  //悬浮气泡
  double getBubbleAddNum()=> 10.2;

  //翻开一张牌
  double getFlipCardAddNum()=>5.0;

  List<int> cashList()=>[1000,1200,1500];

  int coinsCardNum()=>_randomMinAndMax(_configBean?.cashCard?.num??[4,7]);

  double coinsCardAddRewardNum()=>_getRandomDouble(_configBean?.cashCard?.reward??[8,15]);

  bool showDiamondIcon()=>Random().nextInt(100)<(_configBean?.diamondNum??30);
  
  int _randomMinAndMax(List<int> list){
    if(list.isEmpty){
      return 0;
    }
    if(list.length==1){
      return list.first;
    }
    var min = list.first;
    var max = list.last;
    final random = Random();
    return min + random.nextInt(max - min + 1);
  }

  double _getRandomDouble(List<int> list) {
    if(list.isEmpty){
      return 0.0;
    }
    if(list.length==1){
      return list.first.toDouble();
    }
    var min = list.first;
    var max = list.last;
    final random = Random();
    double value = min + random.nextDouble() * (max - min);
    return value.toStringAsFixed(2).toDouble();
  }

}