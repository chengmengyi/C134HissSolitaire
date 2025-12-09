import 'package:flutter/material.dart';
import 'package:hiss_bbb/ui/dialog/spin_reward_task_dialog/spin_reward_task_dialog_controller.dart';
import 'package:hiss_root/hiss_ui/hiss_root_dialog.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_click_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_images_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_text_widget.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';
import 'package:hiss_root/hiss_utils/hiss_utils.dart';

class SpinRewardTaskDialog extends HissRootDialog<SpinRewardTaskDialogController>{

  @override
  SpinRewardTaskDialogController initGetController() => SpinRewardTaskDialogController();

  @override
  Widget initContent() => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      _topWidget(),
      SizedBox(height: 16.h,),
      _textWidget(),
    ],
  );
  
  _topWidget()=>SizedBox(
    width: double.infinity,
    height: 200.w,
    child: Stack(
      children: [
        Align(
          child: HissImagesWidget(name: "home_gift_pay", width: 200.w, height: 200.w,),
        ),
        Positioned(
          right: 16.w,
          child: HissClickWidget(
            onTap: (){
              controller.clickClose();
            },
            child: HissImagesWidget(name: "icon_close2", width: 24.w, height: 24.w,),
          ),
        ),
      ],
    ),
  );
  
  _textWidget()=>Container(
    margin: EdgeInsets.only(left: 36.w,right: 36.w,),
    child: HissTextWidget(
      textContent: "We appreciate your participation! Your gift will be shipped promptly. Finish specific tasks to fast-track the delivery!",
      textSize: 16.sp,
       textColor: "#FFFFFF".toColor(),
    ),
  );

  _progressWidget()=>SizedBox(
    width: 240.w,
    height: 24.w,
    child: Stack(
      children: [

      ],
    ),
  );
}