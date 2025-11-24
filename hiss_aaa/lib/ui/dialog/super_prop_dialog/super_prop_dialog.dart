import 'package:flutter/material.dart';
import 'package:hiss_aaa/ui/dialog/super_prop_dialog/super_prop_dialog_controller.dart';
import 'package:hiss_root/hiss_ui/hiss_root_dialog.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_click_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_images_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_text_widget.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';
import 'package:hiss_root/hiss_utils/hiss_utils.dart';

class SuperPropDialog extends HissRootDialog<SuperPropDialogController>{
  Function() claimCallback;
  Function() cancelCallback;
  SuperPropDialog({
    required this.claimCallback,
    required this.cancelCallback,
});

  @override
  SuperPropDialogController initGetController() => SuperPropDialogController();

  @override
  Widget initContent() => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      HissImagesWidget(name: "super1", width: 284.w, height: 136.h,),
      SizedBox(height: 12.h,),
      HissTextWidget(textContent: "Free For A Limited Time", textSize: 20.sp, textColor: "#FFFFFF".toColor(),fontWeight: FontWeight.bold,),
      SizedBox(height: 36.h,),
      HissImagesWidget(name: "super2", width: 200.w, height: 200.w),
      SizedBox(height: 28.h,),
      HissTextWidget(textContent: "Two Random Surprise", textSize: 16.sp, textColor: "#FFFFFF".toColor(),),
      SizedBox(height: 8.h,),
      HissTextWidget(textContent: "(It can be carried over to the next round)", textSize: 12.sp, textColor: "#8E8080".toColor(),),
      SizedBox(height: 34.h,),
      Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(width: 24.w,),
          HissClickWidget(
            onTap: (){
              controller.clickClose(cancelCallback);
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                HissImagesWidget(name: "btn3", width: 120.w, height: 52.h),
                HissTextWidget(
                  textContent: "No Need",
                  textSize: 18.sp,
                  textColor: "#FFFFFF".toColor(),
                  fontWeight: FontWeight.bold,
                  outlineColor: "#3D2703".toColor(),
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w,),
          Expanded(
            child: HissClickWidget(
              onTap: (){
                controller.clickClaim(claimCallback);
              },
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 15.h),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        HissImagesWidget(name: "btn4", width: double.infinity, height: 52.h),
                        HissTextWidget(
                          textContent: "Claim",
                          textSize: 18.sp,
                          textColor: "#FFFFFF".toColor(),
                          fontWeight: FontWeight.bold,
                          outlineColor: "#3D2703".toColor(),
                        ),
                      ],
                    ),
                  ),
                  HissImagesWidget(name: "icon_video", width: 32.w, height: 32.w,),
                ],
              ),
            ),
          ),
          SizedBox(width: 24.w,),
        ],
      ),
    ],
  );
}