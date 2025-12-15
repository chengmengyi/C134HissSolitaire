import 'package:flutter/material.dart';
import 'package:hiss_bbb/ui/dialog/cash_task_dialog/cash_task_dialog_controller.dart';
import 'package:hiss_root/hiss_ui/hiss_root_dialog.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_gradient_text_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_images_widget.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';
import 'package:hiss_root/hiss_utils/hiss_utils.dart';

class CashTaskDialog extends HissRootDialog<CashTaskDialogController>{

  @override
  CashTaskDialogController initGetController() => CashTaskDialogController();

  @override
  Widget initContent() => Container(
    width: double.infinity,
    height: 464.h,
    margin: EdgeInsets.only(left: 20.w,right: 20.w),
    child: Stack(
      children: [
        HissImagesWidget(name: "task1", width: double.infinity, height: 464.h,),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: EdgeInsets.only(top: 40.h),
            child: HissGradientTextWidget(
              textContent: "Human Verification",
              textSize: 20.sp,
              fontWeight: FontWeight.w900,
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
  );
}