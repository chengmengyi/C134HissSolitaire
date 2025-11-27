import 'package:flutter/material.dart';
import 'package:hiss_aaa/ui/widget/hiss_money_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_click_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_images_widget.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';

class HissTopWidget extends StatelessWidget{
  GlobalKey? moneyGlobalKey;
  HissTopWidget({
    this.moneyGlobalKey,
});

  @override
  Widget build(BuildContext context) => SizedBox(
    width: double.infinity,
    height: 90.h,
    child: Stack(
      alignment: Alignment.bottomCenter,
      children: [
        HissImagesWidget(name: "home1", width: double.infinity, height: double.infinity,),
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(left: 12.w,right: 12.w,bottom: 12.h),
          child: Row(
            children: [
              HissMoneyWidget(moneyGlobalKey: moneyGlobalKey,),
              Spacer(),
              HissClickWidget(
                child: HissImagesWidget(name: "icon_set", width: 28.w, height: 28.w,),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}