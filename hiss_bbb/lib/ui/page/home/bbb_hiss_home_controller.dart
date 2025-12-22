import 'package:flutter/material.dart';
import 'package:hiss_bbb/ui/dialog/home_task_dialog/home_task_dialog.dart';
import 'package:hiss_bbb/ui/page/home/cash_child/bbb_cash_child.dart';
import 'package:hiss_bbb/ui/page/home/gift_child/bbb_gift_child.dart';
import 'package:hiss_bbb/ui/page/home/home_child/bbb_home_child.dart';
import 'package:hiss_bbb/utils/hiss_money_overlay_utils.dart';
import 'package:hiss_root/hiss_ui/hiss_root_controller.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_code.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_data.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_send_event_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';
import 'package:hiss_root/hiss_utils/hiss_ios_notification_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_mp3_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_point_enum.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_point_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_routers_utils.dart';

class BBBHissHomeController extends HissRootController{
  var tabIndex=1;
  List<Widget> pageList=[
    Container(),
    BBBHomeChild(),
    BBBGiftChild(),
    BBBCashChild(),
  ];

  @override
  void onInit() {
    super.onInit();
    HissMp3Utils.instance.playBgm();
    HissPointUtils.instance.pointEvent(hissPointEnum: HissPointEnum.user_source,params: {"from":"b"});
    HissPointUtils.instance.pointEvent(hissPointEnum: HissPointEnum.home_page);
    HissIosNotificationUtils.instance.init();
    IosHhh.instance.hiss2();
    IosHhh.instance.hiss3();
  }

  @override
  void onReady() {
    super.onReady();
    HissMoneyOverlayUtils.instance.setContext(buildContext);
  }

  clickIndex(index){
    if(tabIndex==index){
      return;
    }
    if(index==0){
      HissPointUtils.instance.pointEvent(hissPointEnum: HissPointEnum.home_task);
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
    if(index==1){
      HissPointUtils.instance.pointEvent(hissPointEnum: HissPointEnum.home_page);
    }
    if(index==2){
      HissPointUtils.instance.pointEvent(hissPointEnum: HissPointEnum.gift_page);
    }
    if(index==3){
      HissPointUtils.instance.pointEvent(hissPointEnum: HissPointEnum.cash_page);
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