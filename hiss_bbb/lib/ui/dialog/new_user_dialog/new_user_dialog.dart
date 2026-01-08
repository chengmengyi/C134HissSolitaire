import 'package:flutter/material.dart';
import 'package:hiss_bbb/ui/dialog/new_user_dialog/new_user_dialog_controller.dart';
import 'package:hiss_root/hiss_ui/hiss_root_dialog.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_click_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_gradient_text_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_images_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_text_widget.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';
import 'package:hiss_root/hiss_utils/hiss_utils.dart';

class NewUserDialog extends HissRootDialog<NewUserDialogController>{
  Function() toPlayCallback;
  NewUserDialog({
    required this.toPlayCallback,
});

  @override
  NewUserDialogController initGetController() => NewUserDialogController();

  @override
  Widget initContent() => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      SizedBox(
        width: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: [
            HissGradientTextWidget(
              textContent: "How To Play And\nEarn Money",
              textSize: 28.sp,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.bold,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: ["#FFED87".toColor(),"#FFBA43".toColor(),"#FFED87".toColor()],
              ),
            ),
            Positioned(
              right: 16.w,
              child: HissClickWidget(
                onTap: (){
                  controller.clickClose();
                },
                child: HissImagesWidget(name: "icon_close2", width: 24.w, height: 24.w),
              ),
            )
          ],
        ),
      ),
      SizedBox(height: 24.h,),
      Container(
        margin: EdgeInsets.only(left: 20.w,right: 20.w),
        child: HissImagesWidget(name: "new_user_bg", width: double.infinity, height: 492.h),
      ),
      SizedBox(height: 12.h,),
      HissTextWidget(
        textContent: "Unlock withdraw,\nArrived Within 24 Hours",
        textSize: 16.sp,
        textAlign: TextAlign.center,
        textColor: "#FFFFFF".toColor(),
      ),
      SizedBox(height: 12.h,),
      HissClickWidget(
        onTap: (){
          controller.clickPlay(toPlayCallback);
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            HissImagesWidget(name: "btn4", width: 260.w, height: 50.h),
            HissTextWidget(textContent: "Collect & Earn", textSize: 18.sp, textColor: "#FFFFFF".toColor(),),
          ],
        ),
      ),
    ],
  );
}