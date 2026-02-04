import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hiss_bbb/ui/dialog/wheel_dialog/wheel_dialog_controller.dart';
import 'package:hiss_bbb/ui/widget/hiss_video_btn_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_root_dialog.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_click_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_images_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_text_widget.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';
import 'package:hiss_root/hiss_utils/hiss_utils.dart';

class WheelDialog extends HissRootDialog<WheelDialogController>{

  @override
  WheelDialogController initGetController() => WheelDialogController();

  @override
  Widget initContent() => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      _topWidget(),
      SizedBox(height: 20.h,),
      _wheelContentWidget(),
      SizedBox(height: 40.h,),
      _btnWidget(),
    ],
  );

  _wheelContentWidget()=>Container(
    margin: EdgeInsets.only(left: 20.w,right: 20.w),
    child: AspectRatio(
      aspectRatio: 1,
      child: Stack(
        alignment: Alignment.center,
        children: [
          LayoutBuilder(
            builder: (context,bc){
              var size = bc.maxWidth;
              var radius = (size / 2 - 30)*0.7;
              return Stack(
                children: [
                  AnimatedBuilder(
                    animation: controller.wheelAnimation!,
                    builder: (context,child)=>Transform.rotate(
                      angle: controller.wheelAnimation!.value,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          HissImagesWidget(name: "wheel2", width: double.infinity, height: double.infinity),
                          ...List.generate(
                            controller.wheelList.length, (i) =>
                              _wheelItemWidget(
                                money: controller.wheelList[i],
                                angleDeg: i * 45.0 - 90,
                                radius: radius,
                              ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: EdgeInsets.only(top: 20.h),
                      child: Image.asset("hiss_images/wheel_choose.webp",width: size/3,fit: BoxFit.fitWidth,),
                    ),
                  ),
                ],
              );
            },
          ),
          HissImagesWidget(name: "wheel3", width: 140.w, height: 140.w),
        ],
      ),
    ),
  );

  Widget _wheelItemWidget({
    required int money,
    required double angleDeg,
    required double radius,
  }) {
    final angleRad = angleDeg * pi / 180;
    final offset = Offset(
      radius * cos(angleRad),
      radius * sin(angleRad),
    );
    final textRotation = angleRad + pi / 2;
    return Transform.translate(
      offset: offset,
      child: Transform.rotate(
        angle: textRotation,
        child: HissTextWidget(
          textContent: "\$$money",
          textSize: 24.sp,
          fontWeight: FontWeight.bold,
          textColor: "#FFDF41".toColor(),
          outlineColor: "#000000".toColor(),
        ),
      ),
    );
  }


  _topWidget()=>Stack(
    alignment: Alignment.topRight,
    children: [
      HissImagesWidget(name: "wheel1", width: 320.w, height: 132.h),
      HissClickWidget(
        onTap: (){
          controller.clickClose();
        },
        child: HissImagesWidget(name: "icon_close2", width: 28.w, height: 28.w),
      )
    ],
  );
  
  _btnWidget()=>GetBuilder<WheelDialogController>(
    id: "btn",
    builder: (_)=>Visibility(
      visible: controller.showBtn,
      maintainAnimation: true,
      maintainState: true,
      maintainSize: true,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          HissVideoBtnWidget(
            text: "Get \$${controller.wheelReward}",
            bg: "btn4",
            width: 200.w,
            height: 52.h,
            onTap: (){
              controller.clickGet();
            },
          ),
          SizedBox(height: 12.h,),
          HissClickWidget(
            onTap: (){
              controller.clickSingle();
            },
            child: HissTextWidget(
              textContent: "\$${doubleDiv(controller.wheelReward, 10)}",
              textSize: 16.sp,
              textColor: "#FFFFFF".toColor(),
              decoration: TextDecoration.underline,
              decorationColor: "#FFFFFF".toColor(),
            ),
          ),
        ],
      ),
    ),
  );
}