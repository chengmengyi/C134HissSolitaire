import 'package:flutter/material.dart';
import 'package:hiss_aaa/ui/page/gift/hiss_gift_controller.dart';
import 'package:hiss_root/hiss_ui/hiss_root_page.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_click_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_images_widget.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';

class HissGiftPage extends HissRootPage<HissGiftController>{
  @override
  HissGiftController initGetController() => HissGiftController();

  @override
  Widget initContent() => Stack(
    children: [
      Column(
        children: [
          HissImagesWidget(name: "gift1", width: double.infinity, height: 260.h),
          Expanded(
            child: Stack(
              children: [
                HissImagesWidget(name: "gift2", width: double.infinity, height: double.infinity,),
              ],
            ),
          ),
        ],
      ),
      Positioned(
        top: 52.h,
        right: 12.w,
        child: HissClickWidget(
          onTap: (){
            controller.clickClose();
          },
          child: HissImagesWidget(name: "icon_close", width: 28.w, height: 28.w),
        ),
      ),
    ],
  );
}