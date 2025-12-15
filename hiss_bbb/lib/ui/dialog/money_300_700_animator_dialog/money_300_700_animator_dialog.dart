import 'package:flutter/material.dart';
import 'package:hiss_bbb/ui/dialog/money_300_700_animator_dialog/money_300_700_animator_dialog_controller.dart';
import 'package:hiss_root/hiss_ui/hiss_root_dialog.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_images_widget.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';

class Money300700AnimatorDialog extends HissRootDialog<Money300700AnimatorDialogController>{
  Function() dismissCallback;
  Money300700AnimatorDialog({
    required this.dismissCallback,
});

  @override
  Money300700AnimatorDialogController initGetController() => Money300700AnimatorDialogController(dismissCallback);

  @override
  Widget initContent() => Stack(
    alignment: Alignment.center,
    children: [
      HissImagesWidget(name: "money3001", width: double.infinity, height: double.infinity,),
      SlideTransition(
        position: controller.leftAnim,
        child: HissImagesWidget(name: "money3002", width: double.infinity, height: 210.h),
      ),
      SlideTransition(
        position: controller.rightAnim,
        child: Container(
          margin: EdgeInsets.only(left: 30.w,right: 30.w),
          child: HissImagesWidget(name: "money3003", width: double.infinity, height: 100.h),
        ),
      ),
    ],
  );
}