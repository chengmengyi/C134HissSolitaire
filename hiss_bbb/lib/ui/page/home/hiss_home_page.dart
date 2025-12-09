import 'package:flutter/material.dart';
import 'package:hiss_bbb/ui/page/home/hiss_home_controller.dart';
import 'package:hiss_bbb/ui/widget/hiss_home_bottom_tab_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_root_page.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';

class HissHomePage extends HissRootPage<HissHomeController>{

  @override
  HissHomeController initGetController() => HissHomeController();

  @override
  Widget initContent() => Stack(
    children: [
      GetBuilder<HissHomeController>(
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
    ],
  );
}