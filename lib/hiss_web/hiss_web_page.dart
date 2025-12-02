import 'package:flutter/material.dart';
import 'package:hiss134/hiss_web/hiss_web_controller.dart';
import 'package:hiss_root/hiss_ui/hiss_root_page.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_click_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_gradient_text_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_images_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_text_widget.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';
import 'package:hiss_root/hiss_utils/hiss_routers_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_utils.dart';

class HissWebPage extends HissRootPage<HissWebController>{

  @override
  HissWebController initGetController() => HissWebController();

  @override
  Widget initContent() => Column(
    children: [
      SizedBox(
        width: double.infinity,
        height: 90.h,
        child: Stack(
          children: [
            HissImagesWidget(name: "home1", width: double.infinity, height: double.infinity,),
            Positioned(
              left: 12.w,
              bottom: 12.w,
              child: HissClickWidget(
                onTap: (){
                  HissRoutersUtils.instance.close();
                },
                child: HissImagesWidget(name: "icon_close", width: 28.w, height: 28.w),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: 12.h),
                child: HissGradientTextWidget(
                  textContent: controller.title,
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
          ],
        ),
      ),
      Expanded(child: WebViewWidget(controller: controller.controller)),
    ],
  );
}