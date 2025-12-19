import 'dart:convert';
import 'dart:math';

import 'package:hiss_bbb/bean/hiss_value_config_bean.dart';
import 'package:hiss_bbb/utils/hiss_storage.dart';
import 'package:hiss_root/hiss_utils/hiss_firebase_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_local.dart';
import 'package:hiss_root/hiss_utils/hiss_utils.dart';

class HissValueConfigUtils{
  static final HissValueConfigUtils _configUtils=HissValueConfigUtils();
  static HissValueConfigUtils get instance => _configUtils;

  HissValueConfigBean? _configBean;

  initBean(){
    _startInitBean();
    HissFirebaseUtils.instance.valueConfigCallback=(String s){
      if(valueConfig.getData().isEmpty){
        valueConfig.saveData(s);
        _startInitBean();
      }
    };
  }

  _startInitBean(){
    try{
      var data = valueConfig.getData();
      if(data.isEmpty){
        data=HissLocal.localRewardBase64.base64();
      }
      _configBean=HissValueConfigBean.fromJson(jsonDecode(data));
    }catch(e){
      _configBean=HissValueConfigBean.fromJson(jsonDecode(HissLocal.localRewardBase64.base64()));
    }
  }

  //道具增加数量
  int propAddNum()=>1;

  //道具消耗金币
  int propCostMoney()=>100;

  int lookAdAddMoneyNum()=>100;

  //悬浮气泡
  double getBubbleAddNum()=> _getRandomDouble(_configBean?.bubble??[10,15]);

  //翻开一张牌
  double getFlipCardAddNum(){
    var list = _configBean?.openCollectCard??[];
    if(list.isEmpty){
      return 0.5;
    }
    var data = bMoneyNum.getData();
    var last = list.last;
    if(data>=(last.max??1000)){
      return last.reward??0.5;
    }
    for(var value in list){
      if(data>=(value.min??0)&&data<(value.max??0)){
        return value.reward??0.5;
      }
    }
    return 0.5;
  }

  List<int> cashList()=>[1000,1200,1500];

  int getGiftPuzzleNum()=>_randomMinAndMax(_configBean?.giftPuzzle??[3,5]);

  int coinsCardNum()=>_randomMinAndMax(_configBean?.cashCard?.num??[4,7]);

  double coinsCardAddRewardNum()=>_getRandomDouble(_configBean?.cashCard?.reward??[8,15]);

  bool showDiamondIcon()=>Random().nextInt(100)<(_configBean?.diamondNum??30);

  int getRankDiamondMax(){
    var rankReward = _configBean?.rankReward??[];
    var indexWhere = rankReward.indexWhere((value)=>value.name=="diamond");
    if(indexWhere>=0){
      return rankReward[indexWhere].num??200;
    }
    return 200;
  }

  int getRankMoneyMax(){
    var rankReward = _configBean?.rankReward??[];
    var indexWhere = rankReward.indexWhere((value)=>value.name=="money");
    if(indexWhere>=0){
      return rankReward[indexWhere].num??100;
    }
    return 100;
  }

  List<int> getGiftRewardList(){
    var list = _configBean?.cyclicReward??[];
    var defaultList=[10,20,40,50,80];
    if(list.isEmpty){
      return defaultList;
    }
    var last = list.last;
    var data = bMoneyNum.getData();
    if(data>=(last.max??1000)){
      return last.reward??defaultList;
    }
    for(var value in list){
      if(data>=(value.min??0)&&data<(value.max??0)){
        return value.reward??defaultList;
      }
    }
    return defaultList;
  }

  List<int> getDiamondPigRewardList()=>_configBean?.diamondPig??[20,30,40,50,80];
  
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