import 'package:flutter/material.dart';
import 'package:hiss_bbb/ui/dialog/no_money_dialog/no_money_dialog_controller.dart';
import 'package:hiss_root/hiss_ui/hiss_root_dialog.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_click_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_gradient_text_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_images_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_text_widget.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';
import 'package:hiss_root/hiss_utils/hiss_utils.dart';

class NoMoneyDialog extends HissRootDialog<NoMoneyDialogController>{

  @override
  NoMoneyDialogController initGetController() => NoMoneyDialogController();

  @override
  Widget initContent() => Container(
    width: double.infinity,
    height: 248.h,
    margin: EdgeInsets.only(left: 20.w,right: 20.w),
    child: Stack(
      children: [
        HissImagesWidget(name: "no_money_bg", width: double.infinity, height: 248.h),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: EdgeInsets.only(top: 30.h),
            child: HissGradientTextWidget(
              textContent: "Not enough to\nwithdraw yet",
              textSize: 20.sp,
              fontWeight: FontWeight.bold,
              outlineColor: "#01500C".toColor(),
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: ["#FFFFFF".toColor(),"#FFF290".toColor(),]
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.only(left: 48.w,right: 48.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                HissTextWidget(textContent: "Spin the lucky wheel and you might just win an iPhone 17", textSize: 14.sp, textColor: "#724B2F".toColor(),fontWeight: FontWeight.bold,),
                SizedBox(height: 20.h,),
                HissClickWidget(
                  onTap: (){
                    controller.clickSpin();
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      HissImagesWidget(name: "dialog_btn", width: 180.w, height: 48.h),
                      HissTextWidget(
                        textContent: "Spin Now",
                        textSize: 18.sp,
                        fontWeight: FontWeight.w900,
                        textColor: "#FFFFFF".toColor(),
                        outlineColor: "#133D03".toColor(),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h,),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}