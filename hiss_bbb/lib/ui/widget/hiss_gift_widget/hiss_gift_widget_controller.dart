import 'dart:async';
import 'package:hiss_bbb/bean/hiss_gift_reward_task_bean.dart';
import 'package:hiss_bbb/bean/hiss_home_gift_progress_bean.dart';
import 'package:hiss_bbb/ui/dialog/spin_reward_dialog/spin_reward_dialog.dart';
import 'package:hiss_bbb/ui/dialog/spin_reward_task_dialog/spin_reward_task_dialog.dart';
import 'package:hiss_bbb/utils/hiss_cash_task_utils.dart';
import 'package:hiss_bbb/utils/hiss_enum/hiss_home_gift_type.dart';
import 'package:hiss_bbb/utils/hiss_enum/hiss_task_type.dart';
import 'package:hiss_bbb/utils/hiss_home_gift_utils.dart';
import 'package:hiss_bbb/utils/hiss_show_ad_utils.dart';
import 'package:hiss_bbb/utils/hiss_storage.dart';
import 'package:hiss_root/hiss_ui/hiss_root_controller.dart';
import 'package:hiss_root/hiss_utils/hiss_ad_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_code.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_data.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_ad_enum.dart';
import 'package:hiss_root/hiss_utils/hiss_routers_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_utils.dart';


class HissGiftWidgetController extends HissRootController{
  var selectedWheelIndex=-1;
  List<HissHomeGiftProgressBean> topGiftList=[];
  List<String> centerGiftTypeList=[];
  List<String> wheelList=[];
  Timer? _wheelTimer;

  HissGiftRewardTaskBean? hissGiftRewardTaskBean;
  Timer? _giftTaskRewardTimer;

  @override
  void onInit() {
    super.onInit();
    _initWheelList();
    _initCenterGiftTypeList();
  }

  @override
  void onReady() {
    super.onReady();
    _queryTopGiftList();
    _queryHasGiftTaskRewardData();
  }

  _queryTopGiftList()async{
    var list = await HissHomeGiftUtils.instance.queryGiftList();
    topGiftList.clear();
    topGiftList.addAll(list);
    topGiftList.addAll(list);
    topGiftList.addAll(list);
    topGiftList.addAll(list);
    topGiftList.addAll(list);
    topGiftList.addAll(list);
    update(["top_list"]);
  }

  clickTopGiftItem(HissHomeGiftProgressBean item){
    if((item.currentPro??0)>=(item.totalPro??0)){
      showSpinRewardTaskDialog(item.type);
    }
  }

  clickCenterGift(String type){
    HissAdUtils.instance.showBBBAd(
      adType: AdType.reward,
      hissAdEnum: HissAdEnum.ccqes_chip_rv,
      showAd: HissShowAdUtils.instance.showAd(AdType.reward),
      closeAdCallback: (give)async{
        if(give){
          HissCashTaskUtils.instance.updateCashTask(HissTaskType.puzzle);
          var progress = await HissHomeGiftUtils.instance.updateHomeGiftProgress(type);
          _updateTopGiftProgress(type,progress);
        }
      },
    );
  }

  _updateTopGiftProgress(String type,int progress)async{
    for (var value in topGiftList) {
      if(value.type==type){
        value.currentPro=progress;
      }
    }
    update(["top_list"]);
    var giftRewardTaskBean = await HissHomeGiftUtils.instance.queryGiftRewardTaskInfo(type);
    if(null!=giftRewardTaskBean){
      _queryHasGiftTaskRewardData();
      showSpinRewardTaskDialog(type);
    }
  }

  showSpinRewardTaskDialog(String? type){
    HissRoutersUtils.instance.showDialog(
      child: SpinRewardTaskDialog(
        rewardType: type,
      ),
    );
  }

  clickSpin(){
    _checkShowSpinAd(
      callback: (){
        _queryHasGiftTaskRewardData();
        if(null!=_wheelTimer){
          _stopWheelTimer();
          return;
        }
        var count=0;
        var randWheelIndex = _getRandWheelIndex();
        var pre3wheelIndex = _getPre3WheelIndex(randWheelIndex);
        _wheelTimer=Timer.periodic(Duration(milliseconds: 80), (t){
          if(count>=20&&pre3wheelIndex==selectedWheelIndex){
            _stopWheelTimer();
            _startWheelTimer2(randWheelIndex);
            return;
          }
          count++;
          selectedWheelIndex = _getNextWheelIndex();
          update(["wheel"]);
        });
      },
    );
  }

