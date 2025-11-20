import 'package:flutter/material.dart';
import 'package:hiss_aaa/ui/page/play/hiss_play_controller.dart';
import 'package:hiss_aaa/ui/widget/hiss_super_prop_animator_widget.dart';
import 'package:hiss_aaa/ui/widget/hiss_top_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_root_page.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_click_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_gradient_text_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_images_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_text_widget.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';
import 'package:hiss_root/hiss_utils/hiss_utils.dart';

class HissPlayPage extends HissRootPage<HissPlayController>{
  @override
  HissPlayController initGetController() => HissPlayController();

  @override
  Widget initContent() => Stack(
    children: [
      HissImagesWidget(name: "play_bg", width: double.infinity, height: double.infinity),
      Column(
        children: [
          HissTopWidget(),
          _playInfoWidget(),
          Spacer(),
          _bottomWidget(),
        ],
      ),
      HissSuperPropAnimatorWidget(),
    ],
  );

  _playInfoWidget()=> Container(
    width: double.infinity,
    height: 72.h,
    margin: EdgeInsets.only(left: 12.w,right: 12.w,top: 20.h),
    child: Stack(
      children: [
        HissImagesWidget(name: "play1", width: double.infinity, height: double.infinity),
        Row(
          children: [
            SizedBox(width: 16.w,),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    HissGradientTextWidget(
                      textContent: "6",
                      textSize: 16.sp,
                      fontWeight: FontWeight.w900,
                      outlineColor: "#943D00".toColor(),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: ["#FFB62D".toColor(),"#FF5C05".toColor(),]
                      ),
                    ),
                    HissTextWidget(textContent: "Level", textSize: 12.sp, textColor: "#925B33".toColor(),),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    HissGradientTextWidget(
                      textContent: "6",
                      textSize: 16.sp,
                      fontWeight: FontWeight.w900,
                      outlineColor: "#943D00".toColor(),
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: ["#FFB62D".toColor(),"#FF5C05".toColor(),]
                      ),
                    ),
                    HissTextWidget(textContent: "Score", textSize: 12.sp, textColor: "#925B33".toColor(),),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    HissGradientTextWidget(
                      textContent: "11:11",
                      textSize: 16.sp,
                      fontWeight: FontWeight.w900,
                      outlineColor: "#943D00".toColor(),
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: ["#FFFFFF".toColor(),"#FFCD05".toColor(),]
                      ),
                    ),
                    HissTextWidget(textContent: "Time", textSize: 12.sp, textColor: "#925B33".toColor(),),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    HissGradientTextWidget(
                      textContent: "6",
                      textSize: 16.sp,
                      fontWeight: FontWeight.w900,
                      outlineColor: "#943D00".toColor(),
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: ["#FFB62D".toColor(),"#FF5C05".toColor(),]
                      ),
                    ),
                    HissTextWidget(textContent: "Move", textSize: 12.sp, textColor: "#925B33".toColor(),),
                  ],
                ),
              ),
            ),
            SizedBox(width: 16.w,),
          ],
        ),
      ],
    ),
  );

  _bottomWidget()=>Container(
    margin: EdgeInsets.only(left: 12.w,right: 12.w,bottom: 20.h,),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            HissClickWidget(
              child: HissImagesWidget(name: "play3", width: 72.w, height: 72.w),
            ),
            Spacer(),
            HissClickWidget(
              child: HissImagesWidget(name: "play4", width: 72.w, height: 72.w),
            ),
          ],
        ),
        SizedBox(height: 46.h,),
        Row(
          children: [
            HissClickWidget(
              onTap: (){
                controller.clickHome();
              },
              child: HissImagesWidget(name: "play5", width: 64.w, height: 64.w),
            ),
            Spacer(),
            HissClickWidget(
              child: HissImagesWidget(name: "play6", width: 56.w, height: 56.w),
            ),
            SizedBox(width: 22.w,),
            HissClickWidget(
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  HissImagesWidget(name: "play7", width: 56.w, height: 56.w),
                  HissImagesWidget(name: "play8", width: 16.w, height: 16.w),
                ],
              ),
            ),
            SizedBox(width: 22.w,),
            HissClickWidget(
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  HissImagesWidget(name: "play9", width: 56.w, height: 56.w),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      HissImagesWidget(name: "play10", width: 16.w, height: 16.w),
                      HissTextWidget(textContent: "1", textSize: 10.sp, textColor: "#FFFFFF".toColor(),fontWeight: FontWeight.bold,),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}