import 'package:flutter/material.dart';
import 'package:hiss_bbb/ui/page/home/cash_child/cash_child_controller.dart';
import 'package:hiss_bbb/utils/hiss_enum/hiss_cash_type.dart';
import 'package:hiss_bbb/utils/hiss_storage.dart';
import 'package:hiss_root/hiss_ui/hiss_root_child.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_click_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_gradient_text_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_images_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_text_widget.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';
import 'package:hiss_root/hiss_utils/hiss_utils.dart';

class CashChild extends HissRootChild<CashChildController>{
  @override
  CashChildController initGetController() => CashChildController();

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
        GetBuilder<CashChildController>(
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
          child: GetBuilder<CashChildController>(
            id: "tab",
            builder: (_)=>Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                HissImagesWidget(
                  name: controller.cashType==HissCashType.paypal?"icon_paypal_sel2":"icon_paypal_uns2",
                  width: 140.w,
                  height: 44.h,
                ),
                SizedBox(width: 32.w,),
                HissImagesWidget(
                  name: controller.cashType==HissCashType.cashapp?"icon_cashapp_sel2":"icon_cashapp_uns2",
                  width: 140.w,
                  height: 44.h,
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
      child: ListView.separated(
        itemCount: 3,
        itemBuilder: (context,index){
          if(index==0){
            return _taskItemWidget();
          }
          if(index==1){
            return _rankItemWidget();
          }
          return _normalItemWidget();
        },
        separatorBuilder: (BuildContext context, int index) =>SizedBox(height: 16.h,),
      ),
    ),
  );

  _normalItemWidget()=>SizedBox(
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
                  textContent: "\$1000",
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
                  Container(
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
                      width: 100,
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

  _taskItemWidget()=>Container(
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
              textContent: "\$1000",
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
                  textContent: "Task Information Task Information InformationInformation",
                  textSize: 12.sp,
                  textColor: "#FFFFFF".toColor(),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: 16.w,),
              HissImagesWidget(name: "icon_sel", width: 24.w, height: 24.w),
            ],
          ),
        ),
      ],
    ),
  );

  _rankItemWidget()=>Column(
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
                      textContent: "\$1000",
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
              text: "228",
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
              text: "22",
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
            )
          ],
        ),
      ),
    ],
  );
}