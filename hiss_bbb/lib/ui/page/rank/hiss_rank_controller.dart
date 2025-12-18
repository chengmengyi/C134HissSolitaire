import 'package:flutter/material.dart';
import 'package:hiss_bbb/bean/hiss_rank_bean.dart';
import 'package:hiss_bbb/utils/hiss_daily_task_utils.dart';
import 'package:hiss_bbb/utils/hiss_enum/hiss_task_type.dart';
import 'package:hiss_bbb/utils/hiss_rank_utils.dart';
import 'package:hiss_bbb/utils/hiss_show_ad_utils.dart';
import 'package:hiss_bbb/utils/hiss_storage.dart';
import 'package:hiss_bbb/utils/hiss_user_info_utils.dart';
import 'package:hiss_root/hiss_ui/hiss_root_controller.dart';
import 'package:hiss_root/hiss_utils/hiss_ad_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_ad_enum.dart';
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
    receivedRankReward=bReceivedRankRewardTime.getData()==getTodayTime();
    _initList();
  }

  clickClaim(HissRankBean bean){
    if(bean.isMe!=true||receivedRankReward||((bean.diamond??0)<=0)&&(bean.coins??0)<=0){
      return;
    }
    HissAdUtils.instance.showBBBAd(
      adType: AdType.interstitial,
      hissAdEnum: HissAdEnum.ccqes_rank_int,
      showAd: HissShowAdUtils.instance.showAd(AdType.interstitial),
      closeAdCallback: (give){
        receivedRankReward=true;
        bReceivedRankRewardTime.saveData(getTodayTime());
        HissUserInfoUtils.instance.updateDiamondNum(bean.diamond??0);
        HissUserInfoUtils.instance.updateMoney(bean.coins??0);
        update(["list"]);
      },
    );
  }

  _initList()async{
    var list = await HissRankUtils.instance.queryTodayRankList();
    if(list.isNotEmpty){
      myRankBean=HissRankBean(name: bMyName.getData(),head: bMyHead.getData(),level: bLevel.getData());
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
      if(top1RankBean?.isMe==true){
        HissDailyTaskUtils.instance.updateDailyTaskProgress(HissTaskType.rank);
      }
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