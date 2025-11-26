import 'package:flutter/material.dart';
import 'package:hiss_aaa/utils/hiss_storage.dart';
import 'package:hiss_root/hiss_ui/hiss_root_stateful.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_gradient_text_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_images_widget.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_code.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_data.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';
import 'package:hiss_root/hiss_utils/hiss_utils.dart';

class HissLevelWidget extends HissRootStateful{
  @override
  State<StatefulWidget> createState() => _HissLevelWidgetState();
}

class _HissLevelWidgetState extends HissRootStatefulState<HissLevelWidget>{
  @override
  initContent() => Stack(
    alignment: Alignment.center,
    children: [
      HissImagesWidget(name: "home3", width: 120.w, height: 44.h),
      HissGradientTextWidget(
        textContent: "LEVEL:${aLevel.getData()}",
        textSize: 18.sp,
        fontWeight: FontWeight.w900,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: ["#FFC400".toColor(),"#FFFFFF".toColor(),]
        ),
      ),
    ],
  );

  @override
  bool canReceivedEventData() => true;

  @override
  handleEventBusData(HissEventData data) {
    switch(data.eventCode){
      case HissEventCode.aUpdateLevel:
        setState(() {});
        break;
    }
  }
}