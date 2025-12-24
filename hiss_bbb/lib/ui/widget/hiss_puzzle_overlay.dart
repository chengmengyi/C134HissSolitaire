import 'package:flutter/material.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_click_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_images_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_text_widget.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';
import 'package:hiss_root/hiss_utils/hiss_utils.dart';

class HissPuzzleOverlay extends StatelessWidget{
  Offset offset;
  Function() callback;
  HissPuzzleOverlay({
    required this.offset,
    required this.callback,
});

  @override
  Widget build(BuildContext context) => Material(
    type: MaterialType.transparency,
    child: HissClickWidget(
      onTap: (){
        callback.call();
      },
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black.withOpacity(0.7),
        child: Stack(
          children: [
            Positioned(
              top: offset.dy,
              left: offset.dx,
              child: HissImagesWidget(name: "play11", width: 72.w, height: 72.w,),
            ),
            Positioned(
              top: offset.dy-70.h,
              left: offset.dx+80.w,
              child: Stack(
                children: [
                  HissImagesWidget(name: "puzzle_guide", width: 220.w, height: 68.h),
                  Container(
                    width: 220.w,
                    height: 68.h,
                    padding: EdgeInsets.only(left: 10.w,right: 10.w,top: 10.h),
                    child: HissTextWidget(
                      textContent: "Receive a surprise gift puzzle",
                      textSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      textColor: "#FFFFFF".toColor(),
                      outlineColor: "#3D2603".toColor(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}