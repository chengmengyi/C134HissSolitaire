import 'package:hiss_root/hiss_utils/hiss_sql/hiss_sql_name.dart';
import 'package:sqflite/sqflite.dart';

class HissSqlUtils{
  static final HissSqlUtils _hissSqlUtils=HissSqlUtils();
  static HissSqlUtils get instance=>_hissSqlUtils;

  Future<Database> initSql()async{
    var database = await openDatabase(
      "hiss.db",
      version: 1,
      onCreate: (db,version)async{
        _createVersion1DB(db);
      },
      // onUpgrade: (db,oldVersion,newVersion){
      //   if(newVersion==2){
      //     _createVersion2DB(db);
      //   }else if(newVersion==3){
      //     _createVersion3DB(db);
      //   }
      // },
    );
    return database;
  }

  _createVersion1DB(Database db){
    db.execute('CREATE TABLE ${HissSqlName.aPlayGameRecord} (id INTEGER PRIMARY KEY AUTOINCREMENT, score INTEGER, time INTEGER,step INTEGER)');
    db.execute('CREATE TABLE ${HissSqlName.aGiftInfo} (id INTEGER PRIMARY KEY AUTOINCREMENT, customId INTEGER, contentList TEXT, timer TEXT)');
    db.execute('CREATE TABLE ${HissSqlName.aRankInfo} (id INTEGER PRIMARY KEY AUTOINCREMENT, contentList TEXT, timer TEXT)');
  }
}