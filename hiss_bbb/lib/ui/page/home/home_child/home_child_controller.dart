import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hiss_bbb/utils/hiss_b_routers.dart';
import 'package:hiss_root/hiss_ui/hiss_root_controller.dart';
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
  }
}