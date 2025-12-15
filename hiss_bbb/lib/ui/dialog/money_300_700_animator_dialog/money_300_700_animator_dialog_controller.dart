import 'package:flutter/material.dart';
import 'package:hiss_root/hiss_ui/hiss_root_controller.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';
import 'package:hiss_root/hiss_utils/hiss_routers_utils.dart';

class Money300700AnimatorDialogController extends HissRootController with GetSingleTickerProviderStateMixin{
  late AnimationController controller;
  late Animation<Offset> leftAnim;
  late Animation<Offset> rightAnim;
  late Function() dismissCallback;

  Money300700AnimatorDialogController(this.dismissCallback);

  @override
  void onInit() {
    super.onInit();
    _initAnimator();
  }

  _initAnimator()async{
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    // 左图从屏幕左外到中间
    leftAnim = Tween<Offset>(
      begin: const Offset(-1.2, 0), // 屏幕左边外
      end: const Offset(0, 0),      // 中间
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeOut,
    ));

    // 右图从屏幕右外到中间
    rightAnim = Tween<Offset>(
      begin: const Offset(1.2, 0),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeOut,
    ));

    // 自动开始
    controller.forward();
    await Future.delayed(Duration(milliseconds: 1500));
    HissRoutersUtils.instance.close();
    dismissCallback.call();
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}