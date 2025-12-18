import 'package:hiss_bbb/ui/page/gift/hiss_gift_page.dart';
import 'package:hiss_bbb/ui/page/home/hiss_home_page.dart';
import 'package:hiss_bbb/ui/page/input_address/input_address_page.dart';
import 'package:hiss_bbb/ui/page/pig/hiss_pig_page.dart';
import 'package:hiss_bbb/ui/page/play/hiss_play_page.dart';
import 'package:hiss_bbb/ui/page/rank/hiss_rank_page.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';

class HissBBBRouters{
  static const String home="/b/home";
  static const String play="/b/play";
  static const String rank="/b/rank";
  static const String gift="/b/gift";
  static const String pig="/b/pig";
  static const String inputAddress="/b/inputAddress";
}

var hissBBBPageList=[
  GetPage(
      name: HissBBBRouters.home,
      page: ()=> HissHomePage(),
      transition: Transition.fadeIn
  ),
  GetPage(
      name: HissBBBRouters.play,
      page: ()=> HissPlayPage(),
      transition: Transition.fadeIn
  ),
  GetPage(
      name: HissBBBRouters.rank,
      page: ()=> HissRankPage(),
      transition: Transition.fadeIn
  ),
  GetPage(
      name: HissBBBRouters.gift,
      page: ()=> HissGiftPage(),
      transition: Transition.fadeIn
  ),
  GetPage(
      name: HissBBBRouters.pig,
      page: ()=> HissPigPage(),
      transition: Transition.fadeIn
  ),
  GetPage(
      name: HissBBBRouters.inputAddress,
      page: ()=> InputAddressPage(),
      transition: Transition.fadeIn
  ),
];