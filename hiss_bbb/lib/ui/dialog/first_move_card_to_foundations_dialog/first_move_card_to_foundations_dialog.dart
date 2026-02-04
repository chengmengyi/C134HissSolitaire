import 'package:flutter/material.dart';
import 'package:hiss_bbb/ui/dialog/first_move_card_to_foundations_dialog/first_move_card_to_foundations_dialog_controller.dart';
import 'package:hiss_root/hiss_ui/hiss_root_dialog.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_click_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_gradient_text_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_images_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_text_widget.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';
import 'package:hiss_root/hiss_utils/hiss_utils.dart';

class FirstMoveCardToFoundationsDialog extends HissRootDialog<FirstMoveCardToFoundationsDialogController>{
  Function() callback;
  FirstMoveCardToFoundationsDialog({
    required this.callback,
});

  @override
  FirstMoveCardToFoundationsDialogController initGetController() => FirstMoveCardToFoundationsDialogController();

  @override
  Widget initContent() => Container(
    width: double.infinity,
    height: 384.h,
    margin: EdgeInsets.only(left: 20.w,right: 20.w),
    child: Stack(
      children: [
        HissImagesWidget(name: "first1", width: double.infinity, height: double.infinity),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: EdgeInsets.only(top: 40.h),
            child: HissGradientTextWidget(
              textContent: "Collect & Earn",
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              HissTextWidget(textContent: "Play cards and earn rewards.", textSize: 14.sp, textColor: "#724B2F".toColor()),
              SizedBox(height: 20.h,),
              Stack(
                children: [
                  HissImagesWidget(name: "first2", width: 52.w, height: 76.h),
                  Container(
                    margin: EdgeInsets.only(left: 12.w,top: 12.h),
                    child: HissImagesWidget(name: "first3", width: 52.w, height: 76.h),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 24.w,top: 24.h),
                    child: HissImagesWidget(name: "first4", width: 52.w, height: 76.h),
                  ),
                ],
              ),
              SizedBox(height: 20.h,),
              HissTextWidget(
                textContent: "+\$${controller.reward}",
                textSize: 28.sp,
                fontWeight: FontWeight.bold,
                textColor: "#FFD21D".toColor(),
                outlineColor: "#6E2F15".toColor(),
              ),
              SizedBox(height: 12.h,),
              HissClickWidget(
                onTap: (){
                  controller.clickClose(callback);
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    HissImagesWidget(name: "btn4", width: 180.w, height: 50.h),
                    HissTextWidget(textContent: "Claim AD-free", textSize: 18.sp, textColor: "#FFFFFF".toColor(),),
                  ],
                ),
              ),
              SizedBox(height: 24.h,),
            ],
          ),
        ),
        Positioned(
          top: 60.h,
          right: 24.w,
          child: HissClickWidget(
            onTap: (){
              controller.clickClose(callback);
            },
            child: HissImagesWidget(name: "icon_close2", width: 24.w, height: 24.w),
          ),
        )
      ],
    ),
  );
}