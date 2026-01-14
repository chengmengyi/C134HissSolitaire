import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hiss_bbb/utils/hiss_show_ad_utils.dart';
import 'package:hiss_bbb/utils/hiss_user_info_utils.dart';
import 'package:hiss_bbb/utils/hiss_value_config_utils.dart';
import 'package:hiss_root/hiss_ui/hiss_root_controller.dart';
import 'package:hiss_root/hiss_utils/hiss_ad_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_ad_enum.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_point_enum.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_point_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_routers_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_utils.dart';

class WheelDialogController extends HissRootController with GetSingleTickerProviderStateMixin{
  late AnimationController _wheelAnimationController;
  Animation<double>? wheelAnimation;
  late AnimationStatusListener _statusListener;

  var canClick=true,showBtn=false;
  int wheelReward=0;
  List<int> wheelList=HissValueConfigUtils.instance.getWheelRewardList();

  @override
  void onInit() {
    super.onInit();
    _initAnimator();
    HissPointUtils.instance.pointEvent(hissPointEnum: HissPointEnum.game_spin_pop);
  }

  @override
  void onReady() {
    super.onReady();
    clickSpin();
  }

  clickSpin()async{
    if(!canClick){
      return;
    }
    canClick=false;
    await Future.delayed(Duration(milliseconds: 1000));
    _wheelAnimationController..reset()..forward();
  }


  _initAnimator(){
    _wheelAnimationController=AnimationController(vsync: this,duration: const Duration(milliseconds: 2000));
    _statusListener=(status){
      if(status==AnimationStatus.completed){
        _spinEnd();
      }
    };
    _wheelAnimationController.addStatusListener(_statusListener);
    _initWheelRewardList();
  }

  _spinEnd()async{
    canClick=true;
    showBtn=true;
    update(["btn"]);
  }

  _initWheelRewardList(){
    wheelList.clear();
    while(wheelList.length<8){
      wheelList.add(Random().nextInt(50));
    }
    wheelList.shuffle();
    wheelReward=wheelList.random();
    var indexWhere = wheelList.indexWhere((value)=>value==wheelReward);
    var angle = 720-indexWhere*45;
    wheelAnimation=Tween<double>(begin: 0,end: (720+angle)*(pi/180)).animate(_wheelAnimationController);
  }

  clickGet(){
    HissPointUtils.instance.pointEvent(hissPointEnum: HissPointEnum.game_spin_c);
    HissAdUtils.instance.showBBBAd(
      adType: AdType.reward,
      hissAdEnum: HissAdEnum.ccqes_spin_rv,
      showAd: HissShowAdUtils.instance.showAd(AdType.reward),
      closeAdCallback: (give){
        if(give){
          HissUserInfoUtils.instance.updateMoney(wheelReward);
        }
        HissRoutersUtils.instance.close();
      },
    );
  }

  clickSingle(){
    HissPointUtils.instance.pointEvent(hissPointEnum: HissPointEnum.game_spin_close);
    HissAdUtils.instance.showBBBAd(
      adType: AdType.interstitial,
      hissAdEnum: HissAdEnum.ccqes_spin_int,
      showAd: HissShowAdUtils.instance.showAd(AdType.interstitial),
      closeAdCallback: (give){
        HissUserInfoUtils.instance.updateMoney(doubleDiv(wheelReward, 10));
        HissRoutersUtils.instance.close();
      },
    );
  }

  clickClose(){
    if(!canClick){
      return;
    }
    HissPointUtils.instance.pointEvent(hissPointEnum: HissPointEnum.game_spin_close);
    HissAdUtils.instance.showBBBAd(
      adType: AdType.interstitial,
      hissAdEnum: HissAdEnum.ccqes_spin_int,
      showAd: HissShowAdUtils.instance.showAd(AdType.interstitial),
      closeAdCallback: (give){
        HissRoutersUtils.instance.close();
      },
    );
  }

  @override
  void onClose() {
    _wheelAnimationController.removeStatusListener(_statusListener);
    _wheelAnimationController.dispose();
    super.onClose();
  }
}