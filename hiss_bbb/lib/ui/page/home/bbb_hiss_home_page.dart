import 'package:flutter/material.dart';
import 'package:hiss_bbb/ui/page/home/bbb_hiss_home_controller.dart';
import 'package:hiss_bbb/ui/widget/hiss_home_bottom_tab_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_root_page.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_lottie_widget.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';

class BBBHissHomePage extends HissRootPage<BBBHissHomeController>{

  @override
  BBBHissHomeController initGetController() => BBBHissHomeController();

  @override
  Widget initContent() => Stack(
    children: [
      GetBuilder<BBBHissHomeController>(
        id: "page",
        builder: (_)=>IndexedStack(
          index: controller.tabIndex,
          children: controller.pageList,
        ),
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: HissHomeBottomTabWidget(
          initIndex: 1,
          clickCallback: (index){
            controller.clickIndex(index);
          },
        ),
      ),

      HissLottieWidget(name: "fire"),
    ],
  );
}