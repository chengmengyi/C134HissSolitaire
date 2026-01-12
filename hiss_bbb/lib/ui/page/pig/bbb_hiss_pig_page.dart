import 'package:flutter/material.dart';
import 'package:hiss_bbb/ui/page/pig/bbb_hiss_pig_controller.dart';
import 'package:hiss_bbb/utils/hiss_enum/hiss_pig_type.dart';
import 'package:hiss_root/hiss_ui/hiss_root_page.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_click_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_gradient_text_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_images_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_text_widget.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';
import 'package:hiss_root/hiss_utils/hiss_utils.dart';

class BBBHissPigPage extends HissRootPage<BBBHissPigController>{

  @override
  BBBHissPigController initGetController() => BBBHissPigController();

  @override
  Widget initContent() => Stack(
    children: [
      HissImagesWidget(name: "pig1", width: double.infinity, height: double.infinity),
      _bottomWidget(),
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
      Align(
        alignment: Alignment.topCenter,
        child: Container(
          margin: EdgeInsets.only(top: 240.h),
          child: Stack(
            children: [
              HissImagesWidget(name: "pig16",width: 248.w,height: 200.h,),
              Positioned(
                left: 50.w,
                top: 50.h,
                child: HissImagesWidget(name: controller.getDiamondIcon(), width: 64.w, height: 64.w),
              ),
            ],
          ),
        ),
      ),
    ],
  );

  _bottomWidget()=>Align(
    alignment: Alignment.bottomCenter,
    child: SizedBox(
      width: double.infinity,
      height: 356.h,
      child: Stack(
        children: [
          HissImagesWidget(name: "pig2", width: double.infinity, height: double.infinity),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top: 22.h),
              child: GetBuilder<BBBHissPigController>(
                id: "tips",
                builder: (_)=>HissGradientTextWidget(
                  textContent: "Reach ${controller.reachNum} to unlock the Diamond Bank.",
                  textSize: 16.sp,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: ["#FFFFFF".toColor(),"#FFF174".toColor(),],
                  ),
                  outlineColor: "#821600".toColor(),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _listWidget(),
                SizedBox(height: 10.h,),
                _progressWidget(),
                SizedBox(height: 30.h,),
                _collectBtnWidget(),
                SizedBox(height: 30.h,),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  _listWidget()=>GetBuilder<BBBHissPigController>(
    id: "list",
    builder: (_)=>Row(
      children: [
        SizedBox(width: 12.w,),
        Expanded(
          child: SizedBox(
            width: double.infinity,
            height: 68.w,
            child: ListView.builder(
              itemCount: controller.pigList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context,index){
                var infoBean = controller.pigList[index];
                return SizedBox(
                  width: 68.w,
                  height: 68.w,
                  child: Stack(
                    children: [
                      HissImagesWidget(name: controller.getItemBg(infoBean), width: double.infinity, height: double.infinity),
                      Align(
                        child: HissImagesWidget(name: controller.getItemIcon(infoBean), width: 36.w, height: 36.w),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Visibility(
                          visible: infoBean.status==HissPigStatus.received,
                          child: HissImagesWidget(name: "pig9", width: 24.w, height: 24.w),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Visibility(
                          visible: infoBean.status==HissPigStatus.lock,
                          child: HissImagesWidget(name: "pig10", width: 24.w, height: 24.w),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          margin: EdgeInsets.only(top: 2.h),
                          child: HissGradientTextWidget(
                            textContent: "+${infoBean.addNum??0}",
                            textSize: 16.sp,
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: ["#FFFFFF".toColor(),"#FFF174".toColor(),],
                            ),
                            outlineColor: "#821600".toColor(),
                            fontWeight: FontWeight.bold,
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
        SizedBox(
          width: 84.w,
          height: 84.w,
          child: Stack(
            children: [
              HissImagesWidget(name: controller.getItemBg(controller.lastPigBean), width: double.infinity, height: double.infinity),
              Align(
                child: HissImagesWidget(name: controller.getItemIcon(controller.lastPigBean), width: 52.w, height: 52.w),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Visibility(
                  visible: controller.lastPigBean?.status==HissPigStatus.received,
                  child: HissImagesWidget(name: "pig9", width: 24.w, height: 24.w),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Visibility(
                  visible: controller.lastPigBean?.status==HissPigStatus.lock,
                  child: HissImagesWidget(name: "pig10", width: 24.w, height: 24.w),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: EdgeInsets.only(top: 2.h),
                  child: HissGradientTextWidget(
                    textContent: "+${controller.lastPigBean?.addNum??0}",
                    textSize: 16.sp,
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: ["#FFFFFF".toColor(),"#FFF174".toColor(),],
                    ),
                    outlineColor: "#821600".toColor(),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(width: 12.w,),
      ],
    ),
  );

  _progressWidget()=>Container(
    width: double.infinity,
    margin: EdgeInsets.only(left: 27.w,right: 27.w),
    child: LayoutBuilder(
      builder: (context,bc){
        return Stack(
          alignment: Alignment.centerRight,
          children: [
            Stack(
              alignment: Alignment.centerLeft,
              children: [
                HissImagesWidget(name: "pig4", width: double.infinity, height: 24.h),
                Container(
                  width: double.infinity,
                  height: 18.h,
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 3.w,right: 3.w),
                  child: ClipRect(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      widthFactor: controller.getPro(),
                      child: HissImagesWidget(name: "pig5", width: double.infinity, height: 18.h),
                    ),
                  ),
                ),
              ],
            ),
            HissImagesWidget(name: "icon_diamond", width: 40.w, height: 40.w),
          ],
        );
      },
    ),
  );

  _collectBtnWidget()=>HissClickWidget(
    onTap: (){
      controller.clickGet();
    },
    child: Stack(
      alignment: Alignment.center,
      children: [
        HissImagesWidget(name: "pig3", width: 260.w, height: 52.h),
        HissTextWidget(
          textContent: "Go To Collect",
          textSize: 18.sp,
          textColor: "#FFFFFF".toColor(),
          fontWeight: FontWeight.bold,
          outlineColor: "#3D2703".toColor(),
        ),
      ],
    ),
  );
}