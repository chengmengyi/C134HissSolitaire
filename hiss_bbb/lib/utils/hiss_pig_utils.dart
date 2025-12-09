import 'package:hiss_bbb/bean/hiss_pig_info_bean.dart';
import 'package:hiss_bbb/utils/hiss_enum/hiss_pig_type.dart';
import 'package:hiss_root/hiss_utils/hiss_sql/hiss_sql_name.dart';
import 'package:hiss_root/hiss_utils/hiss_sql/hiss_sql_utils.dart';

class HissPigUtils{
  static final HissPigUtils _hissPigUtils=HissPigUtils();
  static HissPigUtils get instance => _hissPigUtils;

  initPigInfo()async{
    var database = await HissSqlUtils.instance.initSql();
    var list = await database.query(HissSqlName.aPigInfo);
    if(list.isNotEmpty){
      return;
    }
    //撤回、20小奖、提醒、20小奖、撤回、20小奖、提醒、20小奖、撤回、100金币大奖
    List<HissPigInfoBean> content=[
      HissPigInfoBean(type: HissPigType.back,status: HissPigStatus.lock,addNum: 1),
      HissPigInfoBean(type: HissPigType.coins,status: HissPigStatus.lock,addNum: 20),
      HissPigInfoBean(type: HissPigType.tips,status: HissPigStatus.lock,addNum: 1),
      HissPigInfoBean(type: HissPigType.coins,status: HissPigStatus.lock,addNum: 20),
      HissPigInfoBean(type: HissPigType.back,status: HissPigStatus.lock,addNum: 1),
      HissPigInfoBean(type: HissPigType.coins,status: HissPigStatus.lock,addNum: 20),
      HissPigInfoBean(type: HissPigType.tips,status: HissPigStatus.lock,addNum: 1),
      HissPigInfoBean(type: HissPigType.coins,status: HissPigStatus.lock,addNum: 20),
      HissPigInfoBean(type: HissPigType.back,status: HissPigStatus.lock,addNum: 1),
      HissPigInfoBean(type: HissPigType.coins,status: HissPigStatus.lock,addNum: 100),
    ];
    for (var value in content) {
      await database.insert(HissSqlName.aPigInfo, value.toJson());
    }
  }

  Future<List<HissPigInfoBean>> queryPigInfo()async{
    var database = await HissSqlUtils.instance.initSql();
    var list = await database.query(HissSqlName.aPigInfo);
    if(list.isEmpty){
      return [];
    }
    List<HissPigInfoBean> contentList=[];
    for (var value in list) {
      contentList.add(HissPigInfoBean.fromJson(value));
    }
    return contentList;
  }

  updateAllPigInfo(List<HissPigInfoBean> list)async{
    var database = await HissSqlUtils.instance.initSql();
    for (var value in list) {
      await database.update(HissSqlName.aPigInfo, value.toJson(),where: '"id" = ?',whereArgs: [value.id]);
    }
  }

  updateSinglePigInfo(HissPigInfoBean? bean)async{
    var database = await HissSqlUtils.instance.initSql();
    await database.update(HissSqlName.aPigInfo, bean?.toJson()??{},where: '"id" = ?',whereArgs: [bean?.id]);
  }
}