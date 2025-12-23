import 'package:flutter/material.dart';
import 'package:hiss_bbb/ui/dialog/play_success_dialog/play_success_controller.dart';
import 'package:hiss_bbb/ui/widget/hiss_video_btn_widget.dart';
import 'package:hiss_bbb/utils/hiss_storage.dart';
import 'package:hiss_bbb/utils/hiss_value_config_utils.dart';
import 'package:hiss_root/hiss_ui/hiss_root_dialog.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_click_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_gradient_text_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_images_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_text_widget.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';
import 'package:hiss_root/hiss_utils/hiss_utils.dart';

class PlaySuccessDialog extends HissRootDialog<PlaySuccessController>{
  int time;
  int step;
  int score;
  Function() dismissCallback;
  PlaySuccessDialog({
    required this.time,
    required this.step,
    required this.score,
    required this.dismissCallback,
});

  @override
  PlaySuccessController initGetController() => PlaySuccessController(
    score: score,
    time: time,
    step: step,
  );

  @override
  Widget initContent() => Container(
    width: double.infinity,
    margin: EdgeInsets.only(left: 20.w,right: 20.w),
    child: Stack(
      alignment: Alignment.topCenter,
      children: [
        HissImagesWidget(name: "success1", width: 200.w, height: 100.h),
        Container(
          margin: EdgeInsets.only(top: 60.h),
          child: SizedBox(
            width: double.infinity,
            height: 360.h,
            child: Stack(
              children: [
                HissImagesWidget(name: "success2", width: double.infinity, height: 360.h,),
                _contentWidget(),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: EdgeInsets.only(top: 40.h),
                    child: HissGradientTextWidget(
                      textContent: "Winning Settlement",
                      textSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      outlineColor: "#01500C".toColor(),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: ["#FFFFFF".toColor(),"#FFF290".toColor(),]
                      ),
                    ),
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
    height: 360.h,
    padding: EdgeInsets.only(top: 84.h),
    child: Column(
      children: [
        HissGradientTextWidget(
          textContent: "Level ${bLevel.getData()}",
          textSize: 18.sp,
          fontWeight: FontWeight.bold,
          outlineColor: "#6E2F15".toColor(),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: ["#FFB62D".toColor(),"#FF5C05".toColor(),]
          ),
        ),
        SizedBox(height: 10.h,),
        Expanded(
          child: SingleChildScrollView(
            controller: controller.scrollController,
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _infoWidget(),
                SizedBox(height: 6.h,),
                // _diamondAndMoneyWidget(),
                SizedBox(height: 16.h,),
                _rewardWidget(),
              ],
            ),
          ),
        ),
        SizedBox(height: 6.h,),
        HissVideoBtnWidget(
          text: "Claim",
          bg: "success3",
          width: 180.w,
          height: 48.h,
          onTap: (){
            controller.clickClaim(dismissCallback);
          },
        ),
        // HissClickWidget(
        //   onTap: (){
        //     controller.clickClaim(dismissCallback);
        //   },
        //   child: Stack(
        //     alignment: Alignment.center,
        //     children: [
        //       HissImagesWidget(name: "success3", width: 180.w, height: 48.h),
        //       HissTextWidget(
        //         textContent: "Claim",
        //         textSize: 18.sp,
        //         textColor: "#FFFFFF".toColor(),
        //         outlineColor: "#133D03".toColor(),
        //         fontWeight: FontWeight.w900,
        //       ),
        //     ],
        //   ),
        // ),
        SizedBox(height: 12.h,),
      ],
    ),
  );

  _infoWidget()=>Container(
    width: double.infinity,
    key: controller.scrollGlobalKey,
    padding: EdgeInsets.only(left: 12.w,right: 12.w,top: 12.h),
    margin: EdgeInsets.only(left: 48.w,right: 48.w),
    decoration: BoxDecoration(
      color: "#D1A88B".toColor(),
      borderRadius: BorderRadius.circular(12.w),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Spacer(),
            Expanded(
              child: Center(
                child: HissTextWidget(
                  textContent: "Current Grade",
                  textSize: 10.sp,
                  textColor: "#4B2912".toColor(),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: HissTextWidget(
                  textContent: "Best Result",
                  textSize: 10.sp,
                  textColor: "#FFD21D".toColor(),
                  fontWeight: FontWeight.bold,
                  outlineColor: "#6E2F15".toColor(),
                ),
              ),
            ),
          ],
        ),
        Container(
          width: double.infinity,
          height: 0.5.h,
          color: "#B79074".toColor(),
          margin: EdgeInsets.only(top: 10.h,bottom: 10.h),
        ),
        GetBuilder<PlaySuccessController>(
          id: "list",
          builder: (_)=>MediaQuery.removePadding(
            context: buildContext,
            removeTop: true,
            child: ListView.builder(
              itemCount: controller.gradeList.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context,index){
                var bean = controller.gradeList[index];
                return SizedBox(
                  width: double.infinity,
                  height: 32.h,
                  child: Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: HissTextWidget(
                            textContent: bean.title,
                            textSize: 12.sp,
                            textColor: "#724B2F".toColor(),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          width: double.infinity,
                          height: 32.h,
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: HissTextWidget(
                                  textContent: bean.currentGrade,
                                  textSize: 14.sp,
                                  textColor:bean.currentIsBest?"#FFD21D".toColor():"#4B2912".toColor(),
                                  fontWeight: FontWeight.bold,
                                  outlineColor: bean.currentIsBest?"#6E2F15".toColor():null,
                                ),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: Visibility(
                                  visible: bean.currentIsBest,
                                  child: HissImagesWidget(name: "success4", width: 20.w, height: 20.w),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          width: double.infinity,
                          height: 32.h,
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: HissTextWidget(
                                  textContent: bean.bestGrade,
                                  textSize: 14.sp,
                                  textColor:!bean.currentIsBest?"#FFD21D".toColor():"#4B2912".toColor(),
                                  fontWeight: FontWeight.bold,
                                  outlineColor: bean.currentIsBest?null:"#6E2F15".toColor(),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: Visibility(
                                  visible: !bean.currentIsBest,
                                  child: HissImagesWidget(name: "success4", width: 20.w, height: 20.w),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    ),
  );

  _diamondAndMoneyWidget()=>Visibility(
    visible: false,
    maintainAnimation: true,
    maintainState: true,
    maintainSize: true,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        HissImagesWidget(name: "icon_diamond", width: 28.w, height: 28.w),
        SizedBox(width: 4.w,),
        HissTextWidget(
          textContent: "待定",
          textSize: 14.sp,
          textColor: "#FFFFFF".toColor(),
          outlineColor: "#052B1F".toColor(),
          fontWeight: FontWeight.w900,
        ),
        SizedBox(width: 16.w,),
        HissImagesWidget(name: "icon_money4", width: 28.w, height: 28.w),
        SizedBox(width: 4.w,),
        HissTextWidget(
          textContent: "待定",
          textSize: 14.sp,
          textColor: "#FFFFFF".toColor(),
          outlineColor: "#052B1F".toColor(),
          fontWeight: FontWeight.w900,
        ),
      ],
    ),
  );

  _rewardWidget()=>Container(
    margin: EdgeInsets.only(left: 48.w,right: 48.w),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        HissTextWidget(
          textContent: "Wow, you’re so lucky! This reward gives you an extra \$50!",
          textSize: 14.sp,
           textColor: "#724B2F".toColor(),
        ),
        SizedBox(height: 16.h,),
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            HissTextWidget(
              textContent: "\$${controller.onlyAddNum}",
              textSize: 28.sp,
              fontWeight: FontWeight.bold,
              textColor: "#FFD21D".toColor(),
              outlineColor: "#6E2F15".toColor(),
            ),
            SizedBox(width: 4.w,),
            Stack(
              alignment: Alignment.topRight,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 14.h,right: 14.w),
                  child: HissTextWidget(
                    textContent: "+\$${controller.addNum}",
                    textSize: 28.sp,
                    fontWeight: FontWeight.bold,
                    textColor: "#55E53B".toColor(),
                    outlineColor: "#155D0E".toColor(),
                  ),
                ),
                HissImagesWidget(name: "icon_video", width: 28.w, height: 28.w,),
              ],
            )
          ],
        ),
        SizedBox(height: 30.h,),
        HissClickWidget(
          onTap: (){
            controller.clickOnly(dismissCallback);
          },
          child: HissTextWidget(
            textContent: "Only \$${controller.onlyAddNum}",
            textSize: 16.sp,
            fontWeight: FontWeight.bold,
            textColor: "#FFFFFF".toColor(),
            outlineColor: "#052B1F".toColor(),
            decoration: TextDecoration.underline,
            decorationColor: "#052B1F".toColor(),
          ),
        ),
        SizedBox(height: 100.h,),
      ],
    ),
  );
}