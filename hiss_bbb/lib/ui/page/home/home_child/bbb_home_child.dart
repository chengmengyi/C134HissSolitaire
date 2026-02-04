import 'package:flutter/material.dart';
import 'package:hiss_bbb/ui/page/home/home_child/bbb_home_child_controller.dart';
import 'package:hiss_bbb/ui/widget/hiss_bubble_widget.dart';
import 'package:hiss_bbb/ui/widget/hiss_level_widget.dart';
import 'package:hiss_bbb/ui/widget/hiss_pig_widget.dart';
import 'package:hiss_bbb/ui/widget/hiss_top_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_root_child.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_click_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_images_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_lottie_widget.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';

class BBBHomeChild extends HissRootChild<BBBHomeChildController>{
  @override
  BBBHomeChildController initGetController() => BBBHomeChildController();

  @override
  Widget initContent() => Stack(
    children: [
      HissImagesWidget(name: "home2", width: double.infinity, height: double.infinity),
      Align(
        alignment: Alignment.topCenter,
        child: Container(
          margin: EdgeInsets.only(top: 300.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              HissLottieWidget(name: "fire",width: 280.w,),
              HissImagesWidget(name: "home8", width: 200.w, height: 40.h),
            ],
          ),
        ),
      ),
      HissTopWidget(
        clickMoneyCallback: (){
          controller.clickTopMoney();
        },
        clickDiamondCallback: (){
          controller.clickPig();
        },
      ),
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
            SizedBox(height: 12.h,),
            HissClickWidget(
              onTap: (){
                controller.clickGift();
              },
              child: HissImagesWidget(name: "home6", width: 64.w, height: 64.w,),
            ),
          ],
        ),
      ),
      Positioned(
        left: 12.w,
        bottom: 210.h,
        child: HissPigWidget(
          clickCallback: (){
            controller.clickPig();
          },
        ),
      ),
      HissBubbleWidget(),
      // HissLottieWidget(name: "fire",width: 100,height: 100,)
    ],
  );
}