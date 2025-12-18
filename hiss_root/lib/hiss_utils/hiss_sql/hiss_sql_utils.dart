import 'package:hiss_root/hiss_utils/hiss_sql/hiss_sql_name.dart';
import 'package:sqflite/sqflite.dart';

class HissSqlUtils{
  static final HissSqlUtils _hissSqlUtils=HissSqlUtils();
  static HissSqlUtils get instance=>_hissSqlUtils;

  Future<Database> initSql()async{
    var database = await openDatabase(
      "hiss.db",
      version: 2,
      onCreate: (db,version)async{
        _createVersion1DB(db);
        _createVersion2DB(db);
      },
      onUpgrade: (db,oldVersion,newVersion){
        if(newVersion==2){
          _createVersion2DB(db);
        }
      },
    );
    return database;
  }

  _createVersion1DB(Database db){
    db.execute('CREATE TABLE ${HissSqlName.aPlayGameRecord} (id INTEGER PRIMARY KEY AUTOINCREMENT, score INTEGER, time INTEGER,step INTEGER)');
    db.execute('CREATE TABLE ${HissSqlName.aGiftInfo} (id INTEGER PRIMARY KEY AUTOINCREMENT, customId INTEGER, contentList TEXT, timer TEXT)');
    db.execute('CREATE TABLE ${HissSqlName.aRankInfo} (id INTEGER PRIMARY KEY AUTOINCREMENT, contentList TEXT, timer TEXT)');
    db.execute('CREATE TABLE ${HissSqlName.aPigInfo} (id INTEGER PRIMARY KEY AUTOINCREMENT, type TEXT, status TEXT,addNum INTEGER)');
  }

  _createVersion2DB(Database db){
    db.execute('CREATE TABLE ${HissSqlName.bDailyTask} (id INTEGER PRIMARY KEY AUTOINCREMENT, currentPro INTEGER, totalPro INTEGER,reward INTEGER, type TEXT, timer TEXT, status TEXT)');
    db.execute('CREATE TABLE ${HissSqlName.bGiftProgress} (id INTEGER PRIMARY KEY AUTOINCREMENT, currentPro INTEGER, totalPro INTEGER, type TEXT, status TEXT)');
    db.execute('CREATE TABLE ${HissSqlName.bGiftRewardTaskInfo} (id INTEGER PRIMARY KEY AUTOINCREMENT, currentPro INTEGER, totalPro INTEGER, type TEXT, taskType TEXT)');
    db.execute('CREATE TABLE ${HissSqlName.bCashTaskInfo} (id INTEGER PRIMARY KEY AUTOINCREMENT, cashType TEXT, cashMoney INTEGER, taskIndex INTEGER, currentPro INTEGER, totalPro INTEGER)');
    db.execute('CREATE TABLE ${HissSqlName.bCashRankInfo} (id INTEGER PRIMARY KEY AUTOINCREMENT, cashType TEXT, cashMoney INTEGER, currentPro INTEGER, totalPro INTEGER)');
    db.execute('CREATE TABLE ${HissSqlName.bCashAccountInfo} (id INTEGER PRIMARY KEY AUTOINCREMENT, cashType TEXT, account TEXT)');
    db.execute('CREATE TABLE ${HissSqlName.bRankInfo} (id INTEGER PRIMARY KEY AUTOINCREMENT, contentList TEXT, timer TEXT)');
    db.execute('CREATE TABLE ${HissSqlName.bGiftInfo} (id INTEGER PRIMARY KEY AUTOINCREMENT, customId INTEGER, contentList TEXT, timer TEXT)');
    db.execute('CREATE TABLE ${HissSqlName.bPigInfo} (id INTEGER PRIMARY KEY AUTOINCREMENT, type TEXT, status TEXT,addNum INTEGER)');
  }
}