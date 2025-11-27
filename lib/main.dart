import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hiss134/hiss_common_router/hiss_common_routers.dart';
import 'package:hiss_aaa/utils/hiss_a_routers.dart';
import 'package:hiss_aaa/utils/hiss_gift_utils.dart';
import 'package:hiss_aaa/utils/hiss_rank_utils.dart';
import 'package:hiss_aaa/utils/hiss_user_info_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_app_life_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';

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
  HissAppLifeUtils.instance.addLife();

  //a
  HissGiftUtils.instance.insertTodayGiftInfo();
  HissRankUtils.instance.insertTodayRank();
  HissUserInfoUtils.instance.initMyInfo();

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
        getPages: hissCommonPageList+hissAAAPageList,
        defaultTransition: Transition.rightToLeft,
      ),
    );
  }
}
