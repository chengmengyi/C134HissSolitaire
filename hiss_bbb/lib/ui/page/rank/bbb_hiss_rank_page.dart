import 'package:flutter/material.dart';
import 'package:hiss_bbb/bean/hiss_rank_bean.dart';
import 'package:hiss_bbb/ui/page/rank/bbb_hiss_rank_controller.dart';
import 'package:hiss_bbb/utils/hiss_storage.dart';
import 'package:hiss_root/hiss_ui/hiss_root_page.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_breath_animator_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_click_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_gradient_text_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_images_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_text_widget.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';
import 'package:hiss_root/hiss_utils/hiss_utils.dart';

class BBBHissRankPage extends HissRootPage<BBBHissRankController>{

  @override
  BBBHissRankController initGetController() => BBBHissRankController();

  @override
  Widget initContent() => Stack(
    children: [
      SizedBox(
        width: double.infinity,
        height: 300.h,
        child: Stack(
          children: [
            HissImagesWidget(name: "rank1", width: double.infinity, height: 300.h),
            Align(
              alignment: Alignment.center,
              child: _topWidget(),
            ),
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.only(top: 264.h),
        child: Stack(
          children: [
            HissImagesWidget(name: "rank2", width: double.infinity, height: double.infinity),
            _rankListWidget(),
          ],
        ),
      ),
      Positioned(
        top: 52.h,
        right: 12.w,
        child: HissClickWidget(
          onTap: (){
            controller.clickClose();
          },
          child: HissImagesWidget(name: "icon_close", width: 28.w, height: 28.w),
        ),
      ),
      _myRankItemWidget(),
    ],
  );

  _rankListWidget()=>Container(
    margin: EdgeInsets.only(top: 80.h,left: 12.w,right: 12.w,),
    child: Column(
      children: [
        Row(
          children: [
            SizedBox(width: 8.w,),
            HissGradientTextWidget(
              textContent: "Pank",
              textSize: 12.sp,
              fontWeight: FontWeight.bold,
              outlineColor: "#042319".toColor(),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: ["#FFFFFF".toColor(),"#FFF09C".toColor(),],
              ),
            ),
            SizedBox(width: 56.w,),
            HissGradientTextWidget(
              textContent: "Player",
              textSize: 12.sp,
              fontWeight: FontWeight.bold,
              outlineColor: "#042319".toColor(),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: ["#FFFFFF".toColor(),"#FFF09C".toColor(),],
              ),
            ),
            SizedBox(width: 104.w,),
            HissGradientTextWidget(
              textContent: "Rewards",
              textSize: 12.sp,
              fontWeight: FontWeight.bold,
              outlineColor: "#042319".toColor(),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: ["#FFFFFF".toColor(),"#FFF09C".toColor(),],
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h,),
        Expanded(
          child: MediaQuery.removePadding(
            context: buildContext,
            removeTop: true,
            removeBottom: true,
            child: GetBuilder<BBBHissRankController>(
              id: "list",
              builder: (_)=>ListView.builder(
                controller: controller.scrollController,
                itemCount: controller.otherRankList.length,
                itemBuilder: (context,index)=>_rankItemWidget(index,controller.otherRankList[index]),
              ),
            ),
          ),
        ),
      ],
    ),
  );

  _rankItemWidget(int index, HissRankBean bean)=>HissClickWidget(
    onTap: (){
      controller.clickClaim(bean);
    },
    child: Container(
      width: double.infinity,
      height: 64.h,
      margin: EdgeInsets.only(top: 4.h),
      child: Stack(
        children: [
          HissImagesWidget(name: bean.isMe==true?"rank10":"rank6", width: double.infinity, height: double.infinity,),
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    HissImagesWidget(name: bean.isMe==true?"rank11":"rank8", width: 44.w, height: 36.h),
                    Container(
                      margin: EdgeInsets.only(right: 12.w),
                      child: HissTextWidget(
                        textContent: "${index+4}",
                        textSize: 16.sp,
                        textColor: "#FFFFFF".toColor(),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 4.w,),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.w),
                  child: HissImagesWidget(name: bean.head??"head1", width: 40.w, height: 40.w),
                ),
                SizedBox(width: 8.w,),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HissTextWidget(
                        textContent: userNameStar(bean.name??""),
                        textSize: 14.sp,
                        textColor: "#FFFFFF".toColor(),
                        fontWeight: FontWeight.w900,
                      ),
                      SizedBox(height: 4.h,),
                      HissTextWidget(textContent: "Level:${bean.level??0}", textSize: 12.sp, textColor: "#F9C347".toColor(),fontWeight: FontWeight.bold,),
                    ],
                  ),
                ),
                HissBreathAnimatorWidget(
                  start: !controller.receivedRankReward&&bean.isMe==true&&(bean.diamond??0)>0,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      HissImagesWidget(name: "icon_diamond", width: 28.w, height: 28.w,),
                      SizedBox(width: 4.w,),
                      HissTextWidget(
                        textContent: "${bean.diamond??0}",
                        textSize: 14.sp,
                        textColor: "#FFFFFF".toColor(),
                        outlineColor: "#052B1F".toColor(),
                        fontWeight: FontWeight.w900,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 14.w,),
                HissBreathAnimatorWidget(
                  start: !controller.receivedRankReward&&bean.isMe==true&&(bean.coins??0)>0,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      HissImagesWidget(name: "icon_money3", width: 28.w, height: 28.w,),
                      SizedBox(width: 4.w,),
                      HissTextWidget(
                        textContent: "${bean.coins??0}",
                        textSize: 14.sp,
                        textColor: "#FFFFFF".toColor(),
                        outlineColor: "#052B1F".toColor(),
                        fontWeight: FontWeight.w900,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 14.w,),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Visibility(
              visible: bean.isMe==true,
              child: HissImagesWidget(name: controller.receivedRankReward?"rank13":"rank12", width: 44.w, height: 44.w),
            ),
          ),
        ],
      ),
    ),
  );

  _myRankItemWidget()=>Align(
    alignment: Alignment.bottomCenter,
    child: GetBuilder<BBBHissRankController>(
      id: "my_rank",
      builder: (_)=>Visibility(
        visible: null!=controller.myRankBean,
        child: Container(
          width: double.infinity,
          height: 64.h,
          margin: EdgeInsets.only(bottom: 60.h,left: 20.w,right: 20.w),
          child: Stack(
            children: [
              HissImagesWidget(name: "rank10", width: double.infinity, height: double.infinity,),
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        HissImagesWidget(name: "rank11", width: 44.w, height: 36.h),
                        Container(
                          margin: EdgeInsets.only(right: 12.w),
                          child: HissTextWidget(
                            textContent: "--",
                            textSize: 16.sp,
                            textColor: "#FFFFFF".toColor(),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 4.w,),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.w),
                      child: HissImagesWidget(name: bMyHead.getData(), width: 40.w, height: 40.w),
                    ),
                    SizedBox(width: 8.w,),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HissTextWidget(
                            textContent: userNameStar(bMyName.getData()),
                            textSize: 14.sp,
                            textColor: "#FFFFFF".toColor(),
                            fontWeight: FontWeight.w900,
                          ),
                          SizedBox(height: 4.h,),
                          HissTextWidget(textContent: "Level:${bLevel.getData()}", textSize: 12.sp, textColor: "#F9C347".toColor(),fontWeight: FontWeight.bold,),
                        ],
                      ),
                    ),
                    HissTextWidget(
                      textContent: "--",
                      textSize: 16.sp,
                      textColor: "#FFFFFF".toColor(),
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(width: 30.w,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );

  _topWidget()=>Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Stack(
        alignment: Alignment.topCenter,
        children: [
          HissImagesWidget(name: "rank3", width: 260.w, height: 136.h),
          Container(
            margin: EdgeInsets.only(top: 4.h),
            child: HissTextWidget(
              textContent: "2025.10.19",
              textSize: 12.sp,
              textColor: "#FFFFFF".toColor(),
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
      GetBuilder<BBBHissRankController>(
        id: "top3",
        builder: (_)=>Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _rankTop3ItemWidget(1,controller.top2RankBean),
            SizedBox(width: 12.w,),
            _rankTop3ItemWidget(0,controller.top1RankBean),
            SizedBox(width: 12.w,),
            _rankTop3ItemWidget(3,controller.top3RankBean),
          ],
        ),
      ),
    ],
  );

  _rankTop3ItemWidget(int index,HissRankBean? bean)=>Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Stack(
        alignment: Alignment.center,
        children: [
          Visibility(
            visible: null!=bean,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30.w),
              child: HissImagesWidget(name: bean?.head??"head1", width: 60.w, height: 60.w),
            ),
          ),
          HissImagesWidget(name: index==1?"rank4":index==0?"rank5":"rank9", width: 80.w, height: 80.w,),
        ],
      ),
      Visibility(
        visible: null!=bean,
        child: HissGradientTextWidget(
          textContent: bean?.name??"",
          textSize: 12.sp,
          fontWeight: FontWeight.bold,
          outlineColor: "#3A230F".toColor(),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: ["#FFFFFF".toColor(),"#FFE88C".toColor(),]
          ),
        ),
      ),
    ],
  );
}