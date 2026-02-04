import 'package:flutter/material.dart';
import 'package:hiss_bbb/ui/dialog/spin_reward_task_dialog/spin_reward_task_dialog_controller.dart';
import 'package:hiss_bbb/ui/widget/hiss_video_btn_widget.dart';
import 'package:hiss_bbb/utils/hiss_enum/hiss_gift_reward_task_type.dart';
import 'package:hiss_bbb/utils/hiss_storage.dart';
import 'package:hiss_bbb/utils/utils.dart';
import 'package:hiss_root/hiss_ui/hiss_root_dialog.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_click_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_images_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_text_widget.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';
import 'package:hiss_root/hiss_utils/hiss_utils.dart';

class SpinRewardTaskDialog extends HissRootDialog<SpinRewardTaskDialogController>{
  String? rewardType;
  Function() clickSpinCallback;

  SpinRewardTaskDialog({
    required this.rewardType,
    required this.clickSpinCallback,
  });

  @override
  SpinRewardTaskDialogController initGetController() => SpinRewardTaskDialogController(
    type: rewardType,
  );

  @override
  Widget initContent() => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      _topWidget(),
      SizedBox(height: 16.h,),
      _textWidget(),
      SizedBox(height: 30.h,),
      _progressWidget(),
      SizedBox(height: 52.h,),
      _taskWidget(),
      SizedBox(height: 30.h,),
      HissVideoBtnWidget(
        text: "Spin(${wheelNum.getData()})",
        bg: "home_gift8",
        width: 280.w,
        height: 52.h,
        showVideoIcon: wheelNum.getData()<=0,
        onTap: (){
          controller.clickSpin(clickSpinCallback);
        },
      ),
    ],
  );

  _topWidget()=>SizedBox(
    width: double.infinity,
    height: 200.w,
    child: Stack(
      children: [
        Align(
          child: HissImagesWidget(name: getGiftIcon(rewardType), width: 200.w, height: 200.w,),
        ),
        Positioned(
          right: 16.w,
          child: HissClickWidget(
            onTap: (){
              controller.clickClose();
            },
            child: HissImagesWidget(name: "icon_close2", width: 24.w, height: 24.w,),
          ),
        ),
      ],
    ),
  );

  _textWidget()=>Container(
    margin: EdgeInsets.only(left: 36.w,right: 36.w,),
    child: GetBuilder<SpinRewardTaskDialogController>(
      id: "text",
      builder: (_)=>HissTextWidget(
        textContent: controller.getText(),
        textSize: 16.sp,
        textColor: "#FFFFFF".toColor(),
      ),
    ),
  );

  _progressWidget()=>GetBuilder<SpinRewardTaskDialogController>(
    id: "pro",
    builder: (_)=>SizedBox(
      width: 240.w,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Container(
            width: 240.w,
            height: 8.h,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.w),
              color: "#FFFFFF".toColor().withOpacity(0.4),
            ),
            child: Container(
              width: (240.w)*controller.getPro(),
              height: 8.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.w),
                gradient: LinearGradient(
                    colors: ["#FFE047".toColor(),"#FFB829".toColor(),]
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 88.w),
            child: _proCenterWidget(),
          ),
          Container(
            margin: EdgeInsets.only(left: 220.w),
            child: HissImagesWidget(name: "gift_reward1", width: 24.w, height: 24.w,),
          ),
          Container(
            margin: EdgeInsets.only(left: (200.w)*controller.kuaidiMargeLeft()),
            child: _kuaidiWidget(),
          ),
        ],
      ),
    ),
  );

  _proCenterWidget(){
    switch(controller.rewardTaskBean?.taskType){
      case HissGiftRewardTaskType.task:
        return HissImagesWidget(name: getGiftIcon(rewardType), width: 32.w, height: 32.w,);
      case HissGiftRewardTaskType.kuaidi:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            HissImagesWidget(name: "gift_reward2", width: 32.w, height: 32.w,),
            HissTextWidget(textContent: "Packing", textSize: 10.sp, textColor: "#FFFFFF".toColor(),),
          ],
        );
      default: return Container();
    }
  }

  _kuaidiWidget(){
    if(controller.rewardTaskBean?.taskType!=HissGiftRewardTaskType.kuaidi){
      return Container();
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        HissImagesWidget(name: "gift_reward3", width: 32.w, height: 32.w,),
        HissTextWidget(textContent: "Transport", textSize: 10.sp, textColor: "#FFFFFF".toColor(),),
      ],
    );
  }

  _taskWidget()=>GetBuilder<SpinRewardTaskDialogController>(
    id: "task",
    builder: (_)=>Visibility(
      visible: controller.rewardTaskBean?.taskType==HissGiftRewardTaskType.task,
      child: Container(
        width: 280.w,
        height: 52.h,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 12.w,right: 12.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.w),
          color: "#D1A88B".toColor(),
          border: Border.all(
            width: 0.5.w,
            color: "#EBC8AF".toColor(),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  HissTextWidget(
                    textContent: "${controller.rewardTaskBean?.totalPro??0} ",
                    textSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    textColor: "#724B2F".toColor(),
                    overflow: TextOverflow.ellipsis,
                  ),
                  HissImagesWidget(name: "icon_suipian", width: 24.w, height: 24.w,),
                ],
              ),
            ),
            HissTextWidget(
              textContent: "${controller.rewardTaskBean?.currentPro??0}/${controller.rewardTaskBean?.totalPro??0}",
              textSize: 16.sp,
              textColor: "#FFD21D".toColor(),
              fontWeight: FontWeight.bold,
              outlineColor: "#6E2F15".toColor(),
            ),
          ],
        ),
      ),
    ),
  );
}