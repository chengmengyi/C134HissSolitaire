import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hiss_aaa/test.dart';
import 'package:hiss_aaa/ui/dialog/add_prop_dialog/add_prop_dialog.dart';
import 'package:hiss_aaa/ui/dialog/play_success_dialog/play_success_dialog.dart';
import 'package:hiss_aaa/ui/dialog/random_prop_dialog/random_prop_dialog.dart';
import 'package:hiss_aaa/ui/dialog/set_dialog/set_dialog.dart';
import 'package:hiss_aaa/ui/dialog/super_prop_dialog/super_prop_dialog.dart';
import 'package:hiss_aaa/utils/hiss_a_routers.dart';
import 'package:hiss_aaa/utils/hiss_enum/hiss_prop_type.dart';
import 'package:hiss_aaa/utils/hiss_play_record_utils.dart';
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
    HissRoutersUtils.instance.toNextPageByNamed(routerName: HissAAARouters.play);
  }

  clickRank(){
    HissRoutersUtils.instance.toNextPageByNamed(routerName: HissAAARouters.rank);
  }

  clickGift(){
    HissRoutersUtils.instance.toNextPageByNamed(routerName: HissAAARouters.gift);
  }

  test()async{
    if(!kDebugMode){
      return;
    }

    // HissRoutersUtils.instance.showDialog(child: SetDialog());
    HissMp3Utils.instance.playOtherMp3(HissMp3Type.chupai);
  }
}