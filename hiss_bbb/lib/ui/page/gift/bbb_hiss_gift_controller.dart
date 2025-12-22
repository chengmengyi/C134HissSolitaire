import 'package:flutter/material.dart';
import 'package:hiss_bbb/bean/hiss_gift_bean.dart';
import 'package:hiss_bbb/utils/hiss_enum/hiss_gift_type.dart';
import 'package:hiss_bbb/utils/hiss_enum/hiss_prop_type.dart';
import 'package:hiss_bbb/utils/hiss_gift_utils.dart';
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

class BBBHissGiftController extends HissRootController{
  List<List<HissGiftBean>> giftList=[];

  @override
  void onInit() {
    super.onInit();
    HissPointUtils.instance.pointEvent(hissPointEnum: HissPointEnum.super_gift);
  }

  @override
  void onReady() {
    super.onReady();
    _initList();
  }

  clickClaim(HissGiftBean bean){
    if(bean.giftStatus!=HissGiftStatus.unReceive){
      return;
    }
    if(bean.showAd==1){
      HissPointUtils.instance.pointEvent(hissPointEnum: HissPointEnum.super_gift_adc);
      HissAdUtils.instance.showBBBAd(
        adType: AdType.reward,
        hissAdEnum: HissAdEnum.ccqes_gift_rv,
        showAd: HissShowAdUtils.instance.showAd(AdType.reward),
        closeAdCallback: (give){
          if(give){
            _addGift(bean);
          }
        },
      );
      return;
    }
    _addGift(bean);
  }

  _addGift(HissGiftBean bean)async{
    switch(bean.giftType){
      case HissGiftType.coins:
        HissUserInfoUtils.instance.updateMoney(bean.addNum??0,showAnimator: true);
        break;
      case HissGiftType.tips:
        HissUserInfoUtils.instance.updatePropNum(hissPropType: HissPropType.tips, addNum: bean.addNum??0);
        break;
      case HissGiftType.back:
        HissUserInfoUtils.instance.updatePropNum(hissPropType: HissPropType.back, addNum: bean.addNum??0);
        break;
      case HissGiftType.crystal:
        HissUserInfoUtils.instance.updateDiamondNum(bean.addNum??0);
        break;
    }
    await HissGiftUtils.instance.updateTodayGiftList(bean);
    _initList();
  }

  _initList()async{
    var list = await HissGiftUtils.instance.queryTodayGiftList();
    if(list.isNotEmpty){
      var giftRewardList = HissValueConfigUtils.instance.getGiftRewardList();
      var index=0;
      for (var value in list) {
        if(value.giftType!=HissGiftType.coins){
          continue;
        }
        if(index<giftRewardList.length){
          value.addNum=giftRewardList[index];
          index++;
        }
      }
      var reverseOdd = _splitAndReverseOdd(list,2);
      giftList.clear();
      giftList.addAll(reverseOdd);
      update(["list"]);
    }
  }

  List<List<T>> _splitAndReverseOdd<T>(List<T> list, int chunkSize) {
    List<List<T>> result = [];
    for (int i = 0; i < list.length; i += chunkSize) {
      int end = (i + chunkSize > list.length) ? list.length : i + chunkSize;
      var chunk = list.sublist(i, end);

      int index = i ~/ chunkSize;

      if (index.isOdd) {
        chunk = chunk.reversed.toList();
      }

      result.add(chunk);
    }

    return result;
  }

  String getItemRowLineBg(int largeIndex,List<HissGiftBean> list){
    if(largeIndex%2==0){
      var last = list.last;
      return last.giftStatus==HissGiftStatus.lock?"gift7":"gift6";
    }else{
      var last = list.first;
      return last.giftStatus==HissGiftStatus.lock?"gift7":"gift6";
    }
  }

  String getItemBg(HissGiftBean bean){
    switch(bean.giftStatus){
      case HissGiftStatus.lock: return "gift5";
      case HissGiftStatus.received: return "gift3";
      case HissGiftStatus.unReceive: return "gift4";
      default: return "gift4";
    }
  }

  String getItemGiftIcon(HissGiftBean bean){
    switch(bean.giftType){
      case HissGiftType.coins: return "icon_money3";
      case HissGiftType.crystal: return "icon_diamond";
      case HissGiftType.back: return "icon_back_prop";
      case HissGiftType.tips: return "icon_tips_prop";
      default: return "icon_money2";
    }
  }

  Color getItemTextColor(HissGiftBean bean){
    switch(bean.giftStatus){
      case HissGiftStatus.lock: return "#F8E9FF".toColor();
      case HissGiftStatus.received: return "#CCBDD3".toColor();
      case HissGiftStatus.unReceive: return "#FFD21D".toColor();
      default: return "#FFD21D".toColor();
    }
  }

  Color getItemTextLineColor(HissGiftBean bean){
    switch(bean.giftStatus){
      case HissGiftStatus.lock: return "#521B7D".toColor();
      case HissGiftStatus.received: return "#543F63".toColor();
      case HissGiftStatus.unReceive: return "#6E2F15".toColor();
      default: return "#FFD21D".toColor();
    }
  }

  bool showTopColLine(int largeIndex,int smallIndex){
    if(largeIndex==0){
      return false;
    }
    if(largeIndex%2==0){
      return smallIndex==0;
    }
    return smallIndex==1;
  }

  bool showBottomColLine(int largeIndex,int smallIndex,){
    if(largeIndex==giftList.length-1){
      return false;
    }
    if(largeIndex%2==0){
      return smallIndex==1;
    }
    return smallIndex==0;
  }

  String getTopColLineImages(int largeIndex){
    try{
      var list = giftList[largeIndex];
      var bean=largeIndex%2==0?list.first:list.last;
      return bean.giftStatus==HissGiftStatus.lock?"gift9":"gift8";
    }catch(e){
      return "gift8";
    }
  }

  String getBottomColLineImages(HissGiftBean bean){
    return bean.giftStatus==HissGiftStatus.lock?"gift9":"gift8";
  }

  clickClose(){
    HissRoutersUtils.instance.close();
  }
}