import 'package:flutter/material.dart';
import 'package:hiss_bbb/bean/hiss_daily_task_bean.dart';
import 'package:hiss_bbb/ui/dialog/home_task_dialog/home_task_dialog_controller.dart';
import 'package:hiss_bbb/ui/widget/hiss_home_bottom_tab_widget.dart';
import 'package:hiss_bbb/utils/utils.dart';
import 'package:hiss_root/hiss_ui/hiss_root_dialog.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_click_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_gradient_text_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_images_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_text_widget.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';
import 'package:hiss_root/hiss_utils/hiss_utils.dart';

class HomeTaskDialog extends HissRootDialog<HomeTaskDialogController>{
  Function(int index) clickIndexCallback;
  HomeTaskDialog({
    required this.clickIndexCallback,
});

  @override
  HomeTaskDialogController initGetController() => HomeTaskDialogController();

  @override
  Widget initContent() => SizedBox(
    width: double.infinity,
    height: double.infinity,
    child: Stack(
      children: [
        Align(
          child: Container(
            width: double.infinity,
            height: 552.h,
            margin: EdgeInsets.only(left: 16.w,right: 16.w),
            child: Stack(
              children: [
                HissImagesWidget(name: "home_task1", width: double.infinity, height: double.infinity,),
                Positioned(
                  top: 28.h,
                  right: 8.w,
                  child: HissClickWidget(
                    onTap: (){
                      controller.clickClose();
                    },
                    child: HissImagesWidget(name: "icon_close2", width: 24.w, height: 24.w,),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: EdgeInsets.only(top: 18 .h),
                    child: HissGradientTextWidget(
                      textContent: "Daily Task",
                      textSize: 20.sp,
                      outlineColor: "#B34C00".toColor(),
                      fontWeight: FontWeight.w900,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: ["#FFEA8D".toColor(),"#FFD100".toColor(),],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  margin: EdgeInsets.only(left: 32.w,right: 32.w,top: 78.h,bottom: 48.h),
                  child: GetBuilder<HomeTaskDialogController>(
                    id: "list",
                    builder: (_)=>MediaQuery.removePadding(
                      context: buildContext,
                      removeTop: true,
                      removeBottom: true,
                      child: ListView.builder(
                        itemCount: controller.dailyList.length,
                        itemBuilder: (context,index)=>_taskItemWidget(controller.dailyList[index]),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: HissHomeBottomTabWidget(
            initIndex: 0,
            clickCallback: (index){
              controller.clickBottomIndex(index,clickIndexCallback);
            },
          ),
        ),
      ],
    ),
  );

  _taskItemWidget(HissDailyTaskBean taskBean)=>SizedBox(
    width: double.infinity,
    height: 68.h,
    child: Stack(
      alignment: Alignment.centerLeft,
      children: [
        HissImagesWidget(name: "home_task2", width: double.infinity, height: 68.h,),
        Row(
          children: [
            SizedBox(width: 10.w,),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                HissImagesWidget(name: "home_task3", width: 36.w, height: 36.w,),
                HissTextWidget(
                  textContent: "\$${taskBean.reward??0}",
                  textSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  textColor: "#FFFFFF".toColor(),
                  outlineColor: "#62433C".toColor(),
                ),
              ],
            ),
            SizedBox(width: 12.w,),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HissTextWidget(textContent: getTaskTitle(taskBean.type,taskBean.totalPro), textSize: 12.sp, textColor: "#FFFFFF".toColor(),),
                  SizedBox(height: 6.h,),
                  Row(
                    children: [
                      Expanded(
                        child: LayoutBuilder(
                          builder: (context,bc){
                            var maxWidth = bc.maxWidth-(2.w);
                            return Container(
                              width: double.infinity,
                              height: 8.h,
                              padding: EdgeInsets.only(left: 1.w,right: 1.w),
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.w),
                                color: "#A2532E".toColor(),
                                border: Border.all(
                                  width: 1.5.w,
                                  color: "#FBD35F".toColor(),
                                ),
                              ),
                              child: Container(
                                width: maxWidth*getProgress(taskBean.currentPro??0, taskBean.totalPro??0),
                                height: 4.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2.w),
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: ["#A3ECA4".toColor(),"#4EB255".toColor()],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(width: 6.w,),
                      HissTextWidget(
                        textContent: "${taskBean.currentPro??0}/${taskBean.totalPro??0}",
                        textSize: 10.sp,
                        fontWeight: FontWeight.bold,
                        textColor: "#FFFFFF".toColor(),
                        outlineColor: "#62433C".toColor(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.w,),
            HissClickWidget(
              onTap: (){
                controller.clickClaim(taskBean);
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  HissImagesWidget(name: controller.getBtnIcon(taskBean), width: 72.w, height: 32.h),
                  HissTextWidget(
                    textContent: controller.getBtnText(taskBean),
                    textSize: 14.sp,
                    textColor: "#FFFFFF".toColor(),
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ),
            SizedBox(width: 10.w,),
          ],
        ),
      ],
    ),
  );
}