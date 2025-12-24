import 'package:flutter/material.dart';
import 'package:hiss_bbb/ui/dialog/good_comment/good_comment_controller.dart';
import 'package:hiss_root/hiss_ui/hiss_root_dialog.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_click_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_images_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_text_widget.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';
import 'package:hiss_root/hiss_utils/hiss_utils.dart';

class GoodCommentDialog extends HissRootDialog<GoodCommentController>{
  Function() callback;
  GoodCommentDialog({
    required this.callback,
});

  @override
  GoodCommentController initGetController() => GoodCommentController();

  @override
  Widget initContent() => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      HissImagesWidget(name: "good5", width: 280.w, height: 156.h),
      SizedBox(height: 32.h,),
      HissImagesWidget(name: "good1", width: 200.w, height: 200.w),
      SizedBox(height: 20.h,),
      HissTextWidget(textContent: "Your encouragement makes us better!", textSize: 14.sp, textColor: "#FFFFFF".toColor(),),
      SizedBox(height: 26.h,),
      SizedBox(
        height: 52.w,
        child: GetBuilder<GoodCommentController>(
          id: "list",
          builder: (_)=>ListView.separated(
            shrinkWrap: true,
            itemCount: 5,
            scrollDirection: Axis.horizontal,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context,index)=>HissClickWidget(
              onTap: (){
                controller.clickItem(index);
              },
              child: HissImagesWidget(name: controller.index>=index?"good3":"good2", width: 52.w, height: 52.w,),
            ),
            separatorBuilder: (BuildContext context, int index) => SizedBox(width: 8.w,),
          ),
        ),
      ),
      SizedBox(height: 44.h,),
      HissClickWidget(
        onTap: (){
          controller.clickFeed(callback);
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            HissImagesWidget(name: "good4", width: 260.w, height: 52.h),
            HissTextWidget(
              textContent: "Feedback",
              textSize: 18.sp,
              fontWeight: FontWeight.bold,
              textColor: "#FFFFFF".toColor(),
              outlineColor: "#3D2703".toColor(),
            ),
          ],
        ),
      ),
    ],
  );
}