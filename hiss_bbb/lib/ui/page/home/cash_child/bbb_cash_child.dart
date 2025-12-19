import 'package:flutter/material.dart';
import 'package:hiss_bbb/bean/hiss_cash_list_bean.dart';
import 'package:hiss_bbb/ui/page/home/cash_child/bbb_cash_child_controller.dart';
import 'package:hiss_bbb/utils/hiss_enum/hiss_cash_type.dart';
import 'package:hiss_bbb/utils/hiss_storage.dart';
import 'package:hiss_bbb/utils/hiss_task_queue_config_utils.dart';
import 'package:hiss_bbb/utils/utils.dart';
import 'package:hiss_root/hiss_ui/hiss_root_child.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_click_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_gradient_text_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_images_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_text_widget.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';
import 'package:hiss_root/hiss_utils/hiss_utils.dart';

class BBBCashChild extends HissRootChild<BBBCashChildController>{
  @override
  BBBCashChildController initGetController() => BBBCashChildController();

  @override
  Widget initContent() => Stack(
    children: [
      HissImagesWidget(name: "cash1", width: double.infinity, height: double.infinity,),
      _moneyWidget(),
      _cashBtnWidget(),
      _titleWidget(),
      _tabWidget(),
      _contentWidget(),
    ],
  );

