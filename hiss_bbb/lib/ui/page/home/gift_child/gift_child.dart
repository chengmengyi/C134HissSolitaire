import 'package:flutter/material.dart';
import 'package:hiss_bbb/ui/page/home/gift_child/gift_child_controller.dart';
import 'package:hiss_bbb/ui/widget/hiss_video_btn_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_root_child.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_click_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_gradient_text_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_images_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_text_widget.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';
import 'package:hiss_root/hiss_utils/hiss_utils.dart';

class GiftChild extends HissRootChild<GiftChildController>{
  @override
  GiftChildController initGetController() => GiftChildController();

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
            child: HorizontalScroller<String>(
              items: ["哈哈哈","哈哈哈","哈哈哈","哈哈哈","哈哈哈","哈哈哈","哈哈哈","哈哈哈","哈哈哈","哈哈哈","哈哈哈","哈哈哈","哈哈哈","哈哈哈","哈哈哈",],
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
                return Container(
                  width: 60.w,
                  height: 110.h,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 6.w,right: 6.w,),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      HissImagesWidget(name: "home_gift_pay", width: 60.w, height: 60.w,),
                      HissGradientTextWidget(
                        textContent: "\$200 cash",
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
                            textContent: "1/20",
                            textSize: 10.sp,
                            fontWeight: FontWeight.w900,
                            textColor: "#FFFFFF".toColor(),
                            outlineColor: "#005B95".toColor(),
                          ),
                        ],
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

  _rewardListWidget()=>SizedBox(
    width: double.infinity,
    height: 52.w,
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context,index){
        return SizedBox(
          width: 52.w,
          height: 52.w,
          child: Stack(
            children: [
              HissImagesWidget(name: "home_gift4", width: 52.w, height: 52.w),
              Align(
                child: HissImagesWidget(name: "home_gift_pay", width: 40.w, height: 40.w,),
              ),
              Align(
                alignment: Alignment.topRight,
                child: HissImagesWidget(name: "icon_video", width: 20.w, height: 20.w,),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context,index)=>SizedBox(width: 20.w,),
      itemCount: 10,
    ),
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
                          return MasonryGridView.count(
                            padding: const EdgeInsets.all(0),
                            itemCount: 8,
                            shrinkWrap: true,
                            crossAxisCount: 4,
                            mainAxisSpacing: 8.h,
                            crossAxisSpacing: 7.w,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context,index){
                              return Stack(
                                alignment: Alignment.center,
                                children: [
                                  HissImagesWidget(name: "home_gift9", width: double.infinity, height: height,),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      HissImagesWidget(name: "home_gift_pay", width: height*0.6, height: height*0.6,),
                                      HissGradientTextWidget(
                                        textContent: "\$200 cash",
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
                          );
                        },
                      ),
                    ),
                    HissVideoBtnWidget(
                      text: "Spin",
                      bg: "home_gift8",
                      width: double.infinity,
                      height: 52.h,
                      onTap: (){
                        controller.clickSpin();
                      },
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