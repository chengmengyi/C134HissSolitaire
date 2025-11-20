import 'package:flutter/material.dart';
import 'package:hiss_aaa/test.dart';
import 'package:hiss_aaa/utils/hiss_a_routers.dart';
import 'package:hiss_root/hiss_ui/hiss_root_controller.dart';
import 'package:hiss_root/hiss_utils/hiss_routers_utils.dart';

class HissHomeController extends HissRootController{

  clickPlay(){
    Navigator.push(buildContext, MaterialPageRoute(builder: (_)=>SolitairePage()));
    // HissRoutersUtils.instance.toNextPageByNamed(routerName: HissAAARouters.play);
  }

  clickRank(){
    HissRoutersUtils.instance.toNextPageByNamed(routerName: HissAAARouters.rank);
  }
}