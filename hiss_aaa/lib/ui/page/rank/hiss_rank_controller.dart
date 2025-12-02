import 'package:flutter/material.dart';
import 'package:hiss_aaa/bean/hiss_rank_bean.dart';
import 'package:hiss_aaa/utils/hiss_rank_utils.dart';
import 'package:hiss_aaa/utils/hiss_storage.dart';
import 'package:hiss_aaa/utils/hiss_user_info_utils.dart';
import 'package:hiss_root/hiss_ui/hiss_root_controller.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';
import 'package:hiss_root/hiss_utils/hiss_routers_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_utils.dart';

class HissRankController extends HissRootController{
  HissRankBean? top1RankBean;
  HissRankBean? top2RankBean;
  HissRankBean? top3RankBean;
  HissRankBean? myRankBean;
  List<HissRankBean> otherRankList=[];
  ScrollController scrollController=ScrollController();
  var receivedRankReward=false;

  @override
  void onInit() {
    super.onInit();
    receivedRankReward=aReceivedRankRewardTime.getData()==getTodayTime();
    _initList();
  }

  clickClaim(HissRankBean bean){
    if(bean.isMe!=true||receivedRankReward||((bean.diamond??0)<=0)&&(bean.coins??0)<=0){
      return;
    }
    receivedRankReward=true;
    aReceivedRankRewardTime.saveData(getTodayTime());
    HissUserInfoUtils.instance.updateDiamondNum(bean.diamond??0);
    HissUserInfoUtils.instance.updateMoney(bean.coins??0);
    update(["list"]);
  }

  _initList()async{
    var list = await HissRankUtils.instance.queryTodayRankList();
    if(list.isNotEmpty){
      myRankBean=HissRankBean(name: aMyName.getData(),head: aMyHead.getData(),level: aLevel.getData());
      var indexWhere = list.indexWhere((value)=>(myRankBean?.level??0)>=(value.level??0));
      if(indexWhere>=0){
        var hissRankBean = list[indexWhere];
        hissRankBean.name=myRankBean?.name;
        hissRankBean.head=myRankBean?.head;
        hissRankBean.level=myRankBean?.level;
        hissRankBean.isMe=true;
        myRankBean=null;
      }
      top1RankBean=list.first;
      list.removeAt(0);
      if(list.isNotEmpty){
        top2RankBean=list.first;
        list.removeAt(0);
      }
      if(list.isNotEmpty){
        top3RankBean=list.first;
        list.removeAt(0);
      }
      otherRankList.clear();
      otherRankList.addAll(list);
      update(["top3","list","my_rank"]);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if(indexWhere>=4){
          scrollController.animateTo((64.h)*(indexWhere-4), duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
        }
      });
    }
  }

  clickClose(){
    HissRoutersUtils.instance.close();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}