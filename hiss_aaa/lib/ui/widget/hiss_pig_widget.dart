import 'package:flutter/material.dart';
import 'package:hiss_aaa/utils/hiss_a_routers.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_click_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_images_widget.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';
import 'package:hiss_root/hiss_utils/hiss_routers_utils.dart';

class HissPigWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) => HissClickWidget(
    onTap: (){
      HissRoutersUtils.instance.toNextPageByNamed(routerName: HissAAARouters.pig);
    },
    child: HissImagesWidget(name: "play3", width: 72.w, height: 72.w),
  );
}