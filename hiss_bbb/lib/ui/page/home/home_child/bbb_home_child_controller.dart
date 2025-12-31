import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hiss_bbb/bean/hiss_cash_task_bean.dart';
import 'package:hiss_bbb/ui/dialog/cash_success_dialog/cash_success_dialog.dart';
import 'package:hiss_bbb/ui/dialog/cash_task_dialog/cash_task_dialog.dart';
import 'package:hiss_bbb/ui/dialog/first_reach_cash_money_dialog/first_reach_cash_money_dialog.dart';
import 'package:hiss_bbb/ui/dialog/good_comment/good_comment_dialog.dart';
import 'package:hiss_bbb/ui/dialog/input_account_dialog/input_account_dialog.dart';
import 'package:hiss_bbb/ui/dialog/money300_700_result_dialog/money300_700_result_dialog.dart';
import 'package:hiss_bbb/ui/dialog/money_300_700_animator_dialog/money_300_700_animator_dialog.dart';
import 'package:hiss_bbb/ui/dialog/money_card_reward_dialog/money_card_reward_dialog.dart';
import 'package:hiss_bbb/ui/dialog/no_money_dialog/no_money_dialog.dart';
import 'package:hiss_bbb/ui/dialog/play_success_dialog/play_success_dialog.dart';
import 'package:hiss_bbb/ui/dialog/spin_reward_dialog/spin_reward_dialog.dart';
import 'package:hiss_bbb/ui/dialog/spin_reward_task_dialog/spin_reward_task_dialog.dart';
import 'package:hiss_bbb/ui/dialog/verify_account_dialog/verify_account_dialog.dart';
import 'package:hiss_bbb/utils/hiss_b_routers.dart';
import 'package:hiss_bbb/utils/hiss_cash_task_utils.dart';
import 'package:hiss_bbb/utils/hiss_daily_task_utils.dart';
import 'package:hiss_bbb/utils/hiss_enum/hiss_cash_type.dart';
import 'package:hiss_bbb/utils/hiss_enum/hiss_gift_reward_task_type.dart';
import 'package:hiss_bbb/utils/hiss_enum/hiss_home_gift_type.dart';
import 'package:hiss_bbb/utils/hiss_enum/hiss_task_type.dart';
import 'package:hiss_bbb/utils/hiss_storage.dart';
import 'package:hiss_bbb/utils/hiss_task_queue_config_utils.dart';
import 'package:hiss_bbb/utils/hiss_user_info_utils.dart';
import 'package:hiss_bbb/utils/hiss_value_config_utils.dart';
import 'package:hiss_root/hiss_ui/dialog/open_notification_dialog/open_notification_dialog.dart';
import 'package:hiss_root/hiss_ui/hiss_root_controller.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_code.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_data.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_send_event_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';
import 'package:hiss_root/hiss_utils/hiss_fk/hiss_fk_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_local.dart';
import 'package:hiss_root/hiss_utils/hiss_mp3_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_point_enum.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_point_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_routers_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_utils.dart';
import 'package:hiss_root/hiss_utils/hudong/hiss_hudong_utils.dart';
import 'package:hiss_root/hiss_utils/hudong/hu_dong_url_bean.dart';

class BBBHomeChildController extends HissRootController{
  HuDongUrlBean? huDongUrlBean;

  @override
  void onReady() {
    super.onReady();
    _getHuDongUrl();
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
    // if(Platform.isIOS){
    //   IosHhh.instance.hiss4();
    // }
    var s = huDongUrlBean?.junior??"";
    if(s.isNotEmpty){
      var junior = huDongUrlBean?.point?.junior??"";
      if(junior.isNotEmpty){
        HissHudongUtils.instance.uploadClickData(junior);
      }
      HissRoutersUtils.instance.toWeb(title: "", url: s,);
    }
  }

  _getHuDongUrl()async{
    huDongUrlBean = await HissHudongUtils.instance.getHuDongUrl();
    var ideal = huDongUrlBean?.point?.ideal??"";
    if(ideal.isNotEmpty){
      HissHudongUtils.instance.uploadShowData(ideal);
    }
    update(["hudong"]);
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
    HissUserInfoUtils.instance.updateMoney(-2300);

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

    // print(decrypt(HissLocal.shumengEncryptKey, 134));
    // _getHuDongUrl();
    // HissFkUtils.instance.test();
  }
}