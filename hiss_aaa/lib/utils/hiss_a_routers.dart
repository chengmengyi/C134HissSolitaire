import 'package:hiss_aaa/ui/page/home/hiss_home_page.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';

class HissAAARouters{
  static const String home="/a/home";
}

var hissAAAPageList=[
  GetPage(
      name: HissAAARouters.home,
      page: ()=> HissHomePage(),
      transition: Transition.fadeIn
  ),
];