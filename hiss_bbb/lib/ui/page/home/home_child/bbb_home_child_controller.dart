import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:hiss_bbb/ui/dialog/new_user_dialog/new_user_dialog.dart';
import 'package:hiss_bbb/ui/dialog/play_success_dialog/play_success_dialog.dart';
import 'package:hiss_bbb/ui/dialog/wheel_dialog/wheel_dialog.dart';
import 'package:hiss_bbb/utils/hiss_b_routers.dart';
import 'package:hiss_bbb/utils/hiss_storage.dart';
import 'package:hiss_root/hiss_ui/hiss_root_controller.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_code.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_data.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_send_event_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_point_enum.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_point_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_routers_utils.dart';

class BBBHomeChildController extends HissRootController{

  @override
  void onReady() {
    super.onReady();
    _showNewUserDialog();
  }

  clickPlay(){
    HissPointUtils.instance.pointEvent(hissPointEnum: HissPointEnum.home_play);
    HissRoutersUtils.instance.toNextPageByNamed(routerName: HissBBBRouters.play);
  }

  clickRank(){
    HissRoutersUtils.instance.toNextPageByNamed(routerName: HissBBBRouters.rank);
  }

  clickGift(){
    HissRoutersUtils.instance.toNextPageByNamed(routerName: HissBBBRouters.gift);
  }

  clickTopMoney(){
    HissSendEventUtils.instance.sendEvent(data: HissEventData(eventCode: HissEventCode.showHomeTabIndex,intEventValue: 3));
  }

  clickPig(){
    HissRoutersUtils.instance.toNextPageByNamed(routerName: HissBBBRouters.pig);
  }

  clickGame(){
    if(Platform.isIOS){
      IosHhh.instance.hiss4();
    }
  }

  _showNewUserDialog(){
    if(!newUser.getData()){
      return;
    }
    newUser.saveData(false);
    HissRoutersUtils.instance.showDialog(
      child: NewUserDialog(
        toPlayCallback: (){
          clickPlay();
        },
      ),
    );
  }


  test()async{
    if(!kDebugMode){
      return;
    }
    // HissDailyTaskUtils.instance.updateDailyTaskProgress(HissTaskType.card);

    // HissRoutersUtils.instance.showDialog(
    //   child: NoMoneyDialog(),
    // );
    // HissValueConfigUtils.instance.initBean();
    // HissUserInfoUtils.instance.updateMoney(100);

    // HissCashTaskUtils.instance.updateCashTask(HissTaskType.puzzle);

    // HissDailyTaskUtils.instance.updateDailyTaskProgress(HissTaskType.game);

    // HissCashTaskUtils.instance.updateCashTask(HissTaskType.bubbles);
    // HissRoutersUtils.instance.toNextPageByNamed(routerName: HissBBBRouters.inputAddress);

    // HissRoutersUtils.instance.showDialog(
    //   child: PlaySuccessDialog(time: 100, step: 100, score: 100, dismissCallback: (){}),
    // );

    // HissDailyTaskUtils.instance.updateDailyTaskProgress(HissTaskType.game);
    // HissMp3Utils.instance.playOtherMp3(HissMp3Type.puzzle);
    // bLevel.saveData(1);
    // HissUserInfoUtils.instance.updateUserLevel();
    // bLevel.saveData(1);
    // HissCashTaskUtils.instance.updateCashTask(HissTaskType.puzzle);
    // HissUserInfoUtils.instance.updateWheelNum(1);

    // HissMp3Utils.instance.playOtherMp3(HissMp3Type.zhuan);

    // HissRoutersUtils.instance.showDialog(child: FirstReachCashMoneyDialog());
    // HissValueConfigUtils.instance.test();
    // bLevel.saveData(1);

    HissRoutersUtils.instance.showDialog(
      child: PlaySuccessDialog(time: 100, step: 100, score: 100, dismissCallback: (){}),
    );
  }
}