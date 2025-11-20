import 'package:hiss134/hiss_main/hiss_main_page.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';

class HissCommonRouters{
  static const String hissMain="/common/hissMain";
  static const String hissUrl="/common/hissUrl";
}

var hissCommonPageList=[
  GetPage(
      name: HissCommonRouters.hissMain,
      page: ()=> HissMainPage(),
      transition: Transition.fadeIn
  ),
];