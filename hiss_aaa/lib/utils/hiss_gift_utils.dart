import 'dart:convert';

import 'package:hiss_aaa/bean/hiss_gift_bean.dart';
import 'package:hiss_aaa/utils/hiss_enum/hiss_gift_type.dart';
import 'package:hiss_root/hiss_utils/hiss_sql/hiss_sql_name.dart';
import 'package:hiss_root/hiss_utils/hiss_sql/hiss_sql_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_utils.dart';

class HissGiftUtils{
  static final HissGiftUtils _giftUtils=HissGiftUtils();
  static HissGiftUtils get instance => _giftUtils;

  insertTodayGiftInfo()async{
    var todayTime = getTodayTime();
    var database = await HissSqlUtils.instance.initSql();
    var list = await database.query(HissSqlName.aGiftInfo,where: '"timer" = ?',whereArgs: [todayTime]);
    if(list.isNotEmpty){
      return;
    }
    //  - 10金币->1提醒->ad5水晶->1撤回->｜ad15金币->ad2提醒->20金币->1撤回->｜ad20金币->ad1提醒->ad1撤回->ad50金币
    List<HissGiftBean> content=[
      HissGiftBean(giftType: HissGiftType.coins,addNum: 10,showAd: 0,giftStatus: HissGiftStatus.unReceive,),
      HissGiftBean(giftType: HissGiftType.tips,addNum: 1,showAd: 0,giftStatus: HissGiftStatus.lock,),
      HissGiftBean(giftType: HissGiftType.crystal,addNum: 5,showAd: 1,giftStatus: HissGiftStatus.lock,),
      HissGiftBean(giftType: HissGiftType.back,addNum: 1,showAd: 0,giftStatus: HissGiftStatus.lock,),
      HissGiftBean(giftType: HissGiftType.coins,addNum: 15,showAd: 1,giftStatus: HissGiftStatus.lock,),
      HissGiftBean(giftType: HissGiftType.tips,addNum: 2,showAd: 1,giftStatus: HissGiftStatus.lock,),
      HissGiftBean(giftType: HissGiftType.coins,addNum: 20,showAd: 0,giftStatus: HissGiftStatus.lock,),
      HissGiftBean(giftType: HissGiftType.back,addNum: 1,showAd: 0,giftStatus: HissGiftStatus.lock,),
      HissGiftBean(giftType: HissGiftType.coins,addNum: 20,showAd: 1,giftStatus: HissGiftStatus.lock,),
      HissGiftBean(giftType: HissGiftType.tips,addNum: 1,showAd: 1,giftStatus: HissGiftStatus.lock,),
      HissGiftBean(giftType: HissGiftType.back,addNum: 1,showAd: 1,giftStatus: HissGiftStatus.lock,),
      HissGiftBean(giftType: HissGiftType.coins,addNum: 50,showAd: 1,giftStatus: HissGiftStatus.lock,),
    ];
    await database.insert(HissSqlName.aGiftInfo, {"timer":todayTime,"contentList":jsonEncode(content)});
  }

  Future<List<HissGiftBean>> queryTodayGiftList()async{
    var todayTime = getTodayTime();
    var database = await HissSqlUtils.instance.initSql();
    var list = await database.query(HissSqlName.aGiftInfo,where: '"timer" = ?',whereArgs: [todayTime]);
    if(list.isEmpty){
      return [];
    }
    try{
      List<HissGiftBean> resultList=[];
      var json = jsonDecode(list.first["contentList"] as String);
      for(var value in json){
        resultList.add(HissGiftBean.fromJson(value));
      }
      return resultList;
    }catch(e){
      return [];
    }
  }
}