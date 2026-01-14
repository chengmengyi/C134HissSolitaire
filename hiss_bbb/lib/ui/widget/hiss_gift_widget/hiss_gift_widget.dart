import 'package:hiss_bbb/ui/widget/hiss_gift_widget/hiss_gift_widget_controller.dart';
import 'package:hiss_bbb/utils/hiss_enum/hiss_home_gift_type.dart';
import 'package:hiss_root/hiss_ui/hiss_root_widget.dart';
import 'package:flutter/material.dart';
import 'package:hiss_bbb/bean/hiss_home_gift_progress_bean.dart';
import 'package:hiss_bbb/ui/widget/hiss_video_btn_widget.dart';
import 'package:hiss_bbb/utils/hiss_storage.dart';
import 'package:hiss_bbb/utils/utils.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_click_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_gradient_text_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_images_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_text_widget.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';
import 'package:hiss_root/hiss_utils/hiss_utils.dart';

class HissGiftWidget extends HissRootWidget<HissGiftWidgetController>{
  String tagStr;
  bool fromHomeTab;
  HissGiftWidget({
    required this.tagStr,
    this.fromHomeTab=false,
});

  @override
  String controllerTag() => "HissGiftWidgetController_$tagStr";

  @override
  HissGiftWidgetController initGetController() => HissGiftWidgetController(fromHomeTab);

  @override
  Widget initContent() => Stack(
    children: [
      HissImagesWidget(name: "home_gift2", width: double.infinity, height: double.infinity,),
      Column(
        children: [
          _topWidget(),
          SizedBox(height: 6.h,),
          _rewardListWidget(),
          SizedBox(height: 6.h,),
          HissImagesWidget(name: "home_gift5", width: double.infinity, height: 48.h,),
          _luckyWidget(),
        ],
      ),
    ],
  );

