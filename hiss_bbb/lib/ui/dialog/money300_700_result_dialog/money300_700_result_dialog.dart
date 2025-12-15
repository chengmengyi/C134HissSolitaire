import 'package:flutter/material.dart';
import 'package:hiss_bbb/ui/dialog/money300_700_result_dialog/money300_700_result_dialog_controller.dart';
import 'package:hiss_bbb/ui/widget/hiss_cash_barrage_widget.dart';
import 'package:hiss_bbb/utils/hiss_storage.dart';
import 'package:hiss_root/hiss_ui/hiss_root_dialog.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_click_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_gradient_text_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_images_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_text_widget.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';
import 'package:hiss_root/hiss_utils/hiss_utils.dart';

class Money300700ResultDialog extends HissRootDialog<Money300700ResultDialogController>{
  int maxMoney;
  Money300700ResultDialog({
    required this.maxMoney,
});

  @override
  Money300700ResultDialogController initGetController() => Money300700ResultDialogController();

  @override
  Widget initContent() => Container(
    width: double.infinity,
    height: double.infinity,
    alignment: Alignment.center,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        HissCashBarrageWidget(), 
        SizedBox(height: 12.h,),
        HissCashBarrageWidget(),
        SizedBox(height: 12.h,),
        HissImagesWidget(name: "money3004", width: 280.w, height: 112.h,),
        SizedBox(height: 4.h,),
        Container(
          margin: EdgeInsets.only(left: 24.w,right: 24.w),
          child: HissTextWidget(
            textContent: "Your withdrawal progress is ahead of 92% of users!",
            textSize: 16.sp,
            textColor: "#FFFFFF".toColor(),
            textAlign: TextAlign.center,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 24.h,),
        HissGradientTextWidget(
          textContent: "Current Earning",
          textSize: 20.sp,
          fontWeight: FontWeight.bold,
          outlineColor: "#01500C".toColor(),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: ["#FFFFFF".toColor(),"#FFF290".toColor(),]
          ),
        ),
        SizedBox(height: 10.h,),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            HissImagesWidget(name: "icon_money4", width: 40.w, height: 40.w,),
            SizedBox(width: 4.w,),
            HissTextWidget(
              textContent: "\$${bMoneyNum.getData()}",
              textSize: 32.sp,
              textColor: "#FFD21D".toColor(),
              fontWeight: FontWeight.bold,
              outlineColor: "#6E2F15".toColor(),
            ),
          ],
        ),
        SizedBox(height: 14.h,),
        _progressListWidget(),
        SizedBox(height: 36.h,),
        HissClickWidget(
          onTap: (){
            controller.clickPlayGame();
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              HissImagesWidget(name: "money3005", width: 200.w, height: 52.h,),
              HissTextWidget(
                textContent: "Play Game",
                textSize: 18.sp,
                fontWeight: FontWeight.bold,
                textColor: "#FFFFFF".toColor(),
                outlineColor: "#133D03".toColor(),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h,),
        _cashWidget(),
      ],
    ),
  );

  _progressListWidget()=>ListView.builder(
    shrinkWrap: true,
    itemCount: 3,
    itemBuilder: (context,index)=>Container(
      width: double.infinity,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 56.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              HissImagesWidget(name: index==2?"icon_uns":"icon_sel", width: 24.w, height: 24.w),
              SizedBox(width: 8.w,),
              HissTextWidget(
                textContent: controller.getProText(index, maxMoney),
                textSize: 14.sp,
                fontWeight: FontWeight.bold,
                textColor: index==1?"#FFD21D".toColor():"#FFFFFF".toColor(),
              ),
            ],
          ),
          Visibility(
            visible: index!=2,
            child: Container(
              width: 2.w,
              height: 28.h,
              margin: EdgeInsets.only(left: 11.w,top: 4.h,bottom: 4.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2.w),
                color: index==0?"#77F445".toColor():"#A6AFA3".toColor() ,
              ),
            ),
          )
        ],
      ),
    ),
  );

  _cashWidget()=>Container(
    width: double.infinity,
    padding: EdgeInsets.all(10.w),
    margin: EdgeInsets.only(left: 40.w,right: 40.w),
    decoration: BoxDecoration(
      color: "#4D4D4D".toColor(),
      borderRadius: BorderRadius.circular(12.w),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            HissImagesWidget(name: "money3006", width: 68.w, height: 24.h,),
            Spacer(),
            HissClickWidget(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  HissImagesWidget(name: "money3005", width: 84.w, height: 31.h,),
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
          ],
        ),
        SizedBox(height: 8.h,),
        HissTextWidget(textContent: "Accumulate \$1000 to cash out.", textSize: 14.sp, textColor: "#FFFFFF".toColor(),),
        SizedBox(height: 4.h,),
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
              borderRadius: BorderRadius.circular(2.w),
              gradient: LinearGradient(
                colors: ["#A3ECA4".toColor(),"#4EB255".toColor(),]
              ),
            ),
          ),
        ),
      ],
    ),
  );
}