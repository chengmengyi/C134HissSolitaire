import 'package:flutter/material.dart';
import 'package:hiss_bbb/ui/dialog/cash_success_dialog/cash_success_dialog_controller.dart';
import 'package:hiss_root/hiss_ui/hiss_root_dialog.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_click_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_gradient_text_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_images_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_text_widget.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';
import 'package:hiss_root/hiss_utils/hiss_utils.dart';

class CashSuccessDialog extends HissRootDialog<CashSuccessDialogController>{

  @override
  CashSuccessDialogController initGetController() => CashSuccessDialogController();

  @override
  Widget initContent() => Container(
    width: double.infinity,
    height: 348.h,
    margin: EdgeInsets.only(left: 20.w,right: 20.w),
    child: Stack(
      children: [
        HissImagesWidget(name: "success_bg", width: double.infinity, height: 348.h,),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: EdgeInsets.only(top: 40.h),
            child: HissGradientTextWidget(
              textContent: "Application successful",
              textSize: 20.sp,
              fontWeight: FontWeight.w900,
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
                HissTextWidget(textContent: "7 working days after application. ", textSize: 14.sp, textColor: "#724B2F".toColor(),fontWeight: FontWeight.bold,),
                SizedBox(height: 40.h,),
                HissTextWidget(textContent: "A 1% fee applies per withdrawal. ", textSize: 14.sp, textColor: "#724B2F".toColor(),fontWeight: FontWeight.bold,),
                SizedBox(height: 40.h,),
                HissTextWidget(textContent: "Keep growing your wealth while you wait.", textSize: 14.sp, textColor: "#724B2F".toColor(),fontWeight: FontWeight.bold,),
                SizedBox(height: 20.h,),
                HissClickWidget(
                  onTap: (){
                    controller.clickOk();
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      HissImagesWidget(name: "dialog_btn", width: 180.w, height: 48.h),
                      HissTextWidget(
                        textContent: "OK",
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