  _checkShowSpinAd({
    required Function() callback,
  }){
    if(wheelNum.getData()>0){
      callback.call();
      return;
    }
    HissAdUtils.instance.showBBBAd(
      adType: AdType.reward,
      hissAdEnum: HissAdEnum.ccqes_wheel_rv,
      showAd: HissShowAdUtils.instance.showAd(AdType.reward),
      closeAdCallback: (give){
        callback.call();
      },
    );
  }

  _startWheelTimer2(int randWheelIndex){
    var count=0;
    _wheelTimer=Timer.periodic(Duration(milliseconds: 200), (t){
      if(count>=3){
        _stopWheelTimer();
        _showWheelRewardDialog(randWheelIndex);
        return;
      }
      count++;
      selectedWheelIndex = _getNextWheelIndex();
      update(["wheel"]);
    });
  }

  _showWheelRewardDialog(int randWheelIndex)async{
    await Future.delayed(Duration(milliseconds: 500));
    var type = wheelList[randWheelIndex];
    HissRoutersUtils.instance.showDialog(
      child: SpinRewardDialog(
        type: type,
        receiveCallback: (progress){
          HissCashTaskUtils.instance.updateCashTask(HissTaskType.puzzle);
          _updateTopGiftProgress(type,progress);
        },
      ),
    );
  }

  int _getNextWheelIndex(){
    switch(selectedWheelIndex){
      case -1: return 0;
      case 0: return 1;
      case 1: return 2;
      case 2: return 3;
      case 3: return 7;
      case 4: return 0;
      case 5: return 4;
      case 6: return 5;
      case 7: return 6;
      default: return -1;
    }
  }

  int _getPre3WheelIndex(int index){
    switch(index){
      case -1: return 0;
      case 0: return 6;
      case 1: return 5;
      case 2: return 4;
      case 3: return 0;
      case 4: return 7;
      case 5: return 3;
      case 6: return 2;
      case 7: return 1;
      default: return -1;
    }
  }

  int _getRandWheelIndex(){
    while(true){
      String random = wheelList.random();
      var indexWhere = wheelList.indexWhere((value)=>value==random);
      if(wheelList[indexWhere].isNotEmpty){
        return indexWhere;
      }
    }
  }

  _stopWheelTimer(){
    _wheelTimer?.cancel();
    _wheelTimer=null;
  }

  _initCenterGiftTypeList(){
    centerGiftTypeList.clear();
    centerGiftTypeList.add(HissHomeGiftType.phone);
    centerGiftTypeList.add(HissHomeGiftType.package23);
    centerGiftTypeList.add(HissHomeGiftType.card);
    centerGiftTypeList.add(HissHomeGiftType.chuifengji);
    centerGiftTypeList.add(HissHomeGiftType.package2025);
    centerGiftTypeList.add(HissHomeGiftType.game);
    centerGiftTypeList.add(HissHomeGiftType.pay);
    centerGiftTypeList.shuffle();
  }

  _initWheelList(){
    wheelList.clear();
    wheelList.add(HissHomeGiftType.phone);
    wheelList.add(HissHomeGiftType.package23);
    wheelList.add(HissHomeGiftType.card);
    wheelList.add(HissHomeGiftType.chuifengji);
    wheelList.add(HissHomeGiftType.package2025);
    wheelList.add(HissHomeGiftType.game);
    wheelList.add(HissHomeGiftType.pay);
    wheelList.add("");
    wheelList.shuffle();
  }

  _queryHasGiftTaskRewardData()async{
    var list = await HissHomeGiftUtils.instance.queryHasTaskGiftReward();
    if(list.isNotEmpty){
      if(list.length==1){
        hissGiftRewardTaskBean=list.first;
        update(["top_right_view"]);
      }else{
        _giftTaskRewardTimer?.cancel();
        _giftTaskRewardTimer=Timer.periodic(Duration(milliseconds: 1000), (t){
          hissGiftRewardTaskBean=list.random();
          update(["top_right_view"]);
        });
      }
    }
  }

  @override
  bool canReceivedEventData() => true;

  @override
  handleEventBusData(HissEventData data) {
    switch(data.eventCode){
      case HissEventCode.updateWheelNum:
        update(["wheel_btn"]);
        break;
    }
  }

  @override
  void onClose() {
    _stopWheelTimer();
    _giftTaskRewardTimer?.cancel();
    _giftTaskRewardTimer=null;
    super.onClose();
  }
}