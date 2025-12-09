import 'package:flutter/material.dart';
import 'package:hiss_bbb/ui/dialog/random_prop_dialog/random_prop_controller.dart';
import 'package:hiss_bbb/utils/hiss_enum/hiss_prop_type.dart';
import 'package:hiss_root/hiss_ui/hiss_root_dialog.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_click_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_images_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_text_widget.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';
import 'package:hiss_root/hiss_utils/hiss_utils.dart';

class RandomPropDialog extends HissRootDialog<RandomPropController>{
  Function(HissPropType propType) dismissCallback;
  RandomPropDialog({
    required this.dismissCallback,
});
  @override
  RandomPropController initGetController() => RandomPropController();

  @override
  Widget initContent() => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      HissImagesWidget(name: "random1", width: 284.w, height: 136.h),
      SizedBox(height: 50.h,),
      HissImagesWidget(name: "random2", width: 200.w, height: 200.w),
      SizedBox(height: 28.h,),
      Container(
        margin: EdgeInsets.only(left: 58.w,right: 58.w),
        child: HissTextWidget(textContent: "You’ve received a random power-up — use it now to boost your game and win bigger rewards!", textSize: 14.sp, textColor: "#FFFFFF".toColor(),),
      ),
      SizedBox(height: 46.h,),
      HissClickWidget(
        onTap: (){
          controller.clickGet(dismissCallback);
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            HissImagesWidget(name: "success3", width: 180.w, height: 48.h),
            HissTextWidget(
              textContent: "Get",
              textSize: 18.sp,
              textColor: "#FFFFFF".toColor(),
              outlineColor: "#133D03".toColor(),
              fontWeight: FontWeight.w900,
            ),
          ],
        ),
      ),
    ],
  );
}