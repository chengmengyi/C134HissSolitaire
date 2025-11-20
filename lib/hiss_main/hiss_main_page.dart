import 'package:flutter/material.dart';
import 'package:hiss134/hiss_main/hiss_main_controller.dart';
import 'package:hiss_root/hiss_ui/hiss_root_page.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_images_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_text_widget.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';
import 'package:hiss_root/hiss_utils/hiss_utils.dart';

class HissMainPage extends HissRootPage<HissMainController>{

  @override
  HissMainController initGetController() => HissMainController();

  @override
  Widget initContent() => Stack(
    children: [
      HissImagesWidget(name: "main1", width: double.infinity, height: double.infinity),
      Align(
        alignment: Alignment.topCenter,
        child: Container(
          margin: EdgeInsets.only(top: 140.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              HissImagesWidget(name: "main2", width: 120.w, height: 120.w),
              SizedBox(height: 12.h,),
              HissTextWidget(
                textContent: "HissSolitaire",
                textSize: 20.sp,
                textColor: "#FFFFFF".toColor(),
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
        ),
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: EdgeInsets.only(bottom: 140.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              HissTextWidget(textContent: "Loading...", textSize: 14.sp, textColor: "#000000".toColor(),),
              SizedBox(height: 6.h,),
              Container(
                width: double.infinity,
                height: 24.h,
                padding: EdgeInsets.all(2.w),
                margin: EdgeInsets.only(left: 37.w,right: 37.w),
                decoration: BoxDecoration(
                  color: "#956721".toColor(),
                  border: Border.all(
                    width: 3.w,
                    color: "#D89822".toColor(),
                  ),
                  borderRadius: BorderRadius.circular(12.w),
                ),
                child: LayoutBuilder(
                  builder: (context,bc){
                    var maxWidth = bc.maxWidth;
                    return Container(
                      width: double.infinity,
                      height: 18.h,
                      alignment: Alignment.centerLeft,
                      child: GetBuilder<HissMainController>(
                        id: "progress",
                        builder: (_)=>Container(
                          width: maxWidth*controller.animationController.value,
                          height: 18.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.w),
                            color: "#79E211".toColor(),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}