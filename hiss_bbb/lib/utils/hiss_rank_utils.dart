import 'dart:convert';
import 'dart:math';

import 'package:hiss_bbb/bean/hiss_rank_bean.dart';
import 'package:hiss_root/hiss_utils/hiss_sql/hiss_sql_name.dart';
import 'package:hiss_root/hiss_utils/hiss_sql/hiss_sql_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_utils.dart';

class HissRankUtils{
  static final HissRankUtils _hissRankUtils=HissRankUtils();
  static HissRankUtils get instance => _hissRankUtils;

  final _nameList = [
    "James", "John", "Robert", "Michael", "William", "David", "Richard",
    "Joseph", "Thomas", "Charles", "Christopher", "Daniel", "Matthew",
    "Anthony", "Mark", "Donald", "Steven", "Paul", "Andrew", "Joshua",
    "Mary", "Patricia", "Jennifer", "Linda", "Elizabeth", "Barbara", "Susan",
    "Jessica", "Sarah", "Karen", "Nancy", "Lisa", "Margaret", "Betty",
    "Smith", "Johnson", "Williams", "Jones", "Brown", "Davis", "Miller",
    "Wilson", "Moore", "Taylor", "Anderson", "Thomas", "Jackson", "White",
    "Harris", "Martin", "Thompson", "Garcia", "Martinez", "Robinson"
  ];

  final _headList=["head1","head2","head3","head4","head5","head6","head7","head8","head9",];

  insertTodayRank()async{
    var todayTime = getTodayTime();
    var database = await HissSqlUtils.instance.initSql();
    var list = await database.query(HissSqlName.aRankInfo,where: '"timer" = ?',whereArgs: [todayTime]);
    if(list.isNotEmpty){
      return;
    }
    List<HissRankBean> contentList=[];
    var random = Random();
    while(contentList.length<20){
      contentList.add(HissRankBean(name: _nameList.random(),head: _headList.random(),level: random.nextInt(21)+2));
    }
    contentList.sort((a, b) => (b.level??0).compareTo((a.level??0)));
    int value = 100;
    for (var item in contentList) {
      item.diamond = value;
      item.coins = value;
      value = value - 10;
      if (value < 0){
        value = 0;
      }
    }
    await database.insert(HissSqlName.aRankInfo, {"timer":todayTime,"contentList":jsonEncode(contentList)});
  }

  Future<List<HissRankBean>> queryTodayRankList()async{
    var todayTime = getTodayTime();
    var database = await HissSqlUtils.instance.initSql();
    var list = await database.query(HissSqlName.aRankInfo,where: '"timer" = ?',whereArgs: [todayTime]);
    if(list.isEmpty){
      return [];
    }
    try{
      List<HissRankBean> resultList=[];
      var json = jsonDecode(list.first["contentList"] as String);
      for(var value in json){
        resultList.add(HissRankBean.fromJson(value));
      }
      return resultList;
    }catch(e){
      return [];
    }
  }

  String getRandomName()=>_nameList.random();

  String getRandomHead()=>_headList.random();
}