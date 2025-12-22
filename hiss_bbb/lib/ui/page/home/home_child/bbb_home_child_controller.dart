import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hiss_bbb/ui/dialog/cash_success_dialog/cash_success_dialog.dart';
import 'package:hiss_bbb/ui/dialog/cash_task_dialog/cash_task_dialog.dart';
import 'package:hiss_bbb/ui/dialog/first_reach_cash_money_dialog/first_reach_cash_money_dialog.dart';
import 'package:hiss_bbb/ui/dialog/input_account_dialog/input_account_dialog.dart';
import 'package:hiss_bbb/ui/dialog/money300_700_result_dialog/money300_700_result_dialog.dart';
import 'package:hiss_bbb/ui/dialog/money_300_700_animator_dialog/money_300_700_animator_dialog.dart';
import 'package:hiss_bbb/ui/dialog/money_card_reward_dialog/money_card_reward_dialog.dart';
import 'package:hiss_bbb/ui/dialog/play_success_dialog/play_success_dialog.dart';
import 'package:hiss_bbb/ui/dialog/verify_account_dialog/verify_account_dialog.dart';
import 'package:hiss_bbb/utils/hiss_b_routers.dart';
import 'package:hiss_bbb/utils/hiss_cash_task_utils.dart';
import 'package:hiss_bbb/utils/hiss_daily_task_utils.dart';
import 'package:hiss_bbb/utils/hiss_enum/hiss_cash_type.dart';
import 'package:hiss_bbb/utils/hiss_enum/hiss_task_type.dart';
import 'package:hiss_bbb/utils/hiss_storage.dart';
import 'package:hiss_bbb/utils/hiss_task_queue_config_utils.dart';
import 'package:hiss_bbb/utils/hiss_user_info_utils.dart';
import 'package:hiss_bbb/utils/hiss_value_config_utils.dart';
import 'package:hiss_root/hiss_ui/dialog/open_notification_dialog/open_notification_dialog.dart';
import 'package:hiss_root/hiss_ui/hiss_root_controller.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_point_enum.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_point_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_routers_utils.dart';

class BBBHomeChildController extends HissRootController{
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

  clickGame(){
    if(Platform.isIOS){
      IosHhh.instance.hiss4();
    }
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

    HissRoutersUtils.instance.showDialog(
      child: OpenNotificationDialog(),
    );

    // HissDailyTaskUtils.instance.updateDailyTaskProgress(HissTaskType.game);
  }
}