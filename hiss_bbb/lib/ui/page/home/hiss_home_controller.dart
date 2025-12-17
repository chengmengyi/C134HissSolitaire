import 'package:flutter/material.dart';
import 'package:hiss_bbb/ui/dialog/home_task_dialog/home_task_dialog.dart';
import 'package:hiss_bbb/ui/page/home/cash_child/cash_child.dart';
import 'package:hiss_bbb/ui/page/home/gift_child/gift_child.dart';
import 'package:hiss_bbb/ui/page/home/home_child/home_child.dart';
import 'package:hiss_root/hiss_ui/hiss_root_controller.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_code.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_data.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_send_event_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_mp3_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_routers_utils.dart';

class HissHomeController extends HissRootController{
  var tabIndex=1;
  List<Widget> pageList=[
    Container(),
    HomeChild(),
    GiftChild(),
    CashChild(),
  ];

  @override
  void onInit() {
    super.onInit();
    HissMp3Utils.instance.playBgm();
  }

  clickIndex(index){
    if(tabIndex==index){
      return;
    }
    if(index==0){
      HissRoutersUtils.instance.showDialog(
        child: HomeTaskDialog(
          clickIndexCallback: (index){
            HissSendEventUtils.instance.sendEvent(data: HissEventData(eventCode: HissEventCode.updateHomeBottomTab,intEventValue: index),);
            clickIndex(index);
          },
        ),
      );
      return;
    }
    tabIndex=index;
    update(["page"]);
  }

  @override
  bool canReceivedEventData() => true;

  @override
  handleEventBusData(HissEventData data) {
    switch(data.eventCode){
      case HissEventCode.showHomeTabIndex:
        clickIndex(data.intEventValue??1);
        break;
    }
  }
}