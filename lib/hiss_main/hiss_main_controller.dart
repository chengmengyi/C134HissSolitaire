import 'package:flutter/material.dart';
import 'package:hiss_aaa/utils/hiss_a_routers.dart';
import 'package:hiss_bbb/utils/hiss_b_routers.dart';
import 'package:hiss_root/hiss_ui/hiss_root_controller.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';
import 'package:hiss_root/hiss_utils/hiss_routers_utils.dart';

class HissMainController extends HissRootController with GetSingleTickerProviderStateMixin{
  late AnimationController animationController;

  @override
  void onInit() {
    super.onInit();
    animationController=AnimationController(duration: const Duration(seconds: 3),vsync: this);
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
    // HissRoutersUtils.instance.toNextPageCloseAllPage(routerName: HissAAARouters.home);
    HissRoutersUtils.instance.toNextPageCloseAllPage(routerName: HissBBBRouters.home);
  }
}