import 'package:flutter/material.dart';
import 'package:hiss_bbb/ui/dialog/money_card_reward_dialog/money_card_reward_dialog_controller.dart';
import 'package:hiss_bbb/ui/widget/hiss_video_btn_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_root_dialog.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_click_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_images_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_text_widget.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';
import 'package:hiss_root/hiss_utils/hiss_utils.dart';

class MoneyCardRewardDialog extends HissRootDialog<MoneyCardRewardDialogController>{
  double reward;
  Function(double reward) callback;
  MoneyCardRewardDialog({
    required this.reward,
    required this.callback,
});

  @override
  MoneyCardRewardDialogController initGetController() => MoneyCardRewardDialogController();

  @override
  Widget initContent() => Stack(
    alignment: Alignment.topCenter,
    children: [
      HissImagesWidget(name: "money_card1", width: double.infinity, height: double.infinity),
      Column(
        children: [
          SizedBox(height: 92.h,),
          HissImagesWidget(name: "money_card5", width: 280.w, height: 140.h),
          Stack(
            alignment: Alignment.center,
            children: [
              HissImagesWidget(name: "money_card2", width: 240.w, height: 240.w),
              HissImagesWidget(name: "money_card3", width: 200.w, height: 200.w),
            ],
          ),
          HissTextWidget(
            textContent: "Wow, you’re so lucky! this reward \ngives you an extra \$$reward!",
            textSize: 16.sp,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.bold,
            textColor: "#FFFFFF".toColor(),
          ),
          SizedBox(height: 8.h,),
          HissTextWidget(
            textContent: "\$$reward",
            textSize: 32.sp,
            fontWeight: FontWeight.bold,
            textColor: "#FFD21D".toColor(),
            outlineColor: "#6E2F15".toColor(),
          ),
          SizedBox(height: 36.h,),
          HissVideoBtnWidget(
            text: "Claim",
            bg: "money_card4",
            width: 200.w,
            height: 52.h,
            onTap: (){
              controller.clickClaim(reward,callback);
            },
          ),
          SizedBox(height: 12.h,),
          HissClickWidget(
            onTap: (){
              controller.clickOnly(reward,callback);
            },
            child: HissTextWidget(
              textContent: "Only\$${controller.getOnlyReward(reward)}",
              textSize: 16.sp,
              fontWeight: FontWeight.bold,
              textColor: "#FFFFFF".toColor(),
              decoration: TextDecoration.underline,
              decorationColor: "#FFFFFF".toColor(),
            ),
          ),
        ],
      ),
    ],
  );
}