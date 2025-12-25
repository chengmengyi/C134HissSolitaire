import 'package:hiss_bbb/ui/page/cash_page/cash_page.dart';
import 'package:hiss_bbb/ui/page/gift/bbb_hiss_gift_page.dart';
import 'package:hiss_bbb/ui/page/home/bbb_hiss_home_page.dart';
import 'package:hiss_bbb/ui/page/input_address/bbb_input_address_page.dart';
import 'package:hiss_bbb/ui/page/pig/bbb_hiss_pig_page.dart';
import 'package:hiss_bbb/ui/page/play/bbb_hiss_play_page.dart';
import 'package:hiss_bbb/ui/page/rank/bbb_hiss_rank_page.dart';
import 'package:hiss_bbb/ui/page/wheel/bbb_wheel_page.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';

class HissBBBRouters{
  static const String home="/b/home";
  static const String play="/b/play";
  static const String rank="/b/rank";
  static const String gift="/b/gift";
  static const String pig="/b/pig";
  static const String inputAddress="/b/inputAddress";
  static const String wheel="/b/wheel";
  static const String cash="/b/cash";
}

var hissBBBPageList=[
  GetPage(
      name: HissBBBRouters.home,
      page: ()=> BBBHissHomePage(),
      transition: Transition.fadeIn
  ),
  GetPage(
      name: HissBBBRouters.play,
      page: ()=> BBBHissPlayPage(),
      transition: Transition.fadeIn
  ),
  GetPage(
      name: HissBBBRouters.rank,
      page: ()=> BBBHissRankPage(),
      transition: Transition.fadeIn
  ),
  GetPage(
      name: HissBBBRouters.gift,
      page: ()=> BBBHissGiftPage(),
      transition: Transition.fadeIn
  ),
  GetPage(
      name: HissBBBRouters.pig,
      page: ()=> BBBHissPigPage(),
      transition: Transition.fadeIn
  ),
  GetPage(
      name: HissBBBRouters.inputAddress,
      page: ()=> BBBInputAddressPage(),
      transition: Transition.fadeIn
  ),
  GetPage(
      name: HissBBBRouters.wheel,
      page: ()=> BBBWheelPage(),
      transition: Transition.fadeIn
  ),
  GetPage(
      name: HissBBBRouters.cash,
      page: ()=> CashPage(),
      transition: Transition.fadeIn
  ),
];