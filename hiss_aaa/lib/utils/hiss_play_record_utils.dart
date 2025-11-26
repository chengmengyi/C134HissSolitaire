import 'package:hiss_aaa/bean/hiss_play_record_bean.dart';
import 'package:hiss_root/hiss_utils/hiss_sql/hiss_sql_name.dart';
import 'package:hiss_root/hiss_utils/hiss_sql/hiss_sql_utils.dart';

class HissPlayRecordUtils{
  static final HissPlayRecordUtils _hissPlayRecordUtils=HissPlayRecordUtils();
  static HissPlayRecordUtils get instance => _hissPlayRecordUtils;

  Future<int> insertPlayRecord(int score,int time,int step)async{
    var database = await HissSqlUtils.instance.initSql();
    var bean = HissPlayRecordBean(score: score,time: time,step: step);
    var id = await database.insert(HissSqlName.aPlayGameRecord, bean.toJson());
    return id;
  }

  Future<HissPlayRecordBean?> queryBestRecord(int currentId)async{
    var database = await HissSqlUtils.instance.initSql();
    var list = await database.query(HissSqlName.aPlayGameRecord, orderBy: 'score DESC', limit: 10,);
    print(list);
    if(list.isEmpty){
      return null;
    }
    var indexWhere = list.indexWhere((value)=>value["id"]!=currentId);
    if(indexWhere<0){
      return null;
    }
    return HissPlayRecordBean.fromJson(list[indexWhere]);
  }
}