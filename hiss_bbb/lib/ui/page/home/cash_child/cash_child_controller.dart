import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:hiss_bbb/bean/hiss_cash_list_bean.dart';
import 'package:hiss_bbb/bean/hiss_cash_rank_bean.dart';
import 'package:hiss_bbb/bean/hiss_rank_user_info_bean.dart';
import 'package:hiss_bbb/ui/dialog/cash_success_dialog/cash_success_dialog.dart';
import 'package:hiss_bbb/ui/dialog/cash_task_dialog/cash_task_dialog.dart';
import 'package:hiss_bbb/ui/dialog/input_account_dialog/input_account_dialog.dart';
import 'package:hiss_bbb/ui/dialog/no_money_dialog/no_money_dialog.dart';
import 'package:hiss_bbb/ui/dialog/verify_account_dialog/verify_account_dialog.dart';
import 'package:hiss_bbb/utils/hiss_cash_task_utils.dart';
import 'package:hiss_bbb/utils/hiss_enum/hiss_cash_type.dart';
import 'package:hiss_bbb/utils/hiss_storage.dart';
import 'package:hiss_bbb/utils/hiss_task_queue_config_utils.dart';
import 'package:hiss_bbb/utils/hiss_user_info_utils.dart';
import 'package:hiss_bbb/utils/hiss_value_config_utils.dart';
import 'package:hiss_root/hiss_ui/hiss_root_controller.dart';
import 'package:hiss_root/hiss_utils/hiss_ad_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_code.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_data.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_ad_enum.dart';
import 'package:hiss_root/hiss_utils/hiss_routers_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_utils.dart';

class CashChildController extends HissRootController{
  var cashType=cashTypeStorage.getData();
  List<HissCashListBean> cashList=[];

  @override
  void onReady() {
    super.onReady();
    _initCashList();
  }

  clickCashType(String cashType){
    if(this.cashType==cashType){
      return;
    }
    this.cashType=cashType;
    cashTypeStorage.saveData(cashType);
    update(["tab"]);
    _initCashList();
  }

  clickTopCash(){
    var indexWhere = cashList.indexWhere((value)=>null==value.cashRankBean&&null==value.cashTaskBean);
    if(indexWhere>=0){
      clickNormalItemCash(cashList[indexWhere]);
    }
  }

  //点击普通item的提现按钮
  clickNormalItemCash(HissCashListBean bean)async{
    if(bMoneyNum.getData()<bean.totalMoney){
      HissRoutersUtils.instance.showDialog(
        child: NoMoneyDialog(),
      );
      return;
    }
    var account = await HissCashTaskUtils.instance.queryAccount(cashType);
    if(account.isEmpty){
      HissRoutersUtils.instance.showDialog(
        child: InputAccountDialog(
          cashMoney: bean.totalMoney,
          callback: (){
            _inputAccountCallback(bean);
          },
        ),
      );
    }else{
      HissRoutersUtils.instance.showDialog(
        child: VerifyAccountDialog(
          cashMoney: bean.totalMoney,
          account: account,
          callback: (){
            _inputAccountCallback(bean);
          },
        ),
      );
    }
  }

  clickTaskItem(HissCashListBean bean)async{
    if(null==bean.cashTaskBean){
      return;
    }
    HissRoutersUtils.instance.showDialog(
      child: CashTaskDialog(
        cashTaskBean: bean.cashTaskBean,
      ),
    );
  }

  clickRankItem(HissCashListBean bean)async{
    if(null==bean.cashRankBean){
      return;
    }
    if(kDebugMode){
      _cashRankWatchVideoCompleted(bean);
      return;
    }
    HissAdUtils.instance.showBBBAd(
      adType: AdType.reward,
      hissAdEnum: HissAdEnum.ccqes_queue_rv,
      showAd: true,
      closeAdCallback: (give)async{
        if(give){
          _cashRankWatchVideoCompleted(bean);
        }
      },
    );
  }

