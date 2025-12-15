import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hiss_bbb/ui/dialog/cash_success_dialog/cash_success_dialog.dart';
import 'package:hiss_bbb/ui/dialog/cash_task_dialog/cash_task_dialog.dart';
import 'package:hiss_bbb/ui/dialog/first_reach_cash_money_dialog/first_reach_cash_money_dialog.dart';
import 'package:hiss_bbb/ui/dialog/input_account_dialog/input_account_dialog.dart';
import 'package:hiss_bbb/ui/dialog/money300_700_result_dialog/money300_700_result_dialog.dart';
import 'package:hiss_bbb/ui/dialog/money_300_700_animator_dialog/money_300_700_animator_dialog.dart';
import 'package:hiss_bbb/ui/dialog/no_money_dialog/no_money_dialog.dart';
import 'package:hiss_bbb/ui/dialog/play_success_dialog/play_success_dialog.dart';
import 'package:hiss_bbb/ui/dialog/verify_account_dialog/verify_account_dialog.dart';
import 'package:hiss_bbb/utils/hiss_b_routers.dart';
import 'package:hiss_bbb/utils/hiss_daily_task_utils.dart';
import 'package:hiss_bbb/utils/hiss_enum/hiss_task_type.dart';
import 'package:hiss_bbb/utils/hiss_task_queue_config_utils.dart';
import 'package:hiss_root/hiss_ui/hiss_root_controller.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_point_enum.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_point_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_routers_utils.dart';

class HomeChildController extends HissRootController{
  clickPlay(){
    // Navigator.push(buildContext, MaterialPageRoute(builder: (_)=>SolitairePage()));
    HissRoutersUtils.instance.toNextPageByNamed(routerName: HissBBBRouters.play);
  }

  clickRank(){
    HissRoutersUtils.instance.toNextPageByNamed(routerName: HissBBBRouters.rank);
  }

  clickGift(){
    HissRoutersUtils.instance.toNextPageByNamed(routerName: HissBBBRouters.gift);
  }

  test()async{
    if(!kDebugMode){
      return;
    }
    // HissDailyTaskUtils.instance.updateDailyTaskProgress(HissTaskType.card);

    // HissRoutersUtils.instance.showDialog(
    //   child: NoMoneyDialog(),
    // );

    HissPointUtils.instance.pointEvent(hissPointEnum: HissPointEnum.ad_request);
  }
}