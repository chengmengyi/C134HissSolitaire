import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hiss_bbb/bean/hiss_play_grade_bean.dart';
import 'package:hiss_bbb/bean/hiss_play_record_bean.dart';
import 'package:hiss_bbb/utils/hiss_play_record_utils.dart';
import 'package:hiss_bbb/utils/hiss_user_info_utils.dart';
import 'package:hiss_bbb/utils/hiss_value_utils.dart';
import 'package:hiss_root/hiss_ui/hiss_root_controller.dart';
import 'package:hiss_root/hiss_utils/hiss_ad_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_routers_utils.dart';

class PlaySuccessController extends HissRootController{
  int score=0,time=0,step=0;
  List<HissPlayGradeBean> gradeList=[];
  GlobalKey scrollGlobalKey=GlobalKey();
  ScrollController scrollController=ScrollController();
  Timer? _scrollTimer;

  PlaySuccessController({
    required this.score,
    required this.time,
    required this.step,
});

  @override
  void onInit() {
    super.onInit();
    _initRecord();
  }

  @override
  void onReady() {
    super.onReady();
    _startScroll();
  }

  _startScroll(){
    _scrollTimer=Timer.periodic(Duration(milliseconds: 2000), (t){
      var renderBox = scrollGlobalKey.currentContext?.findRenderObject() as RenderBox;
      var height = renderBox.size.height;
      scrollController.animateTo(height, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    });
  }

  _initRecord()async{
    var currentRecordBean=HissPlayRecordBean(score: score,time: time,step: step,);
    var id = await HissPlayRecordUtils.instance.insertPlayRecord(score, time, step);
    var bestRecordBean = await HissPlayRecordUtils.instance.queryBestRecord(id);
    gradeList.add(HissPlayGradeBean(title: "Score", currentGrade: "${currentRecordBean.score}", bestGrade: "${bestRecordBean?.score??"--"}", currentIsBest: (currentRecordBean.score??0)>(bestRecordBean?.score??0)));
    gradeList.add(HissPlayGradeBean(title: "Time", currentGrade: "${currentRecordBean.time}", bestGrade: "${bestRecordBean?.time??"--"}", currentIsBest: (currentRecordBean.time??0)>(bestRecordBean?.time??0)));
    gradeList.add(HissPlayGradeBean(title: "Move", currentGrade: "${currentRecordBean.step}", bestGrade: "${bestRecordBean?.step??"--"}", currentIsBest: (currentRecordBean.step??0)>(bestRecordBean?.step??0)));
    update(["list"]);
  }

  clickOnly(){
    HissAdUtils.instance.showBBBAd(
      closeAdCallback: (give){

      }
    );
  }

  clickClaim(Function() dismissCallback){
    HissAdUtils.instance.showBBBAd(
        closeAdCallback: (give){

        }
    );
    HissUserInfoUtils.instance.updateMoney(HissValueUtils.instance.addMoneyNum());
    HissUserInfoUtils.instance.updateDiamondNum(HissValueUtils.instance.addDiamondNum());
    HissRoutersUtils.instance.close();
    dismissCallback.call();
  }

  @override
  void onClose() {
    _scrollTimer?.cancel();
    _scrollTimer=null;
    scrollController.dispose();
    super.onClose();
  }
}