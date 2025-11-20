import 'package:flutter/material.dart';
import 'package:hiss_aaa/ui/page/home/hiss_home_controller.dart';
import 'package:hiss_aaa/ui/widget/hiss_level_widget.dart';
import 'package:hiss_aaa/ui/widget/hiss_top_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_root_page.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_click_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_images_widget.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';

class HissHomePage extends HissRootPage<HissHomeController>{

  @override
  HissHomeController initGetController() => HissHomeController();

  @override
  Widget initContent() => Stack(
    children: [
      HissImagesWidget(name: "home2", width: double.infinity, height: double.infinity),
      HissTopWidget(),
      Align(
        alignment: Alignment.topCenter,
        child: Container(
          margin: EdgeInsets.only(top: 156.h),
          child: HissClickWidget(
            onTap: (){
              controller.test();
            },
            child: HissLevelWidget(),
          ),
        ),
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: EdgeInsets.only(bottom: 96.h),
          child: HissClickWidget(
            onTap: (){
              controller.clickPlay();
            },
            child: HissImagesWidget(name: "home4", width: 248.w, height: 84.h,),
          ),
        ),
      ),
      Positioned(
        top: 118.h,
        right: 10.w,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            HissClickWidget(
              onTap: (){
                controller.clickRank();
              },
              child: HissImagesWidget(name: "home5", width: 64.w, height: 64.w,),
            ),
          ],
        ),
      )
    ],
  );
}