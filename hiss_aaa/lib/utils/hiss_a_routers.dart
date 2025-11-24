import 'package:hiss_aaa/ui/page/gift/hiss_gift_page.dart';
import 'package:hiss_aaa/ui/page/home/hiss_home_page.dart';
import 'package:hiss_aaa/ui/page/play/hiss_play_page.dart';
import 'package:hiss_aaa/ui/page/rank/hiss_rank_page.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';

class HissAAARouters{
  static const String home="/a/home";
  static const String play="/a/play";
  static const String rank="/a/rank";
  static const String gift="/a/gift";
}

var hissAAAPageList=[
  GetPage(
      name: HissAAARouters.home,
      page: ()=> HissHomePage(),
      transition: Transition.fadeIn
  ),
  GetPage(
      name: HissAAARouters.play,
      page: ()=> HissPlayPage(),
      transition: Transition.fadeIn
  ),
  GetPage(
      name: HissAAARouters.rank,
      page: ()=> HissRankPage(),
      transition: Transition.fadeIn
  ),
  GetPage(
      name: HissAAARouters.gift,
      page: ()=> HissGiftPage(),
      transition: Transition.fadeIn
  ),
];