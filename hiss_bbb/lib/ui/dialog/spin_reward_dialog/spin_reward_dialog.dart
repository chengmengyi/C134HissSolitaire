import 'package:flutter/material.dart';
import 'package:hiss_bbb/ui/dialog/spin_reward_dialog/spin_reward_dialog_controller.dart';
import 'package:hiss_bbb/ui/widget/hiss_breath_widget.dart';
import 'package:hiss_bbb/ui/widget/hiss_loop_rotate_widget.dart';
import 'package:hiss_bbb/ui/widget/hiss_video_btn_widget.dart';
import 'package:hiss_bbb/utils/utils.dart';
import 'package:hiss_root/hiss_ui/hiss_root_dialog.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_click_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_images_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_text_widget.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';
import 'package:hiss_root/hiss_utils/hiss_utils.dart';

class SpinRewardDialog extends HissRootDialog<SpinRewardDialogController>{
  String type;
  Function(int progress) receiveCallback;
  SpinRewardDialog({
    required this.type,
    required this.receiveCallback
});

  @override
  SpinRewardDialogController initGetController() => SpinRewardDialogController();

  @override
  Widget initContent() => Stack(
    children: [
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          HissImagesWidget(name: "spin1", width: 280.w, height: 136.h,),
          SizedBox(height: 30.h,),
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  HissLoopRotateWidget(
                    child: HissImagesWidget(name: "spin2", width: 240.w, height: 240.w,),
                  ),
                  HissBreathWidget(
                    start: true,
                    child: HissImagesWidget(name: getGiftIcon(type), width: 200.w, height: 200.w,),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  HissTextWidget(
                    textContent: getGiftName(type),
                    textSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    textColor: "#FFFFFF".toColor(),
                  ),
                  SizedBox(width: 10.w,),
                  HissTextWidget(
                    textContent: "x1",
                    textSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    textColor: "#FFFFFF".toColor(),
                  ),
                  HissImagesWidget(name: "icon_suipian", width: 16.w, height: 16.w,),
                ],
              ),
            ],
          ),
          SizedBox(height: 92.h,),
          HissClickWidget(
            onTap: (){
              controller.clickReceive(type,receiveCallback);
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                HissImagesWidget(name: "spin3", width: 200.w, height: 52.h),
                HissTextWidget(
                  textContent: "Receive",
                  textSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  textColor: "#FFFFFF".toColor(),
                  outlineColor: "#133D03".toColor(),
                ),
              ],
            ),
          ),
          // HissVideoBtnWidget(
          //   text: "Receive",
          //   bg: "spin3",
          //   width: 200.w,
          //   height: 52.h,
          //   onTap: (){
          //     controller.clickReceive(type,receiveCallback);
          //   },
          // ),
        ],
      ),
      Positioned(
        right: 16.w,
        child: HissClickWidget(
          onTap: (){
            controller.clickClose();
          },
          child: HissImagesWidget(name: "icon_close2", width: 24.w, height: 24.w,),
        ),
      ),
    ],
  );
}