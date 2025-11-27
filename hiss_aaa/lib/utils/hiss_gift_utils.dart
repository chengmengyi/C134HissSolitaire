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
      HissGiftBean(customId: 1,giftType: HissGiftType.coins,addNum: 10,showAd: 0,giftStatus: HissGiftStatus.unReceive,),
      HissGiftBean(customId: 2,giftType: HissGiftType.tips,addNum: 1,showAd: 0,giftStatus: HissGiftStatus.lock,),
      HissGiftBean(customId: 3,giftType: HissGiftType.crystal,addNum: 5,showAd: 1,giftStatus: HissGiftStatus.lock,),
      HissGiftBean(customId: 4,giftType: HissGiftType.back,addNum: 1,showAd: 0,giftStatus: HissGiftStatus.lock,),
      HissGiftBean(customId: 5,giftType: HissGiftType.coins,addNum: 15,showAd: 1,giftStatus: HissGiftStatus.lock,),
      HissGiftBean(customId: 6,giftType: HissGiftType.tips,addNum: 2,showAd: 1,giftStatus: HissGiftStatus.lock,),
      HissGiftBean(customId: 7,giftType: HissGiftType.coins,addNum: 20,showAd: 0,giftStatus: HissGiftStatus.lock,),
      HissGiftBean(customId: 8,giftType: HissGiftType.back,addNum: 1,showAd: 0,giftStatus: HissGiftStatus.lock,),
      HissGiftBean(customId: 9,giftType: HissGiftType.coins,addNum: 20,showAd: 1,giftStatus: HissGiftStatus.lock,),
      HissGiftBean(customId: 10,giftType: HissGiftType.tips,addNum: 1,showAd: 1,giftStatus: HissGiftStatus.lock,),
      HissGiftBean(customId: 11,giftType: HissGiftType.back,addNum: 1,showAd: 1,giftStatus: HissGiftStatus.lock,),
      HissGiftBean(customId: 12,giftType: HissGiftType.coins,addNum: 50,showAd: 1,giftStatus: HissGiftStatus.lock,),
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

  updateTodayGiftList(HissGiftBean currentBean)async{
    var todayList = await queryTodayGiftList();
    if(todayList.isEmpty){
      return;
    }
    var indexWhere = todayList.indexWhere((value)=>value.customId==currentBean.customId);
    if(indexWhere>=0){
      todayList[indexWhere].giftStatus=HissGiftStatus.received;
    }
    if(indexWhere<todayList.length-1){
      todayList[indexWhere+1].giftStatus=HissGiftStatus.unReceive;
    }
    var todayTime = getTodayTime();
    var database = await HissSqlUtils.instance.initSql();
    await database.update(HissSqlName.aGiftInfo, {"timer":todayTime,"contentList":jsonEncode(todayList)},where: '"timer" = ? ',whereArgs: [todayTime]);
  }
}