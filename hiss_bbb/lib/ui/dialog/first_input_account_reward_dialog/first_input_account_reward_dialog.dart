import 'package:flutter/material.dart';
import 'package:hiss_bbb/ui/dialog/first_input_account_reward_dialog/first_input_account_reward_dialog_controller.dart';
import 'package:hiss_bbb/ui/widget/hiss_breath_widget.dart';
import 'package:hiss_bbb/ui/widget/hiss_loop_rotate_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_root_dialog.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_click_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_gradient_text_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_images_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_text_widget.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';
import 'package:hiss_root/hiss_utils/hiss_utils.dart';

class FirstInputAccountRewardDialog extends HissRootDialog<FirstInputAccountRewardDialogController>{
  Function() callback;
  FirstInputAccountRewardDialog({
    required this.callback,
});

  @override
  FirstInputAccountRewardDialogController initGetController() => FirstInputAccountRewardDialogController();

  @override
  Widget initContent() => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          HissClickWidget(
            onTap: (){
              controller.clickClose(callback);
            },
            child: HissImagesWidget(name: "icon_close2", width: 24.w, height: 24.w),
          ),
          SizedBox(width: 16.w,),
        ],
      ),
      SizedBox(height: 16.h,),
      HissGradientTextWidget(
        textContent: "Player verification Complete",
        textSize: 32.sp,
        fontWeight: FontWeight.bold,
        textAlign: TextAlign.center,
        gradient: LinearGradient(
          colors: [
            "#FFFFFF".toColor(),
            "#FFE878".toColor(),
          ],
        ),
        outlineColor: "#895400".toColor(),
      ),
      SizedBox(height: 36.h,),
      Stack(
        alignment: Alignment.center,
        children: [
          HissLoopRotateWidget(
            child: HissImagesWidget(name: "first_reach3", width: 240.w, height: 240.w),
          ),
          HissBreathWidget(
            start: true,
            child: HissImagesWidget(name: "icon_money3", width: 200.w, height: 200.w),
          ),
        ],
      ),
      HissTextWidget(textContent: "\$100", textSize: 32.sp, textColor: "#FFD21D".toColor(),fontWeight: FontWeight.bold,),
      SizedBox(height: 8.h,),
      HissTextWidget(textContent: "Claim speed - up reward", textSize: 16.sp, textColor: "#FFFFFF".toColor()),
      SizedBox(height: 80.h,),
      HissClickWidget(
        onTap: (){
          controller.clickClaim(callback);
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            HissImagesWidget(name: "btn4", width: 200.w, height: 52.h),
            HissTextWidget(
              textContent: "Claim",
              textSize: 18.sp,
              fontWeight: FontWeight.bold,
              textColor: "#FFFFFF".toColor(),
              outlineColor: "#133D03".toColor(),
            ),
          ],
        ),
      )
    ],
  );

}