  _moneyWidget()=>Positioned(
    left: 28.w,
    top: 120.h,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HissTextWidget(
          textContent: "Balance",
          textSize: 16.sp,
          fontWeight: FontWeight.bold,
          textColor: "#FFE075".toColor(),
        ),
        GetBuilder<BBBCashChildController>(
          id: "money",
          builder: (_)=>HissGradientTextWidget(
            textContent: "\$${bMoneyNum.getData()}",
            textSize: 32.sp,
            fontWeight: FontWeight.w900,
            outlineColor: "#813A00".toColor(),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: ["#FFD942".toColor(),"#FF9500".toColor(),],
            ),
          ),
        ),
      ],
    ),
  );

  _cashBtnWidget()=>Positioned(
    top: 138.h,
    right: 37.w,
    child: HissClickWidget(
      onTap: (){
        controller.clickTopCash();
       },
      child: Stack(
        alignment: Alignment.center,
        children: [
          HissImagesWidget(name: "cash2", width: 84.w, height: 32.h),
          HissTextWidget(
            textContent: "Withdraw",
            textSize: 14.sp,
            fontWeight: FontWeight.bold ,
            outlineColor: "#3D2703".toColor(),
            textColor: "#FFFFFF".toColor(),
          ),
        ],
      ),
    ),
  );

  _titleWidget()=>Container(
    margin: EdgeInsets.only(top: 240.h),
    child: Stack(
      children: [
        HissImagesWidget(name: "cash3", width: double.infinity, height: 40.h,),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: EdgeInsets.only(top: 10.h),
            child: HissTextWidget(
              textContent: "Select withdrawal method",
              textSize: 16.sp,
              fontWeight: FontWeight.bold,
              textColor: "#FFFFFF".toColor(),
              outlineColor: "#6E2F15".toColor(),
            ),
          ),
        ),
      ],
    ),
  );
  
  _tabWidget()=>Container(
    margin: EdgeInsets.only(top: 276.h),
    child: Stack(
      alignment: Alignment.topCenter,
      children: [
        HissImagesWidget(name: "cash4", width: double.infinity, height: 74.h),
        Container(
          margin: EdgeInsets.only(top: 10.h),
          child: GetBuilder<BBBCashChildController>(
            id: "tab",
            builder: (_)=>Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                HissClickWidget(
                  onTap: (){
                    controller.clickCashType(HissCashType.paypal);
                  },
                  child: HissImagesWidget(
                    name: controller.cashType==HissCashType.paypal?"icon_paypal_sel2":"icon_paypal_uns2",
                    width: 140.w,
                    height: 44.h,
                  ),
                ),
                SizedBox(width: 32.w,),
                HissClickWidget(
                  onTap: (){
                    controller.clickCashType(HissCashType.cashapp);
                  },
                  child: HissImagesWidget(
                    name: controller.cashType==HissCashType.cashapp?"icon_cashapp_sel2":"icon_cashapp_uns2",
                    width: 140.w,
                    height: 44.h,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );

  _contentWidget()=>Container(
    width: double.infinity,
    height: double.infinity,
    color: "#A76C2D".toColor(),
    padding: EdgeInsets.only(left: 12.w,right: 12.w,top: 12.h,bottom: 80.h),
    margin: EdgeInsets.only(top: 340.h),
    child: MediaQuery.removePadding(
      context: buildContext,
      removeTop: true,
      removeBottom: true,
      child: GetBuilder<BBBCashChildController>(
        id: "list",
        builder: (_){
          var myMoney = bMoneyNum.getData();
          return ListView.separated(
            itemCount: controller.cashList.length,
            itemBuilder: (context,index){
              var bean = controller.cashList[index];
              if(null!=bean.cashRankBean){
                return _rankItemWidget(bean);
              }
              if(null!=bean.cashTaskBean){
                return _taskItemWidget(bean);
              }
              return _normalItemWidget(bean,myMoney);
            },
            separatorBuilder: (BuildContext context, int index) =>SizedBox(height: 16.h,),
          );
        },
      ),
    ),
  );

  _normalItemWidget(HissCashListBean bean, double myMoney)=>SizedBox(
    width: double.infinity,
    height: 80.h,
    child: Stack(
      alignment: Alignment.center,
      children: [
        HissImagesWidget(name: "cash5", width: double.infinity, height: 80.h),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                SizedBox(width: 16.w,),
                HissGradientTextWidget(
                  textContent: "\$${bean.totalMoney}",
                  textSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  outlineColor: "#000000".toColor(),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: ["#FFFFFF".toColor(),"#FFEEA9".toColor(),],
                  ),
                ),
                Spacer(),
                HissClickWidget(
                  onTap: (){
                    controller.clickNormalItemCash(bean);
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      HissImagesWidget(name: "cash6", width: 84.w, height: 32.h),
                      HissTextWidget(
                        textContent: "Cash Out",
                        textSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        textColor: "#FFFFFF".toColor(),
                        outlineColor: "#133D03".toColor(),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16.w,),
              ],
            ),
            SizedBox(height: 10.h,),
            Container(
              margin: EdgeInsets.only(left: 16.w,right: 16.w),
              child: Stack(
                alignment: Alignment.centerRight,
                children: [
                  LayoutBuilder(
                    builder: (context,bc){
                      var maxWidth = bc.maxWidth-(2.w);
                      return Container(
                        width: double.infinity,
                        height: 8.h,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 1.w,right: 1.w),
                        decoration: BoxDecoration(
                          color: "#A2532E".toColor(),
                          borderRadius: BorderRadius.circular(4.w),
                          border: Border.all(
                            width: 1.5.w,
                            color: "#FBD35F".toColor(),
                          ),
                        ),
                        child: Container(
                          width: maxWidth*getProgress(myMoney.toInt(), bean.totalMoney),
                          height: 4.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.w),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: ["#A3ECA4".toColor(),"#4EB255".toColor(),],
                              )
                          ),
                        ),
                      );
                    },
                  ),
                  HissImagesWidget(name: "icon_money4", width: 24.w, height: 24.w,),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );

  _taskItemWidget(HissCashListBean bean)=>Container(
    width: double.infinity,
    padding: EdgeInsets.all(12.w),
    decoration: BoxDecoration(
      color: "#9A642A".toColor(),
      borderRadius: BorderRadius.circular(12.w),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            HissGradientTextWidget(
              textContent: "\$${bean.totalMoney}",
              textSize: 20.sp,
              fontWeight: FontWeight.bold,
              outlineColor: "#000000".toColor(),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: ["#FFFFFF".toColor(),"#FFEEA9".toColor(),],
              ),
            ),
            Spacer(),
            HissClickWidget(
              onTap: (){
                controller.clickTaskItem(bean);
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  HissImagesWidget(name: "cash6", width: 84.w, height: 32.h),
                  HissTextWidget(
                    textContent: "Processing",
                    textSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    textColor: "#FFFFFF".toColor(),
                    outlineColor: "#133D03".toColor(),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h,),
        Container(
          width: double.infinity,
          height: 40.h,
          padding: EdgeInsets.only(left: 8.w,right: 8.w),
          decoration: BoxDecoration(
            color: "#A77337".toColor(),
            borderRadius: BorderRadius.circular(8.w),
          ),
          child: Row(
            children: [
              Expanded(
                child: HissTextWidget(
                  textContent: getTaskTitle(HissTaskQueueConfigUtils.instance.getWithdrawalTaskByIndex(bean.cashTaskBean?.taskIndex??0).name, bean.cashTaskBean?.totalPro),
                  textSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  textColor: "#FFFFFF".toColor(),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: 16.w,),
              HissTextWidget(
                textContent: "${bean.cashTaskBean?.currentPro??0}/${bean.cashTaskBean?.totalPro??0}",
                textSize: 12.sp,
                fontWeight: FontWeight.bold,
                textColor: "#FFFFFF".toColor(),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    ),
  );

  _rankItemWidget(HissCashListBean bean)=>Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      SizedBox(
        width: double.infinity,
        height: 108.h,
        child: Stack(
          children: [
            HissImagesWidget(name: "cash7", width: double.infinity, height: 108.h),
            Column(
              children: [
                Row(
                  children: [
                    SizedBox(width: 16.w,),
                    HissGradientTextWidget(
                      textContent: "\$${bean.totalMoney}",
                      textSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      outlineColor: "#000000".toColor(),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: ["#FFFFFF".toColor(),"#FFEEA9".toColor(),],
                      ),
                    ),
                    Spacer(),
                    HissClickWidget(
                      onTap: (){
                        controller.clickRankItem(bean);
                      },
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 12.h),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                HissImagesWidget(name: "cash6", width: 84.w, height: 32.h),
                                HissTextWidget(
                                  textContent: "Skip Wait",
                                  textSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                  textColor: "#FFFFFF".toColor(),
                                  outlineColor: "#133D03".toColor(),
                                ),
                              ],
                            ),
                          ),
                          HissImagesWidget(name: "icon_video", width: 24.w, height: 24.w),
                        ],
                      ),
                    ),
                    SizedBox(width: 16.w,),
                  ],
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(left: 16.w,right: 16.w),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Congratulations! You’ve entered the withdrawal review queue. You can tap “",
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: "#000000".toColor(),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: "Skip Wait",
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: "#F00400".toColor(),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: "” to speed up the review process.",
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: "#000000".toColor(),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      SizedBox(height: 12.h,),
      RichText(
        text: TextSpan(
          children: [
            //228 in queue, your current rank 22
            TextSpan(
              text: "${bean.cashRankBean?.totalPro??0}",
              style: TextStyle(
                fontSize: 14.sp,
                color: "#FFD21D".toColor(),
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: " in queue, your current rank ",
              style: TextStyle(
                fontSize: 14.sp,
                color: "#FFD21D".toColor(),
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: "${bean.cashRankBean?.currentPro??0}",
              style: TextStyle(
                fontSize: 14.sp,
                color: "#FFD21D".toColor(),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 12.h,),
      ClipRRect(
        borderRadius: BorderRadius.circular(12.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              height: 28.h,
              color: "#A77337".toColor(),
              child: Row(
                children: [
                  Expanded(
                    child: Center(
                      child: HissTextWidget(textContent: "Queue", textSize: 14.sp, textColor: "#FFFFFF".toColor(),fontWeight: FontWeight.bold,),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: HissTextWidget(textContent: "Account", textSize: 14.sp, textColor: "#FFFFFF".toColor(),fontWeight: FontWeight.bold,),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: HissTextWidget(textContent: "Amount", textSize: 14.sp, textColor: "#FFFFFF".toColor(),fontWeight: FontWeight.bold,),
                    ),
                  ),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: bean.cashRankBean?.userList?.length??0,
              itemBuilder: (context,index){
                var userInfoBean = bean.cashRankBean?.userList?[index];
                return Container(
                  width: double.infinity,
                  height: 28.h,
                  color: index%2==0?"#9A642A".toColor():"#A77337".toColor(),
                  child: Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: HissTextWidget(
                            textContent: "${userInfoBean?.rank??0}",
                            textSize: 14.sp,
                            textColor: userInfoBean?.isMe==true?"#FFFFFF".toColor():"#FFEBB5".toColor(),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: HissTextWidget(
                            textContent: userInfoBean?.account??"",
                            textSize: 14.sp,
                            textColor: userInfoBean?.isMe==true?"#FFFFFF".toColor():"#FFEBB5".toColor(),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: HissTextWidget(
                            textContent: "\$${userInfoBean?.money??0}",
                            textSize: 14.sp,
                            textColor: userInfoBean?.isMe==true?"#FFFFFF".toColor():"#FFEBB5".toColor(),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    ],
  );
}