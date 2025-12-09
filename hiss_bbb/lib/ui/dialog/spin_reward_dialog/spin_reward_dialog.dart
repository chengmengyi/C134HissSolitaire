import 'package:flutter/material.dart';
import 'package:hiss_bbb/ui/dialog/spin_reward_dialog/spin_reward_dialog_controller.dart';
import 'package:hiss_bbb/ui/widget/hiss_video_btn_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_root_dialog.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_click_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_images_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_text_widget.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';
import 'package:hiss_root/hiss_utils/hiss_utils.dart';

class SpinRewardDialog extends HissRootDialog<SpinRewardDialogController>{
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
                  HissImagesWidget(name: "spin2", width: 240.w, height: 240.w,),
                  HissImagesWidget(name: "home_gift_pay", width: 200.w, height: 200.w,),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  HissTextWidget(
                    textContent: "iPhone 17 pro max ×1",
                    textSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    textColor: "#FFFFFF".toColor(),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 92.h,),
          HissVideoBtnWidget(
            text: "Receive",
            bg: "spin3",
            width: 200.w,
            height: 52.h,
            onTap: (){

            },
          ),
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