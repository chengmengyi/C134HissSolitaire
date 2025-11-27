import 'package:flutter/material.dart';
import 'package:hiss_aaa/ui/page/pig/hiss_pig_controller.dart';
import 'package:hiss_root/hiss_ui/hiss_root_page.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_images_widget.dart';

class HissPigPage extends HissRootPage<HissPigController>{

  @override
  HissPigController initGetController() => HissPigController();

  @override
  Widget initContent() => Stack(
    children: [
      HissImagesWidget(name: "pig1", width: double.infinity, height: double.infinity),
    ],
  );
}