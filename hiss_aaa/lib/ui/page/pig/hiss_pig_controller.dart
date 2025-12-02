import 'package:hiss_aaa/bean/hiss_pig_info_bean.dart';
import 'package:hiss_aaa/utils/hiss_enum/hiss_pig_type.dart';
import 'package:hiss_aaa/utils/hiss_enum/hiss_prop_type.dart';
import 'package:hiss_aaa/utils/hiss_pig_utils.dart';
import 'package:hiss_aaa/utils/hiss_storage.dart';
import 'package:hiss_aaa/utils/hiss_user_info_utils.dart';
import 'package:hiss_aaa/utils/utils.dart';
import 'package:hiss_root/hiss_ui/hiss_root_controller.dart';
import 'package:hiss_root/hiss_utils/hiss_ad_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';
import 'package:hiss_root/hiss_utils/hiss_routers_utils.dart';

class HissPigController extends HissRootController{
  var currentDiamondNum=0;
  HissPigInfoBean? lastPigBean;
  List<HissPigInfoBean> pigList=[];

  @override
  void onInit() {
    super.onInit();
    currentDiamondNum=countCurrentDiamond();
    _initList();
  }

  clickGet(){
    var indexWhere = pigList.indexWhere((value)=>value.status==HissPigStatus.unReceive);
    if(indexWhere<0){
      if(lastPigBean?.status==HissPigStatus.unReceive){
        _lookAd(lastPigBean);
      }
      return;
    }
    _lookAd(pigList[indexWhere]);
  }

  _lookAd(HissPigInfoBean? infoBean){
    HissAdUtils.instance.showAAAAd(
      adType: AdType.interstitial,
      closeAdCallback: (){
        _receiveReward(infoBean);
      },
    );
  }

  _receiveReward(HissPigInfoBean? infoBean)async{
    switch(infoBean?.type){
      case HissPigType.coins:
        HissUserInfoUtils.instance.updateMoney(infoBean?.addNum??0);
        break;
      case HissPigType.tips:
        HissUserInfoUtils.instance.updatePropNum(hissPropType: HissPropType.tips, addNum: infoBean?.addNum??0);
        break;
      case HissPigType.back:
        HissUserInfoUtils.instance.updatePropNum(hissPropType: HissPropType.back, addNum: infoBean?.addNum??0);
        break;
    }
    infoBean?.status=HissPigStatus.received;
    await HissPigUtils.instance.updateSinglePigInfo(infoBean);
    update(["list"]);
  }

  _initList()async{
    var list = await HissPigUtils.instance.queryPigInfo();
    if(list.isNotEmpty){
      for(var index=0;index<list.length;index++){
        var infoBean = list[index];
        if(currentDiamondNum>=(index+1)*10&&infoBean.status==HissPigStatus.lock){
          infoBean.status=HissPigStatus.unReceive;
        }
      }
      HissPigUtils.instance.updateAllPigInfo(list);
      lastPigBean=list.removeLast();
      if(list.isNotEmpty){
        pigList.addAll(list);
      }
      update(["list"]);
    }
  }

  double getPro(){
    var d = currentDiamondNum/100;
    if(d<0){
      return 0.0;
    }else if(d>1.0){
      return 1.0;
    }else{
      return d;
    }
  }

  String getItemBg(HissPigInfoBean? bean){
    switch(bean?.status){
      case HissPigStatus.unReceive: return "pig7";
      case HissPigStatus.received: return "pig6";
      case HissPigStatus.lock: return "pig8";
      default: return "pig6";
    }
  }

  String getItemIcon(HissPigInfoBean? bean){
    switch(bean?.type){
      case HissPigType.coins: return "icon_money2";
      case HissPigType.back: return "icon_back_prop";
      case HissPigType.tips: return "icon_tips_prop";
      default: return "icon_money2";
    }
  }

  String getDiamondIcon(){
    if(currentDiamondNum<=0){
      return "pig12";
    }else if(currentDiamondNum<=50){
      return "pig13";
    }else if(currentDiamondNum<=99){
      return "pig14";
    }else{
      return "pig15";
    }
  }

  clickClose(){
    HissRoutersUtils.instance.close();
  }
}