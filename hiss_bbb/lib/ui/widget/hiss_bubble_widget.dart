import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hiss_bbb/utils/hiss_cash_task_utils.dart';
import 'package:hiss_bbb/utils/hiss_daily_task_utils.dart';
import 'package:hiss_bbb/utils/hiss_enum/hiss_task_type.dart';
import 'package:hiss_bbb/utils/hiss_show_ad_utils.dart';
import 'package:hiss_bbb/utils/hiss_user_info_utils.dart';
import 'package:hiss_bbb/utils/hiss_value_config_utils.dart';
import 'package:hiss_root/hiss_ui/hiss_root_stateful.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_click_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_gradient_text_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_images_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_text_widget.dart';
import 'package:hiss_root/hiss_utils/hiss_ad_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_code.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_data.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_ad_enum.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_point_enum.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_point_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_utils.dart';

class HissBubbleWidget extends HissRootStateful{
  @override
  State<StatefulWidget> createState() =>_HissBubbleWidgetState();
}

class _HissBubbleWidgetState extends HissRootStatefulState<HissBubbleWidget>{
  double addNum=HissValueConfigUtils.instance.getBubbleAddNum();
  double maxWidth=375.w,currentX=0.0;
  double maxHeight=812.h,currentY=0.0;
  Timer? _timer;
  bool right=true,down=true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startTimer();
    });
  }

  @override
  initContent() => LayoutBuilder(
    builder: (c,bc){
      maxWidth=bc.maxWidth-64.w;
      maxHeight=bc.maxHeight-64.h;
      return SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Positioned(
              top: currentY,
              left: currentX,
              child: HissClickWidget(
                onTap: (){
                  _clickBubble();
                },
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    HissImagesWidget(name: "icon_bubble", width: 64.w, height: 64.w),
                    // HissGradientTextWidget(
                    //   textContent: "\$$addNum",
                    //   textSize: 14.sp,
                    //   fontWeight: FontWeight.bold,
                    //   gradient: LinearGradient(
                    //       begin: Alignment.topCenter,
                    //       end: Alignment.bottomCenter,
                    //       colors: ["#FFF132".toColor(),"#FFA806".toColor(),]
                    //   ),
                    //   outlineColor: "#FFFFFF".toColor(),
                    // ),
                    HissTextWidget(
                      textContent: "\$$addNum",
                      textSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      textColor: "#FFF132".toColor(),
                      outlineColor: "#000000".toColor(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    },
  );

  _startTimer(){
    _timer=Timer.periodic(const Duration(milliseconds: 15), (timer) {
      if(right){
        currentX++;
        if(down){
          currentY++;
          if(currentY>=maxHeight){
            down=false;
          }
        }else{
          currentY--;
          if(currentY<=0){
            down=true;
          }
        }
        if(currentX>=maxWidth){
          right=false;
        }
      }else{
        currentX--;
        if(down){
          currentY++;
          if(currentY>=maxHeight){
            down=false;
          }
        }else{
          currentY--;
          if(currentY<=0){
            down=true;
          }
        }
        if(currentX<=0){
          right=true;
        }
      }
      setState(() {});
    });
  }

  _clickBubble(){
    HissPointUtils.instance.pointEvent(hissPointEnum: HissPointEnum.bubble_c);
    HissAdUtils.instance.showBBBAd(
      adType: AdType.reward,
      hissAdEnum: HissAdEnum.ccqes_bubble_rv,
      showAd: HissShowAdUtils.instance.showAd(AdType.reward),
      closeAdCallback: (give){
        if(give){
          HissUserInfoUtils.instance.updateMoney(addNum);
          HissDailyTaskUtils.instance.updateDailyTaskProgress(HissTaskType.bubbles);
          HissCashTaskUtils.instance.updateCashTask(HissTaskType.bubbles);
        }
        setState(() {
          addNum=HissValueConfigUtils.instance.getBubbleAddNum();
        });
      },
    );
  }

  @override
  bool canReceivedEventData() => true;

  @override
  handleEventBusData(HissEventData data) {
    switch(data.eventCode){
      case HissEventCode.aUpdateMoneyNum:
        setState(() {
          addNum=HissValueConfigUtils.instance.getBubbleAddNum();
        });
        break;
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timer=null;
    super.dispose();
  }
}