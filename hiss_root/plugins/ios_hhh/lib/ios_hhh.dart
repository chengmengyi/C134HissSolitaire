
import 'dart:io';

import 'ios_hhh_platform_interface.dart';

class IosHhh {
  static final IosHhh _hhh=IosHhh();
  static IosHhh get instance => _hhh;

  //a包调用
  hiss1(){
    if(Platform.isAndroid){
      return;
    }
    IosHhhPlatform.instance.hiss1();
  }
  //b包调用
  hiss2(){
    if(Platform.isAndroid){
      return;
    }
    IosHhhPlatform.instance.hiss2();
  }
  //b包调用
  hiss3(){
    if(Platform.isAndroid){
      return;
    }
    IosHhhPlatform.instance.hiss3();
  }
  //跳h5
  hiss4(){
    if(Platform.isAndroid){
      return;
    }
    IosHhhPlatform.instance.hiss4();
  }
}
