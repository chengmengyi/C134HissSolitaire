import 'package:flutter/material.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_click_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_images_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_text_widget.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';
import 'package:hiss_root/hiss_utils/hiss_utils.dart';

class HissVideoBtnWidget extends StatelessWidget{
  String text;
  String bg;
  double width;
  double height;
  bool showVideoIcon;
  Function() onTap;
  HissVideoBtnWidget({
    required this.text,
    required this.bg,
    required this.width,
    required this.height,
    required this.onTap,
    this.showVideoIcon=true,
});

  @override
  Widget build(BuildContext context) => HissClickWidget(
    onTap: (){
      onTap.call();
    },
    child: Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
          margin: EdgeInsets.only(top: 10.h),
          child: Stack(
            alignment: Alignment.center,
            children: [
              HissImagesWidget(name: bg, width: width, height: height,),
              HissTextWidget(
                textContent: text,
                textSize: 18.sp,
                fontWeight: FontWeight.bold,
                textColor: "#FFFFFF".toColor(),
                outlineColor: "#133D03".toColor(),
              ),
            ],
          ),
        ),
        Visibility(
          visible: showVideoIcon,
          child: HissImagesWidget(name: "icon_video", width: 32.w, height: 32.w,),
        ),
      ],
    ),
  );
}