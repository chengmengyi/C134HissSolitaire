import 'package:flutter/material.dart';
import 'package:hiss_bbb/bean/hiss_cash_task_bean.dart';
import 'package:hiss_bbb/ui/dialog/cash_task_dialog/cash_task_dialog_controller.dart';
import 'package:hiss_bbb/utils/utils.dart';
import 'package:hiss_root/hiss_ui/hiss_root_dialog.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_click_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_gradient_text_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_images_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_text_widget.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';
import 'package:hiss_root/hiss_utils/hiss_utils.dart';

class CashTaskDialog extends HissRootDialog<CashTaskDialogController>{
  HissCashTaskBean? cashTaskBean;
  CashTaskDialog({
    required this.cashTaskBean,
});

  @override
  CashTaskDialogController initGetController() => CashTaskDialogController(cashTaskBean: cashTaskBean);

  @override
  Widget initContent() => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: double.infinity,
        height: 284.h,
        margin: EdgeInsets.only(left: 20.w,right: 20.w),
        child: Stack(
          children: [
            HissImagesWidget(name: "task1", width: double.infinity, height: 284.h,),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.only(top: 40.h),
                child: HissGradientTextWidget(
                  textContent: "Human Verification",
                  textSize: 20.sp,
                  fontWeight: FontWeight.w900,
                  outlineColor: "#01500C".toColor(),
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: ["#FFFFFF".toColor(),"#FFF290".toColor(),]
                  ),
                ),
              ),
            ),
            _contentWidget(),
          ],
        ),
      ),
      SizedBox(height: 16.h,),
      HissClickWidget(
        onTap: (){
          controller.clickClose();
        },
        child: HissImagesWidget(name: "icon_close", width: 32.w, height: 32.w),
      ),
    ],
  );

  _contentWidget()=>Container(
    margin: EdgeInsets.only(left: 48.w,right: 48.w),
    child: Column(
      children: [
        SizedBox(height: 100.h,),
        HissTextWidget(
          textContent: "Please complete human\nverification before withdrawing.",
          textSize: 14.sp,
          textAlign: TextAlign.center,
          fontWeight: FontWeight.bold,
          textColor: "#724B2F".toColor(),
        ),
        SizedBox(height: 20.h,),
        Row(
          children: [
            HissImagesWidget(name: controller.getTaskIcon(), width: 36.w, height: 36.w),
            SizedBox(width: 8.w,),
            HissTextWidget(
              textContent: controller.getTaskTitle(),
              textSize: 14.sp,
              fontWeight: FontWeight.bold,
              textColor: "#000000".toColor(),
            ),
          ],
        ),
        // Expanded(
        //   child: GetBuilder<CashTaskDialogController>(
        //     id: "list",
        //     builder: (_)=>ListView.separated(
        //       itemCount: controller.taskList.length,
        //       itemBuilder: (context,index){
        //         var task = controller.taskList[index];
        //         return Row(
        //           children: [
        //             Visibility(
        //               visible: controller.checkCompleted(index),
        //               maintainAnimation: true,
        //               maintainState: true,
        //               maintainSize: true,
        //               child: HissImagesWidget(name: "task3", width: 24.w, height: 24.w),
        //             ),
        //             SizedBox(width: 12.w,),
        //             HissImagesWidget(name: controller.getTaskIcon(task.name), width: 36.w, height: 36.w),
        //             SizedBox(width: 8.w,),
        //             HissTextWidget(
        //               textContent: getTaskTitle(task.name, task.num),
        //               textSize: 14.sp,
        //               fontWeight: FontWeight.bold,
        //               textColor: "#000000".toColor(),
        //             ),
        //           ],
        //         );
        //       },
        //       separatorBuilder: (BuildContext context, int index) => SizedBox(height: 8.h,),
        //     ),
        //   ),
        // ),
        SizedBox(height: 20.h,),
        HissClickWidget(
          onTap: (){
            controller.clickConfirm();
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              HissImagesWidget(name: "task2", width: 180.w, height: 48.h),
              HissTextWidget(
                textContent: "Confirm",
                textSize: 18.sp,
                fontWeight: FontWeight.bold,
                textColor: "#FFFFFF".toColor(),
                outlineColor: "#5BD522".toColor(),
              ),
            ],
          ),
        ),
        SizedBox(height: 20.h,),
      ],
    ),
  );
}