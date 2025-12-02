import 'package:flutter/material.dart';
import 'package:hiss_aaa/ui/dialog/set_dialog/set_dialog_controller.dart';
import 'package:hiss_root/hiss_ui/hiss_root_dialog.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_click_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_gradient_text_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_images_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_text_widget.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';
import 'package:hiss_root/hiss_utils/hiss_root_staorage.dart';
import 'package:hiss_root/hiss_utils/hiss_routers_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_utils.dart';

class SetDialog extends HissRootDialog<SetDialogController>{

  @override
  SetDialogController initGetController() => SetDialogController();

  @override
  Widget initContent() => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: double.infinity,
        height: 348.h,
        margin: EdgeInsets.only(left: 20.w,right: 20.w),
        child: Stack(
          children: [
            HissImagesWidget(name: "set1", width: double.infinity, height: double.infinity),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.only(top: 40.h),
                child: HissGradientTextWidget(
                  textContent: "Setting",
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
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GetBuilder<SetDialogController>(
                          id: "bgm",
                          builder: (_)=>HissClickWidget(
                            onTap: (){
                              controller.clickBgm();
                            },
                            child: HissImagesWidget(
                              name: playBgmKey.getData()?"icon_bg_open":"icon_bg_close",
                              width: 88.w,
                              height: 88.w,
                            ),
                          ),
                        ),
                        SizedBox(width: 20.w,),
                        GetBuilder<SetDialogController>(
                          id: "other",
                          builder: (_)=>HissClickWidget(
                            onTap: (){
                              controller.clickOther();
                            },
                            child: HissImagesWidget(
                              name: playOtherMp3Key.getData()?"icon_mp3_open":"icon_mp3_close",
                              width: 88.w,
                              height: 88.w,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h,),
                    HissClickWidget(
                      onTap: (){
                        controller.clickPrivacy();
                      },
                      child: Container(
                        width: double.infinity,
                        height: 52.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: "#E6C4A7".toColor(),
                          borderRadius: BorderRadius.circular(12.w),
                        ),
                        child: HissTextWidget(
                          textContent: "Privacy Policy",
                          textSize: 16.sp,
                          textColor: "#724B2F".toColor(),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // SizedBox(height: 8.h,),
                    // HissClickWidget(
                    //   onTap: (){
                    //
                    //   },
                    //   child: Container(
                    //     width: double.infinity,
                    //     height: 52.h,
                    //     alignment: Alignment.center,
                    //     decoration: BoxDecoration(
                    //       color: "#E6C4A7".toColor(),
                    //       borderRadius: BorderRadius.circular(12.w),
                    //     ),
                    //     child: HissTextWidget(
                    //       textContent: "Contact Us",
                    //       textSize: 16.sp,
                    //       textColor: "#724B2F".toColor(),
                    //       fontWeight: FontWeight.bold,
                    //     ),
                    //   ),
                    // ),
                    SizedBox(height: 24.h,),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 28.h,),
      HissClickWidget(
        onTap: (){
          HissRoutersUtils.instance.close();
        },
        child: HissImagesWidget(name: "icon_close", width: 28.w, height: 28.w),
      ),
    ],
  );
}