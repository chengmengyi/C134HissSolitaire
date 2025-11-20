import 'package:flutter/material.dart';
import 'package:hiss_aaa/ui/page/rank/hiss_rank_controller.dart';
import 'package:hiss_root/hiss_ui/hiss_root_page.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_click_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_gradient_text_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_images_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_text_widget.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';
import 'package:hiss_root/hiss_utils/hiss_utils.dart';

class HissRankPage extends HissRootPage<HissRankController>{

  @override
  HissRankController initGetController() => HissRankController();

  @override
  Widget initContent() => Stack(
    children: [
      SizedBox(
        width: double.infinity,
        height: 300.h,
        child: Stack(
          children: [
            HissImagesWidget(name: "rank1", width: double.infinity, height: 300.h),
            Align(
              alignment: Alignment.center,
              child: _topWidget(),
            ),
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.only(top: 264.h),
        child: Stack(
          children: [
            HissImagesWidget(name: "rank2", width: double.infinity, height: double.infinity),
            _rankListWidget(),
          ],
        ),
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

  _rankListWidget()=>Container(
    margin: EdgeInsets.only(top: 80.h,left: 12.w,right: 12.w,),
    child: Column(
      children: [
        Row(
          children: [
            SizedBox(width: 8.w,),
            HissGradientTextWidget(
              textContent: "Pank",
              textSize: 12.sp,
              fontWeight: FontWeight.bold,
              outlineColor: "#042319".toColor(),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: ["#FFFFFF".toColor(),"#FFF09C".toColor(),],
              ),
            ),
            SizedBox(width: 56.w,),
            HissGradientTextWidget(
              textContent: "Player",
              textSize: 12.sp,
              fontWeight: FontWeight.bold,
              outlineColor: "#042319".toColor(),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: ["#FFFFFF".toColor(),"#FFF09C".toColor(),],
              ),
            ),
            SizedBox(width: 104.w,),
            HissGradientTextWidget(
              textContent: "Rewards",
              textSize: 12.sp,
              fontWeight: FontWeight.bold,
              outlineColor: "#042319".toColor(),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: ["#FFFFFF".toColor(),"#FFF09C".toColor(),],
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h,),
        Expanded(
          child: MediaQuery.removePadding(
            context: buildContext,
            removeTop: true,
            removeBottom: true,
            child: ListView.builder(
              itemBuilder: (context,index)=>_rankItemWidget(index),
            ),
          ),
        ),
      ],
    ),
  );

  _rankItemWidget(int index)=>Container(
    width: double.infinity,
    height: 64.h,
    margin: EdgeInsets.only(top: 4.h),
    child: Stack(
      alignment: Alignment.centerLeft,
      children: [
        HissImagesWidget(name: "rank6", width: double.infinity, height: double.infinity,),
        Row(
          children: [
            Stack(
              alignment: Alignment.centerRight,
              children: [
                HissImagesWidget(name: "rank8", width: 44.w, height: 36.h),
                Container(
                  margin: EdgeInsets.only(right: 12.w),
                  child: HissTextWidget(
                    textContent: "${index+1}",
                    textSize: 16.sp,
                    textColor: "#FFFFFF".toColor(),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(width: 4.w,),
            Container(
              width: 40.w,
              height: 40.w,
              color: Colors.red,
            ),
            SizedBox(width: 8.w,),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HissTextWidget(
                    textContent: "Nannanal",
                    textSize: 14.sp,
                    textColor: "#FFFFFF".toColor(),
                    fontWeight: FontWeight.w900,
                  ),
                  SizedBox(height: 4.h,),
                  HissTextWidget(textContent: "Level:100", textSize: 12.sp, textColor: "#F9C347".toColor(),fontWeight: FontWeight.bold,),
                ],
              ),
            ),
            HissImagesWidget(name: "icon_diamond", width: 28.w, height: 28.w,),
            SizedBox(width: 4.w,),
            HissTextWidget(
              textContent: "100",
              textSize: 14.sp,
              textColor: "#FFFFFF".toColor(),
              outlineColor: "#052B1F".toColor(),
              fontWeight: FontWeight.w900,
            ),
            SizedBox(width: 14.w,),
            HissImagesWidget(name: "icon_money2", width: 28.w, height: 28.w,),
            SizedBox(width: 4.w,),
            HissTextWidget(
              textContent: "100",
              textSize: 14.sp,
              textColor: "#FFFFFF".toColor(),
              outlineColor: "#052B1F".toColor(),
              fontWeight: FontWeight.w900,
            ),
            SizedBox(width: 14.w,),
          ],
        ),
      ],
    ),
  );

  _topWidget()=>Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Stack(
        alignment: Alignment.topCenter,
        children: [
          HissImagesWidget(name: "rank3", width: 260.w, height: 136.h),
          Container(
            margin: EdgeInsets.only(top: 4.h),
            child: HissTextWidget(
              textContent: "2025.10.19",
              textSize: 12.sp,
              textColor: "#FFFFFF".toColor(),
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _rankTop3ItemWidget(1),
          SizedBox(width: 12.w,),
          _rankTop3ItemWidget(0),
          SizedBox(width: 12.w,),
          _rankTop3ItemWidget(3),
        ],
      ),
    ],
  );

  _rankTop3ItemWidget(int index)=>Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Stack(
        children: [
          HissImagesWidget(name: index==1?"rank4":index==0?"rank5":"rank9", width: 80.w, height: 80.w,),
        ],
      ),
      HissGradientTextWidget(
        textContent: "Aillya",
        textSize: 12.sp,
        fontWeight: FontWeight.bold,
        outlineColor: "#3A230F".toColor(),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: ["#FFFFFF".toColor(),"#FFE88C".toColor(),]
        ),
      ),
    ],
  );
}