import 'package:hiss134/hiss_main/hiss_main_page.dart';
import 'package:hiss134/hiss_web/hiss_web_page.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';
import 'package:hiss_root/hiss_utils/hiss_routers_utils.dart';

var hissCommonPageList=[
  GetPage(
      name: HissCommonRouters.hissMain,
      page: ()=> HissMainPage(),
      transition: Transition.fadeIn
  ),
  GetPage(
      name: HissCommonRouters.hissUrl,
      page: ()=> HissWebPage(),
      transition: Transition.fadeIn
  ),
];