  _cashRankWatchVideoCompleted(HissCashListBean bean)async{
    var cashRankBean = bean.cashRankBean;
    var hissCashRankBean = await HissCashTaskUtils.instance.updateCashRankInfo(cashRankBean?.cashType, cashRankBean?.cashMoney, HissTaskQueueConfigUtils.instance.getRandomRankReduceNum());
    if(null!=hissCashRankBean){
      if((hissCashRankBean.currentPro??0)<=1){
        HissRoutersUtils.instance.showDialog(
          child: CashSuccessDialog(
            callback: ()async{
              await HissCashTaskUtils.instance.deleteCashRankInfo(cashRankBean?.cashType, cashRankBean?.cashMoney);
            },
          ),
        );
      }else{
        var rankListInfo = await _initRankListInfo(hissCashRankBean);
        hissCashRankBean.userList=rankListInfo;
        bean.cashRankBean=hissCashRankBean;
        update(["list"]);
      }
    }
  }

  _inputAccountCallback(HissCashListBean bean)async{
    await HissCashTaskUtils.instance.createCashTask(cashType, bean.totalMoney);
    HissUserInfoUtils.instance.updateMoney(-(bean.totalMoney));
    var cashTaskBean = await HissCashTaskUtils.instance.queryCashTaskByCashTypeMoney(cashType, bean.totalMoney);
    HissRoutersUtils.instance.showDialog(
      child: CashTaskDialog(
        cashTaskBean: cashTaskBean,
      ),
    );
  }

  _initCashList()async{
    cashList.clear();
    for (var value in HissValueConfigUtils.instance.cashList()) {
      var cashTaskBean = await HissCashTaskUtils.instance.queryCashTaskByCashTypeMoney(cashType, value);
      var rankInfoBean = await HissCashTaskUtils.instance.queryCashRankInfoByCashTypeMoney(cashType, value);
      if(null!=rankInfoBean){
        var rankListInfo = await _initRankListInfo(rankInfoBean);
        rankInfoBean.userList=rankListInfo;
      }
      cashList.add(HissCashListBean(totalMoney: value,cashTaskBean: cashTaskBean,cashRankBean: rankInfoBean));
    }
    update(["list"]);
  }

  Future<List<HissRankUserInfoBean>> _initRankListInfo(HissCashRankBean rankInfoBean)async{
    List<HissRankUserInfoBean> list=[];
    for(var index=0;index<6;index++){
      list.add(HissRankUserInfoBean(account: "${_randomTwoLetters()}****.com", money: HissValueConfigUtils.instance.cashList().random(), isMe: false));
    }
    var account = await HissCashTaskUtils.instance.queryAccount(rankInfoBean.cashType);
    if(account.isEmpty){
      account="${_randomTwoLetters()}****.com";
    }
    var currentPro = rankInfoBean.currentPro??1;
    var meRankInfo = HissRankUserInfoBean(rank: currentPro,account: account, money: rankInfoBean.cashMoney??0, isMe: true,);
    if(currentPro<=3){
      list.insert(currentPro-1, meRankInfo);
    }else{
      list.insert(3, meRankInfo);
    }
    var indexWhere = list.indexWhere((value)=>value.isMe);
    for(var index=0;index<list.length;index++){
      var bean = list[index];
      if(index<indexWhere){
        bean.rank=currentPro-(indexWhere-index);
      }
      if(index>indexWhere){
        bean.rank=currentPro+(index-indexWhere);
      }
    }
    return list;
  }

  String _randomTwoLetters() {
    const letters = 'abcdefghijklmnopqrstuvwxyz';
    final random = Random();
    return String.fromCharCodes(List.generate(2, (_) => letters.codeUnitAt(random.nextInt(letters.length)),));
  }


  @override
  bool canReceivedEventData()  => true;

  @override
  handleEventBusData(HissEventData data) {
    switch(data.eventCode){
      case HissEventCode.aUpdateMoneyNum:
        update(["money","list"]);
        break;
      case HissEventCode.updateCashTypeTab:
        clickCashType(data.strEventValue??HissCashType.paypal);
        break;
      case HissEventCode.updateCashTaskInfo:
        _initCashList();
        break;
    }
  }
}