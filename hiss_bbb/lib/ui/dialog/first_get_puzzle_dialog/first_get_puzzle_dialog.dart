import 'package:flutter/material.dart';
import 'package:hiss_bbb/bean/hiss_home_gift_progress_bean.dart';
import 'package:hiss_bbb/ui/dialog/first_get_puzzle_dialog/first_get_puzzle_dialog_controller.dart';
import 'package:hiss_bbb/utils/utils.dart';
import 'package:hiss_root/hiss_ui/hiss_root_dialog.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_click_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_gradient_text_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_images_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_text_widget.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';
import 'package:hiss_root/hiss_utils/hiss_utils.dart';

class FirstGetPuzzleDialog extends HissRootDialog<FirstGetPuzzleDialogController>{
  Function() toPuzzlePageCallback;
  FirstGetPuzzleDialog({
    required this.toPuzzlePageCallback,
});

  @override
  FirstGetPuzzleDialogController initGetController() => FirstGetPuzzleDialogController();

  @override
  Widget initContent() => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      HissImagesWidget(name: "first5", width: 292.w, height: 188.h),
      SizedBox(height: 97.h,),
      _giftWidget(),
      SizedBox(height: 97.h,),
      _btnWidget(),
    ],
  );

  _btnWidget()=>Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      HissClickWidget(
        onTap: (){
          controller.clickToGift(toPuzzlePageCallback);
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            HissImagesWidget(name: "btn4", width: 260.w, height: 50.h),
            HissTextWidget(textContent: "Collect & Earn", textSize: 18.sp, textColor: "#FFFFFF".toColor(),),
          ],
        ),
      ),
      SizedBox(height: 10.h,),
      HissClickWidget(
        onTap: (){
          controller.clickClose();
        },
        child: HissTextWidget(
          textContent: "View Later",
          textSize: 18.sp,
          textColor: "#FFFFFF".toColor(),
          decoration: TextDecoration.underline,
          decorationColor: "#FFFFFF".toColor(),
        ),
        // child: Stack(
        //   alignment: Alignment.center,
        //   children: [
        //     HissImagesWidget(name: "btn5", width: 260.w, height: 50.h),
        //     HissTextWidget(textContent: "View Later", textSize: 18.sp, textColor: "#FFFFFF".toColor(),),
        //   ],
        // ),
      ),
    ],
  );
  
  _giftWidget()=>Container(
    width: double.infinity,
    height: 110.h,
    margin: EdgeInsets.only(left: 32.w,right: 32.w,bottom: 12.h),
    child: GetBuilder<FirstGetPuzzleDialogController>(
      id: "top_list",
      builder: (_){
        if(controller.topGiftList.isEmpty){
          return Container();
        }
        return HorizontalScroller<HissHomeGiftProgressBean>(
          items: controller.topGiftList,
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
              width: 80.w,
              height: 130.h,
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 6.w,right: 6.w,),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      HissImagesWidget(name: getGiftIcon(item.type), width: 80.w, height: 80.w,),
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
                ],
              ),
            );
          },
        );
      },
    ),
  );
}