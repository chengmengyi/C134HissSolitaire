import 'package:flutter/material.dart';
import 'package:hiss_bbb/ui/dialog/first_reach_cash_money_dialog/first_reach_cash_money_dialog_controller.dart';
import 'package:hiss_bbb/utils/hiss_value_config_utils.dart';
import 'package:hiss_root/hiss_ui/hiss_root_dialog.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_click_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_images_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_text_widget.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';
import 'package:hiss_root/hiss_utils/hiss_utils.dart';

class FirstReachCashMoneyDialog extends HissRootDialog<FirstReachCashMoneyDialogController>{

  @override
  FirstReachCashMoneyDialogController initGetController() => FirstReachCashMoneyDialogController();

  @override
  Widget initContent() => Stack(
    alignment: Alignment.center,
    children: [
      HissImagesWidget(name: "first_reach1", width: double.infinity, height: double.infinity,),
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          HissImagesWidget(name: "first_reach2", width: 280.w, height: 128.h,),
          SizedBox(height: 16.h,),
          Stack(
            alignment: Alignment.center,
            children: [
              HissImagesWidget(name: "first_reach3", width: 240.w, height: 240.w),
              HissImagesWidget(name: "icon_money3", width: 200.w, height: 200.w),
            ],
          ),
          Container(
            margin: EdgeInsets.only(left: 38.w,right: 38.w),
            child: HissTextWidget(
              textContent: "Your effort has paid off! You've earned \$${HissValueConfigUtils.instance.cashList().first} and are ready to withdraw.",
              textSize: 16.sp,
              textColor: "#FFFFFF".toColor(),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 30.h,),
          HissClickWidget(
            onTap: (){
              controller.clickGoto();
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                HissImagesWidget(name: "first_reach4", width: 200.w, height: 50.h,),
                HissTextWidget(
                  textContent: "Go to",
                  textSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  textColor: "#FFFFFF".toColor(),
                  outlineColor: "#133D03".toColor(),
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h,),
          HissClickWidget(
            onTap: (){
              controller.clickClose();
            },
            child: HissTextWidget(
              textContent: "Later",
              textSize: 16.sp, 
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