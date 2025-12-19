import 'package:flutter/material.dart';
import 'package:hiss_bbb/ui/page/wheel/bbb_wheel_controller.dart';
import 'package:hiss_bbb/ui/widget/hiss_gift_widget/hiss_gift_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_root_page.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_click_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_images_widget.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';

class BBBWheelPage extends HissRootPage<BBBWheelController>{

  @override
  BBBWheelController initGetController() => BBBWheelController();

  @override
  Widget initContent() => Stack(
    children: [
      HissGiftWidget(tagStr: "wheel_page"),
      Positioned(
        left: 16.w,
        child: SafeArea(
          child: HissClickWidget(
            onTap: (){
              controller.clickClose();
            },
            child: HissImagesWidget(name: "icon_close", width: 32.w, height: 32.w),
          ),
        ),
      ),
    ],
  );
}