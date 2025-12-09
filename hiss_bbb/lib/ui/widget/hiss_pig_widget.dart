import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hiss_bbb/utils/hiss_b_routers.dart';
import 'package:hiss_root/hiss_ui/hiss_root_stateful.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_click_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_images_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_text_widget.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_code.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_data.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';
import 'package:hiss_root/hiss_utils/hiss_routers_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_utils.dart';

class HissPigWidget extends HissRootStateful{
  Function()? clickCallback;
  HissPigWidget({
    this.clickCallback,
});
  @override
  State<StatefulWidget> createState() => _HissPigWidgetState();
}

class _HissPigWidgetState extends HissRootStatefulState<HissPigWidget>{
  var showGetTips=false;
  Timer? _timer;

  @override
  initContent() => Stack(
    alignment: Alignment.topRight,
    children: [
      Container(
        margin: EdgeInsets.only(top: 24.h),
        child: HissClickWidget(
          onTap: (){
            if(null==widget.clickCallback){
              HissRoutersUtils.instance.toNextPageByNamed(routerName: HissBBBRouters.pig);
            }else{
              widget.clickCallback?.call();
            }
          },
          child: HissImagesWidget(name: "play3", width: 72.w, height: 72.w),
        ),
      ),
      Visibility(
        visible: showGetTips,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            HissImagesWidget(name: "pig11", width: 48.w, height: 32.h),
            Container(
              margin: EdgeInsets.only(top: 6.h),
              child: HissTextWidget(
                textContent: "Get",
                textSize: 12.sp,
                fontWeight: FontWeight.bold,
                textColor: "#FFFFFF".toColor(),
                outlineColor: "#123D03".toColor(),
              ),
            ),
          ],
        ),
      ),
    ],
  );

  @override
  bool canReceivedEventData() => true;

  @override
  handleEventBusData(HissEventData data) {
    switch(data.eventCode){
      case HissEventCode.aShowPigBtnTips:
        _showPigBtnTips();
        break;
    }
  }

  _showPigBtnTips(){
    setState(() {
      showGetTips=true;
    });
    _timer?.cancel();
    _timer=Timer(Duration(milliseconds: 1000), (){
      setState(() {
        showGetTips=false;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}