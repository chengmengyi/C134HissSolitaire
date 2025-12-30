import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hiss134/hiss_common_router/hiss_common_routers.dart';
import 'package:hiss_aaa/utils/hiss_a_routers.dart';
import 'package:hiss_aaa/utils/hiss_gift_utils.dart';
import 'package:hiss_aaa/utils/hiss_pig_utils.dart';
import 'package:hiss_aaa/utils/hiss_rank_utils.dart';
import 'package:hiss_aaa/utils/hiss_user_info_utils.dart';
import 'package:hiss_bbb/utils/hiss_b_routers.dart';
import 'package:hiss_bbb/utils/hiss_daily_task_utils.dart';
import 'package:hiss_bbb/utils/hiss_home_gift_utils.dart';
import 'package:hiss_bbb/utils/hiss_show_ad_utils.dart';
import 'package:hiss_bbb/utils/hiss_task_queue_config_utils.dart';
import 'package:hiss_bbb/utils/hiss_value_config_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_app_life_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_connectivity_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';
import 'package:hiss_root/hiss_utils/hiss_fk/hiss_fk_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_mp3_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_routers_utils.dart';
import 'package:hiss_bbb/utils/hiss_gift_utils.dart' as bHissGiftUtils;
import 'package:hiss_bbb/utils/hiss_rank_utils.dart' as bHissRankUtils;
import 'package:hiss_bbb/utils/hiss_user_info_utils.dart' as bHissUserInfoUtils;
import 'package:hiss_bbb/utils/hiss_pig_utils.dart' as bHissPigUtils;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarDividerColor: null,
        statusBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
      )
  );
  await GetStorage.init();
  HissMp3Utils.instance.initPlayer();
  HissAppLifeUtils.instance.addLife();

  //a
  HissGiftUtils.instance.insertTodayGiftInfo();
  HissRankUtils.instance.insertTodayRank();
  HissUserInfoUtils.instance.initMyInfo();
  HissPigUtils.instance.initPigInfo();

  //b
  HissFkUtils.instance.initShumeng();
  HissConnectivityUtils.instance.initConnectivity();
  HissShowAdUtils.instance.initData();
  bHissGiftUtils.HissGiftUtils.instance.insertTodayGiftInfo();
  bHissRankUtils.HissRankUtils.instance.insertTodayRank();
  bHissUserInfoUtils.HissUserInfoUtils.instance.initMyInfo();
  bHissPigUtils.HissPigUtils.instance.initPigInfo();
  HissTaskQueueConfigUtils.instance.initBean();
  HissDailyTaskUtils.instance.initTodayDailyTask();
  HissHomeGiftUtils.instance.initGift();
  HissValueConfigUtils.instance.initBean();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (c,child)=>GetMaterialApp(
        title: 'HissSolitaire',
        enableLog: true,
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.system,
        initialRoute: HissCommonRouters.hissMain,
        debugShowCheckedModeBanner: false,
        getPages: hissCommonPageList+hissAAAPageList+hissBBBPageList,
        defaultTransition: Transition.rightToLeft,
      ),
    );
  }
}
