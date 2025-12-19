import 'package:flutter/material.dart';
import 'package:hiss_bbb/bean/hiss_gift_bean.dart';
import 'package:hiss_bbb/ui/page/gift/bbb_hiss_gift_controller.dart';
import 'package:hiss_bbb/utils/hiss_enum/hiss_gift_type.dart';
import 'package:hiss_root/hiss_ui/hiss_root_page.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_click_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_images_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_text_widget.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';
import 'package:hiss_root/hiss_utils/hiss_utils.dart';

class BBBHissGiftPage extends HissRootPage<BBBHissGiftController>{
  @override
  BBBHissGiftController initGetController() => BBBHissGiftController();

  @override
  Widget initContent() => Stack(
    children: [
      Column(
        children: [
          HissImagesWidget(name: "gift1", width: double.infinity, height: 260.h),
          Expanded(
            child: Stack(
              children: [
                HissImagesWidget(name: "gift2", width: double.infinity, height: double.infinity,),
                _giftListWidget(),
              ],
            ),
          ),
        ],
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
    ],
  );

  _giftListWidget()=>Container(
    width: double.infinity,
    height: double.infinity,
    margin: EdgeInsets.only(left: 48.w,right: 48.w,top: 28.h),
    child: MediaQuery.removePadding(
      context: buildContext,
      removeTop: true,
      removeBottom: true,
      child: GetBuilder<BBBHissGiftController>(
        id: "list",
        builder: (_)=>ListView.builder(
          itemCount: controller.giftList.length,
          itemBuilder: (context,index){
            var list = controller.giftList[index];
            return Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 30.w,right: 30.w),
                  child: HissImagesWidget(name: controller.getItemRowLineBg(index, list), width: double.infinity, height: 24.h),
                ),
                Row(
                  children: [
                    _giftItemWidget(index,0,list.first),
                    _giftItemWidget(index,1,list.last),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    ),
  );

  _giftItemWidget(int largeIndex,int smallIndex, HissGiftBean bean)=>Expanded(
    child: Container(
      width: double.infinity,
      height: 144.w,
      alignment: smallIndex==0?Alignment.centerLeft:Alignment.centerRight,
      child: SizedBox(
        width: 108.w,
        height: 144.w,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  Expanded(
                    child: Visibility(
                      visible: controller.showTopColLine(largeIndex, smallIndex),
                      child: HissImagesWidget(name: controller.getTopColLineImages(largeIndex), width: 24.w, height: double.infinity),
                    ),
                  ),
                  Expanded(
                    child: Visibility(
                      visible: controller.showBottomColLine(largeIndex, smallIndex),
                      child: HissImagesWidget(name: controller.getBottomColLineImages(bean), width: 24.w, height: double.infinity),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 108.w,
                height: 108.w,
                child: Stack(
                  children: [
                    HissImagesWidget(name: controller.getItemBg(bean), width: 108.w, height: 108.w),
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          HissImagesWidget(name: controller.getItemGiftIcon(bean), width: 56.w, height: 56.w),
                          SizedBox(height: 4.h,),
                          HissTextWidget(
                            textContent: "+${bean.addNum??0}",
                            textSize: 14.sp,
                            textColor: controller.getItemTextColor(bean),
                            outlineColor: controller.getItemTextLineColor(bean),
                            fontWeight: FontWeight.w900,
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Visibility(
                        visible: bean.giftStatus==HissGiftStatus.received,
                        child: HissImagesWidget(name: "gift10", width: 24.w, height: 24.w),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Visibility(
                        visible: bean.showAd==1,
                        child: HissImagesWidget(name: "icon_video", width: 32.w, height: 32.w),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Visibility(
                visible: bean.giftStatus==HissGiftStatus.unReceive,
                child: Container(
                  margin: EdgeInsets.only(bottom: 6.h),
                  child: HissClickWidget(
                    onTap: (){
                      controller.clickClaim(bean);
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        HissImagesWidget(name: "gift11", width: 84.w, height: 32.h),
                        HissTextWidget(
                          textContent: "Claim",
                          textSize: 14.sp,
                          textColor: "#FFFFFF".toColor(),
                          outlineColor: "#133D03".toColor(),
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}