import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hiss_aaa/utils/hiss_a_routers.dart';
import 'package:hiss_bbb/utils/hiss_b_routers.dart';
import 'package:hiss_root/hiss_ui/hiss_root_controller.dart';
import 'package:hiss_root/hiss_utils/hiss_ad_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_check_user_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_ad_enum.dart';
import 'package:hiss_root/hiss_utils/hiss_routers_utils.dart';

class HissMainController extends HissRootController with GetSingleTickerProviderStateMixin{
  late AnimationController animationController;

  @override
  void onInit() {
    super.onInit();
    animationController=AnimationController(duration: const Duration(seconds: 12),vsync: this);
    animationController.addListener(() {
      update(["progress"]);
    });
    animationController.addStatusListener((status) {
      if(status==AnimationStatus.completed){
        _animatorCompleted();
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
    animationController.forward();
  }

  _animatorCompleted(){
    var user = HissCheckUserUtils.instance.getUser();
    if(user){
      HissAdUtils.instance.showBBBAd(
        adType: AdType.interstitial,
        hissAdEnum: HissAdEnum.ccqes_launch,
        showAd: true,
        isOpen: !kDebugMode,
        closeAdCallback: (give){
          _toHomePage(HissBBBRouters.home);
        },
      );
    }else{
      _toHomePage(HissAAARouters.home);
    }
  }

  _toHomePage(String routerName){
    HissRoutersUtils.instance.toNextPageCloseAllPage(routerName: routerName);
  }
}