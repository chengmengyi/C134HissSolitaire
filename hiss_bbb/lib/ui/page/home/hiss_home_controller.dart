import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hiss_bbb/ui/dialog/add_prop_dialog/add_prop_dialog.dart';
import 'package:hiss_bbb/ui/dialog/play_success_dialog/play_success_dialog.dart';
import 'package:hiss_bbb/ui/dialog/random_prop_dialog/random_prop_dialog.dart';
import 'package:hiss_bbb/ui/dialog/set_dialog/set_dialog.dart';
import 'package:hiss_bbb/ui/dialog/super_prop_dialog/super_prop_dialog.dart';
import 'package:hiss_bbb/utils/hiss_b_routers.dart';
import 'package:hiss_bbb/utils/hiss_enum/hiss_prop_type.dart';
import 'package:hiss_bbb/utils/hiss_play_record_utils.dart';
import 'package:hiss_bbb/utils/hiss_storage.dart';
import 'package:hiss_root/hiss_ui/hiss_root_controller.dart';
import 'package:hiss_root/hiss_utils/hiss_mp3_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_routers_utils.dart';

class HissHomeController extends HissRootController{

  @override
  void onInit() {
    super.onInit();
    HissMp3Utils.instance.playBgm();
  }

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

    // HissRoutersUtils.instance.showDialog(child: SetDialog());
    // HissMp3Utils.instance.playOtherMp3(HissMp3Type.chupai);
    // aDiamondNum.saveData(aDiamondNum.getData()+10);
    bLevel.saveData(1);
  }
}