  _topWidget()=>Container(
    width: double.infinity,
    height: 264.h,
    margin: EdgeInsets.only(left: 12.w,right: 12.w,top: 54.h),
    child: Stack(
      children: [
        HissImagesWidget(name: "home_gift1", width: double.infinity, height: double.infinity,),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            height: 110.h,
            margin: EdgeInsets.only(left: 32.w,right: 32.w,bottom: 12.h),
            child: GetBuilder<HissGiftWidgetController>(
              id: "top_list",
              tag: controllerTag(),
              builder: (_){
                if(controller.topGiftList.isEmpty){
                  return Container();
                }
                final payAndPhoneList = <HissHomeGiftProgressBean>[];
                final otherList = <HissHomeGiftProgressBean>[];

                HissHomeGiftProgressBean? payItem;
                HissHomeGiftProgressBean? phoneItem;

                for (final item in controller.topGiftList) {
                  if (item.type == HissHomeGiftType.pay) {
                    payItem ??= item;
                  } else if (item.type == HissHomeGiftType.phone) {
                    phoneItem ??= item;
                  } else {
                    otherList.add(item);
                  }
                }

                if (payItem != null) {
                  payAndPhoneList.add(payItem);
                }
                if (phoneItem != null) {
                  payAndPhoneList.add(phoneItem);
                }
                return Row(
                  children: [
                    SizedBox(
                      height: 110.h,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: payAndPhoneList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context,index)=>_topRewardItemWidget(payAndPhoneList[index]),
                      ),
                    ),
                    Expanded(
                      child: HorizontalScroller<HissHomeGiftProgressBean>(
                        items: otherList,
                        height: 110.h,
                        enableAutoScroll: true,
                        scrollSpeed: 60,
                        enableInfiniteScroll: true,
                        backgroundColor: Colors.transparent,
                        itemPadding: EdgeInsets.zero,
                        margin: EdgeInsets.zero,
                        onItemClick: (item, index) {
                        },
                        itemBuilder: (item, index) {
                          return _topRewardItemWidget(item);
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: GetBuilder<HissGiftWidgetController>(
            id: "top_right_view",
            tag: controllerTag(),
            builder: (_){
              if(null==controller.hissGiftRewardTaskBean){
                return Container();
              }
              return HissClickWidget(
                onTap: (){
                  controller.showSpinRewardTaskDialog(controller.hissGiftRewardTaskBean?.type);
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    HissImagesWidget(name: "home_gift11", width: 48.w, height: 48.w),
                    HissImagesWidget(name: getGiftIcon(controller.hissGiftRewardTaskBean?.type), width: 40.w, height: 40.w),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    ),
  );

  _topRewardItemWidget(HissHomeGiftProgressBean item)=>HissClickWidget(
    onTap: (){
      controller.clickTopGiftItem(item);
    },
    child: Container(
      width: 60.w,
      height: 110.h,
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: 6.w,right: 6.w,),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              HissImagesWidget(name: getGiftIcon(item.type), width: 60.w, height: 60.w,),
              HissImagesWidget(name: "icon_suipian", width: 20.w, height: 20.w,),
            ],
          ),
          HissGradientTextWidget(
            textContent: getGiftShortName(item.type),
            textSize: 10.sp,
            outlineColor: "#5D3E00".toColor(),
            fontWeight: FontWeight.w900,
            overflow: TextOverflow.ellipsis,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: ["#FFFFFF".toColor(),"#FFD659".toColor(),],
            ),
          ),
          SizedBox(height: 4.h,),
          Stack(
            alignment: Alignment.center,
            children: [
              HissImagesWidget(name: "home_gift3", width: 52.w, height: 16.h,),
              HissTextWidget(
                textContent: "${item.currentPro??0}/${item.totalPro??0}",
                textSize: 10.sp,
                fontWeight: FontWeight.w900,
                textColor: "#FFFFFF".toColor(),
                outlineColor: "#005B95".toColor(),
              ),
            ],
          ),
        ],
      ),
    ),
  );

  _rewardListWidget()=>SizedBox(
    width: double.infinity,
    height: 52.w,
    child: Directionality(
      textDirection: TextDirection.rtl,
      child: HorizontalScroller<String>(
        items: controller.centerGiftTypeList,
        height: 52.h,
        enableAutoScroll: true,
        scrollSpeed: 60,
        enableInfiniteScroll: true,
        backgroundColor: Colors.transparent,
        itemPadding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
        onItemClick: (item, index) {
        },
        itemBuilder: (item, index) {
          var type = controller.centerGiftTypeList[index];
          return HissClickWidget(
            onTap: (){
              controller.clickCenterGift(type);
            },
            child: Container(
              width: 52.w,
              height: 52.w,
              margin: EdgeInsets.only(left: 10.w,right: 10.w),
              child: Stack(
                children: [
                  HissImagesWidget(name: "home_gift4", width: 52.w, height: 52.w),
                  Align(
                    child: HissImagesWidget(name: getGiftIcon(type), width: 40.w, height: 40.w,),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: HissImagesWidget(name: "icon_video", width: 20.w, height: 20.w,),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    )
    // ListView.separated(
    //   scrollDirection: Axis.horizontal,
    //   itemBuilder: (context,index){
    //     var type = controller.centerGiftTypeList[index];
    //     return HissClickWidget(
    //       onTap: (){
    //         controller.clickCenterGift(type);
    //       },
    //       child: SizedBox(
    //         width: 52.w,
    //         height: 52.w,
    //         child: Stack(
    //           children: [
    //             HissImagesWidget(name: "home_gift4", width: 52.w, height: 52.w),
    //             Align(
    //               child: HissImagesWidget(name: getGiftIcon(type), width: 40.w, height: 40.w,),
    //             ),
    //             Align(
    //               alignment: Alignment.topRight,
    //               child: HissImagesWidget(name: "icon_video", width: 20.w, height: 20.w,),
    //             ),
    //           ],
    //         ),
    //       ),
    //     );
    //   },
    //   separatorBuilder: (context,index)=>SizedBox(width: 20.w,),
    //   itemCount: controller.centerGiftTypeList.length,
    // ),
  );

  _luckyWidget()=>Expanded(
    child: Stack(
      children: [
        HissImagesWidget(name: "home_gift6", width: double.infinity, height: double.infinity,),
        Container(
          width: double.infinity,
          height: double.infinity,
          margin: EdgeInsets.only(bottom: 76.h),
          child: Stack(
            children: [
              HissImagesWidget(name: "home_gift7", width: double.infinity, height: double.infinity,),
              Container(
                margin: EdgeInsets.only(left: 24.w,right: 20.w,top: 18.h,bottom: 18.h,),
                child: Column(
                  children: [
                    Expanded(
                      child: LayoutBuilder(
                        builder: (context,bc){
                          var height = (bc.maxHeight-(8.h))/2;
                          return GetBuilder<HissGiftWidgetController>(
                            id: "wheel",
                            tag: controllerTag(),
                            builder: (_)=>MasonryGridView.count(
                              padding: const EdgeInsets.all(0),
                              itemCount: controller.wheelList.length,
                              shrinkWrap: true,
                              crossAxisCount: 4,
                              mainAxisSpacing: 8.h,
                              crossAxisSpacing: 7.w,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context,index){
                                var type = controller.wheelList[index];
                                String icon=type.isEmpty?"icon_money3":getGiftIcon(type);
                                String title=type.isEmpty?"\$50":getGiftShortName(type);
                                var selected = controller.selectedWheelIndex==index;
                                return Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    HissImagesWidget(name: selected?"home_gift10":"home_gift9", width: double.infinity, height: height,),
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        HissImagesWidget(name: icon, width: height*0.6, height: height*0.6,),
                                        HissGradientTextWidget(
                                          textContent: title,
                                          textSize: 10.sp,
                                          outlineColor: "#5D3E00".toColor(),
                                          fontWeight: FontWeight.w900,
                                          overflow: TextOverflow.ellipsis,
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: ["#FFFFFF".toColor(),"#FFD659".toColor(),],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    GetBuilder<HissGiftWidgetController>(
                      id: "wheel_btn",
                      tag: controllerTag(),
                      builder: (_)=>HissVideoBtnWidget(
                        text: "Spin(${wheelNum.getData()})",
                        bg: "home_gift8",
                        width: double.infinity,
                        height: 52.h,
                        showVideoIcon: wheelNum.getData()<=0,
                        onTap: (){
                          controller.clickSpin();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}