import 'package:flutter/material.dart';
import 'package:hiss_aaa/utils/hiss_storage.dart';
import 'package:hiss_root/hiss_ui/hiss_root_stateful.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_images_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_text_widget.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_code.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_data.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';
import 'package:hiss_root/hiss_utils/hiss_utils.dart';

class HissMoneyWidget extends HissRootStateful{
  @override
  State<StatefulWidget> createState() => _HissMoneyWidgetState();
}

class _HissMoneyWidgetState extends HissRootStatefulState<HissMoneyWidget>{
  @override
  initContent() => Stack(
    alignment: Alignment.centerLeft,
    children: [
      Container(
        margin: EdgeInsets.only(left: 4.w),
        padding: EdgeInsets.only(left: 40.w,right: 28.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.w),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: ["#200505".toColor(),"#5A0C06".toColor(),]
          ),
        ),
        child: HissTextWidget(
          textContent: "${aMoneyNum.getData()}",
          textSize: 16.sp,
          textColor: "#FFFFFF".toColor(),
          fontWeight: FontWeight.w900,
        ),
      ),
      HissImagesWidget(name: "icon_money", width: 28.w, height: 28.w),
    ],
  );

  @override
  bool canReceivedEventData() => true;

  @override
  handleEventBusData(HissEventData data) {
    switch(data.eventCode){
      case HissEventCode.aUpdateMoneyNum:
        setState(() { });
        break;
    }
  }
}