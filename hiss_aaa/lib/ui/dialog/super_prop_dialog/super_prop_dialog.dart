import 'package:flutter/material.dart';
import 'package:hiss_aaa/ui/dialog/super_prop_dialog/super_prop_dialog_controller.dart';
import 'package:hiss_root/hiss_ui/hiss_root_dialog.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_click_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_images_widget.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';

class SuperPropDialog extends HissRootDialog<SuperPropDialogController>{

  @override
  SuperPropDialogController initGetController() => SuperPropDialogController();

  @override
  Widget initContent() => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      HissImagesWidget(name: "super1", width: 284.w, height: 136.h,),
    ],
  );
}