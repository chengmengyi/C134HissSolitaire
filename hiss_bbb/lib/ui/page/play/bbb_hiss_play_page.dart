import 'package:flutter/material.dart';
import 'package:hiss_bbb/bean/hiss_card_bean.dart';
import 'package:hiss_bbb/ui/page/play/bbb_hiss_play_controller.dart';
import 'package:hiss_bbb/ui/widget/hiss_bubble_widget.dart';
import 'package:hiss_bbb/ui/widget/hiss_card_item_widget.dart';
import 'package:hiss_bbb/ui/widget/hiss_deal_card_animator_widget.dart';
import 'package:hiss_bbb/ui/widget/hiss_diamond_pig_animator_widget.dart';
import 'package:hiss_bbb/ui/widget/hiss_gift_puzzle_animator_widget.dart';
import 'package:hiss_bbb/ui/widget/hiss_hint_animator_widget.dart';
import 'package:hiss_bbb/ui/widget/hiss_move_to_card_list_animator_widget.dart';
import 'package:hiss_bbb/ui/widget/hiss_move_to_foundation_animator_widget.dart';
import 'package:hiss_bbb/ui/widget/hiss_move_to_waste_animator_widget.dart';
import 'package:hiss_bbb/ui/widget/hiss_pig_widget.dart';
import 'package:hiss_bbb/ui/widget/hiss_prop_animator_widget.dart';
import 'package:hiss_bbb/ui/widget/hiss_super_prop_animator_widget.dart';
import 'package:hiss_bbb/ui/widget/hiss_top_widget.dart';
import 'package:hiss_bbb/ui/widget/hiss_waste_move_animator_widget.dart';
import 'package:hiss_bbb/utils/hiss_storage.dart';
import 'package:hiss_bbb/utils/utils.dart';
import 'package:hiss_root/hiss_ui/hiss_root_page.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_click_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_gradient_text_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_images_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_text_widget.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';
import 'package:hiss_root/hiss_utils/hiss_utils.dart';

class BBBHissPlayPage extends HissRootPage<BBBHissPlayController>{
  @override
  BBBHissPlayController initGetController() => BBBHissPlayController();

  @override
  Widget initContent() => Stack(
    children: [
      HissImagesWidget(name: "play_bg", width: double.infinity, height: double.infinity),
      Column(
        children: [
          HissTopWidget(
            moneyGlobalKey: controller.topMoneyGlobalKey,
            clickSetCallback: (){
              controller.clickSet();
            },
            clickDiamondCallback: (){
              controller.clickPig();
            },
            clickMoneyCallback: (){
              controller.toCashPage();
            },
          ),
          _playInfoWidget(),
          SizedBox(height: 20.h,),
          _foundationsAndStockPileWidget(),
          SizedBox(height: 24.h,),
          _cardListWidget(),
          _bottomWidget(),
        ],
      ),
      _giftGuideWidget(),
      _emptyPlaceWidget(),
      HissSuperPropAnimatorWidget(),
      HissDealCardAnimatorWidget(
        allAnimatorCompletedCallback: (){
          controller.onAllAnimationsCompleted();
        },
      ),
      HissWasteMoveAnimatorWidget(),
      HissMoveToWasteAnimatorWidget(),
      HissHintAnimatorWidget(),
      HissPropAnimatorWidget(),
      HissDiamondPigAnimatorWidget(),
      HissGiftPuzzleAnimatorWidget(),
      HissMoveToFoundationAnimatorWidget(),
      HissMoveToCardListAnimatorWidget(),
      HissBubbleWidget(),
    ],
  );

  _foundationsAndStockPileWidget()=>Row(
    children: [
      SizedBox(width: 16.w,),
      GetBuilder<BBBHissPlayController>(
        id: "foundations",
        builder: (_){
          if(controller.cardWidth<=0){
            return Container();
          }
          return SizedBox(
            height: controller.cardHeight,
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: controller.foundationsList.length,
              itemBuilder: (context,index){
                var list = controller.foundationsList[index];
                Widget widget;
                if(list.isEmpty){
                  widget = HissImagesWidget(name: "card_a", width: controller.cardWidth, height: controller.cardHeight);
                }else{
                  widget = HissImagesWidget(name: getCardImages(list.last), width: controller.cardWidth, height: controller.cardHeight,);
                }
                return SizedBox(
                  key: controller.foundationsGlobalKeyList[index],
                  child: DragTarget<Map<String, dynamic>>(
                    onWillAccept: (data) {
                      return controller.foundationsOnWillAccept(data,index);
                    },
                    onAccept: (data) {
                      controller.foundationsOnAccept(data,index);
                    },
                    builder: (context, candidateData, rejectedData) {
                      return widget;
                    },
                  ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(width: 6.w,),
            ),
          );
        },
      ),
      SizedBox(width: 6.w,),
      GetBuilder<BBBHissPlayController>(
        id: "stock_pile",
        builder: (_){
          if(controller.cardWidth<=0){
            return Container();
          }
          var marginLeft = (controller.cardWidth+(6.w))/2;
          return SizedBox(
            width: controller.cardWidth*2+(6.w),
            height: controller.cardHeight,
            child: Stack(
              children: List.generate(controller.wastePileList.length, (index){
                var bean = controller.wastePileList[index];
                double left = marginLeft * (index + (3 - controller.wastePileList.length));
                return Container(
                  key: bean.globalKey,
                  margin: EdgeInsets.only(left: left),
                  child: Draggable<Map<String, dynamic>>(
                    data: {"fromWaste": true, "cards": [controller.wastePileList[index]]},
                    onDragStarted: () {
                      controller.onDragStockPileStarted();
                    },
                    onDragCompleted: () {
                      controller.onDragStockPileCompleted();
                    },
                    onDraggableCanceled: (velocity, offset) {
                      controller.onDraggableStockPileCanceled();
                    },
                    feedback: _dragFeedbackWidget([bean]),
                    childWhenDragging: Opacity(
                      opacity: 0.5,
                      child: HissImagesWidget(
                        name: getCardImages(bean),
                        width: controller.cardWidth,
                        height: controller.cardHeight,
                      ),
                    ),
                    child: HissImagesWidget(
                      name: getCardImages(bean),
                      width: controller.cardWidth,
                      height: controller.cardHeight,
                    ),
                  ),
                );
              }),
            ),
          );
        },
      ),
      SizedBox(width: 6.w,),
      GetBuilder<BBBHissPlayController>(
        id: "card_bg",
        builder: (_){
          if(controller.cardWidth<=0){
            return Container();
          }
          return Visibility(
            maintainAnimation: true,
            maintainState: true,
            maintainSize: true,
            visible: controller.stockPileList.isNotEmpty,
            child: HissClickWidget(
              onTap: (){
                controller.clickFlipCardFromStock();
              },
              child: SizedBox(
                key: controller.stockPileGlobalKey,
                child: ShakeAnimationWidget(
                  shakeAnimationController: controller.shakeAnimationController,
                  shakeAnimationType: ShakeAnimationType.LeftRightShake,
                  isForward: false,
                  shakeCount: 4,
                  shakeRange: 0.2,
                  child: HissImagesWidget(name: "card_bg", width: controller.cardWidth, height: controller.cardHeight,),
                ),
              ),
            ),
          );
        },
      ),
      SizedBox(width: 16.w,),
    ],
  );

  _cardListWidget()=>Expanded(
    child: Container(
      margin: EdgeInsets.only(left: 16.w,right: 16.w),
      child: GetBuilder<BBBHissPlayController>(
        id: "card_list",
        builder: (_)=>Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(controller.cardList.length, (index){
            return Expanded(
              child: _cardColumnItemWidget(controller.cardList[index],index),
            );
          }),
        ),
      ),
    ),
  );

  _cardColumnItemWidget(List<HissCardBean> list,colIndex)=>Center(
    child: DragTarget<Map<String, dynamic>>(
      onWillAccept: (data){
        return controller.onAcceptWithDetails(data, colIndex);
      },
      onAccept: (data){
        controller.onAccept(data,colIndex);
      },
      builder: (context, candidateData, rejectedData){
        var length = list.length;
        return SizedBox(
          height: double.infinity,
          child: Stack(
            children: List.generate(length==0?1:length, (rowIndex){
              if(length==0){
                return HissImagesWidget(name: "icon_empty_place", width: controller.cardWidth, height: controller.cardHeight);
              }
              var bean = list[rowIndex];
              if(controller.isCardBeingDragged(colIndex, rowIndex)){
                return Container(
                  margin: EdgeInsets.only(top: rowIndex * (8.h)),
                  child: SizedBox(
                    width: controller.cardWidth,
                    height: controller.cardHeight,
                  ),
                );
              }
              var itemWidget = _cardItemWidget(bean);
              Widget childWidget;
              if(bean.front){
                childWidget=HissClickWidget(
                  onTap: (){
                    controller.tryAutoMoveToFoundation(colIndex, rowIndex,list);
                  },
                  child: LongPressDraggable<Map<String, dynamic>>(
                    delay: Duration(milliseconds: 80),
                    hitTestBehavior: HitTestBehavior.translucent,
                    data: {
                      "fromCol": colIndex,
                      "startIndex": rowIndex,
                      "cards": list.sublist(rowIndex),
                      "fromWaste": false
                    },
                    onDragStarted: () {
                      controller.onDragStarted(colIndex,rowIndex);
                    },
                    onDragCompleted: () {
                      controller.onDragCompleted();
                    },
                    onDraggableCanceled: (velocity, offset) {
                      controller.onDraggableCanceled();
                    },
                    feedback: _dragFeedbackWidget(list.sublist(rowIndex)),
                    childWhenDragging: Opacity(
                      opacity: 0.5,
                      child: HissImagesWidget(
                        name: getCardImages(bean),
                        width: controller.cardWidth,
                        height: controller.cardHeight,
                      ),
                    ),
                    child: itemWidget,
                  ),
                );
              }else{
                childWidget=itemWidget;
              }
              return Container(
                margin: EdgeInsets.only(top: rowIndex * (12.h)),
                child: SizedBox(
                  key: bean.globalKey,
                  child: bean.showCard?
                  childWidget:
                  SizedBox(
                    width: controller.cardWidth,
                    height: controller.cardHeight,
                  ),
                ),
              );
            }),
          ),
        );
      },
    ),
  );

  _dragFeedbackWidget(List<HissCardBean> cards) => Transform.scale(
    scale: 1.05,
    child: Material(
      color: Colors.transparent,
      child: SizedBox(
        width: controller.cardWidth,
        height: controller.cardHeight + (8.h) * (cards.length - 1),
        child: Stack(
          children: List.generate(cards.length, (i) {
            return Positioned(
              top: i * (8.h),
              child: HissImagesWidget(
                name: getCardImages(cards[i]),
                width: controller.cardWidth,
                height: controller.cardHeight,
              ),
            );
          }),
        ),
      ),
    ),
  );

  _cardItemWidget(HissCardBean bean,{bool isDragging = false})=>HissCardItemWidget(
    cardBean: bean,
    cardWidth: controller.cardWidth,
    cardHeight: controller.cardHeight,
  );

  _playInfoWidget()=> Container(
    width: double.infinity,
    height: 72.h,
    margin: EdgeInsets.only(left: 12.w,right: 12.w,top: 20.h),
    child: Stack(
      children: [
        HissImagesWidget(name: "play1", width: double.infinity, height: double.infinity),
        Row(
          children: [
            SizedBox(width: 16.w,),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GetBuilder<BBBHissPlayController>(
                      id: "level",
                      builder: (_)=>HissGradientTextWidget(
                        textContent: "${bLevel.getData()}",
                        textSize: 16.sp,
                        fontWeight: FontWeight.w900,
                        outlineColor: "#943D00".toColor(),
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: ["#FFB62D".toColor(),"#FF5C05".toColor(),]
                        ),
                      ),
                    ),
                    HissTextWidget(textContent: "Level", textSize: 12.sp, textColor: "#925B33".toColor(),),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GetBuilder<BBBHissPlayController>(
                      id: "score",
                      builder: (_)=>HissGradientTextWidget(
                        textContent: "${controller.currentScore}",
                        textSize: 16.sp,
                        fontWeight: FontWeight.w900,
                        outlineColor: "#943D00".toColor(),
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: ["#FFB62D".toColor(),"#FF5C05".toColor(),]
                        ),
                      ),
                    ),
                    HissTextWidget(textContent: "Score", textSize: 12.sp, textColor: "#925B33".toColor(),),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GetBuilder<BBBHissPlayController>(
                      id: "time",
                      builder: (_)=>HissGradientTextWidget(
                        textContent: formatHMS(controller.currentTime),
                        textSize: 14.sp,
                        fontWeight: FontWeight.w900,
                        outlineColor: "#943D00".toColor(),
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: ["#FFFFFF".toColor(),"#FFCD05".toColor(),]
                        ),
                      ),
                    ),
                    HissTextWidget(textContent: "Time", textSize: 12.sp, textColor: "#925B33".toColor(),),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GetBuilder<BBBHissPlayController>(
                      id: "step",
                      builder: (_)=>HissGradientTextWidget(
                        textContent: "${controller.currentStep}",
                        textSize: 16.sp,
                        fontWeight: FontWeight.w900,
                        outlineColor: "#943D00".toColor(),
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: ["#FFB62D".toColor(),"#FF5C05".toColor(),]
                        ),
                      ),
                    ),
                    HissTextWidget(textContent: "Move", textSize: 12.sp, textColor: "#925B33".toColor(),),
                  ],
                ),
              ),
            ),
            SizedBox(width: 16.w,),
          ],
        ),
      ],
    ),
  );

  _bottomWidget()=>Container(
    margin: EdgeInsets.only(left: 12.w,right: 12.w,bottom: 20.h,),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HissClickWidget(
          onTap: (){
            controller.clickGiftBtn();
          },
          child: Stack(
            alignment: Alignment.topRight,
            key: controller.giftPuzzleGlobalKey,
            children: [
              HissImagesWidget(name: "play11", width: 72.w, height: 72.w,),
              Stack(
                alignment: Alignment.center,
                children: [
                  HissImagesWidget(name: "play10", width: 16.w, height: 16.w),
                  GetBuilder<BBBHissPlayController>(
                    id: "wheel_num",
                    builder: (_)=>HissTextWidget(
                      textContent: "${wheelNum.getData()}",
                      textSize: 10.sp,
                      textColor: "#FFFFFF".toColor(),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        SizedBox(height: 12.h,),
        Row(
          children: [
            SizedBox(
              key: controller.diamondPigGlobalKey,
              child: HissPigWidget(
                clickCallback: (){
                  controller.clickPig();
                },
              ),
            ),
            Spacer(),
            HissClickWidget(
              onTap: (){
                controller.clickAdBtn();
              },
              child: HissImagesWidget(name: "play12", width: 72.w, height: 72.w),
            ),
          ],
        ),
        SizedBox(height: 46.h,),
        Row(
          children: [
            HissClickWidget(
              onTap: (){
                controller.clickHome();
              },
              child: HissImagesWidget(name: "play5", width: 64.w, height: 64.w),
            ),
            Spacer(),
            HissClickWidget(
              onTap: (){
                controller.clickResetPlay();
              },
              child: HissImagesWidget(name: "play6", width: 56.w, height: 56.w),
            ),
            SizedBox(width: 22.w,),
            HissClickWidget(
              onTap: (){
                controller.clickBackProp();
              },
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  SizedBox(
                    key: controller.backPropGlobalKey,
                    child: HissImagesWidget(name: "play7", width: 56.w, height: 56.w),
                  ),
                  GetBuilder<BBBHissPlayController>(
                    id: "back_prop",
                    builder: (_){
                      var data = bBackPropNum.getData();
                      if(data<=0){
                        return HissImagesWidget(name: "play8", width: 16.w, height: 16.w);
                      }
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          HissImagesWidget(name: "play10", width: 16.w, height: 16.w),
                          HissTextWidget(textContent: "$data", textSize: 10.sp, textColor: "#FFFFFF".toColor(),fontWeight: FontWeight.bold,),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(width: 22.w,),
            HissClickWidget(
              onTap: (){
                controller.clickHint();
              },
              child: ShakeAnimationWidget(
                shakeAnimationController: controller.tipsAnimationController,
                shakeAnimationType: ShakeAnimationType.LeftRightShake,
                isForward: false,
                shakeCount: 4,
                shakeRange: 0.2,
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    SizedBox(
                      key: controller.tipsPropGlobalKey,
                      child: HissImagesWidget(name: "play9", width: 56.w, height: 56.w),
                    ),
                    GetBuilder<BBBHissPlayController>(
                      id: "tips_prop",
                      builder: (_){
                        var data = bTipsPropNum.getData();
                        if(data<=0){
                          return HissImagesWidget(name: "play8", width: 16.w, height: 16.w);
                        }
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            HissImagesWidget(name: "play10", width: 16.w, height: 16.w),
                            HissTextWidget(textContent: "$data", textSize: 10.sp, textColor: "#FFFFFF".toColor(),fontWeight: FontWeight.bold,),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  _emptyPlaceWidget()=>Align(
    alignment: Alignment.bottomCenter,
    child: Container(
      margin: EdgeInsets.only(bottom: 148.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _emptyPlaceTipsWidget(),
          GetBuilder<BBBHissPlayController>(
            id: "empty_place",
            builder: (_){
              if(controller.cardWidth<=0){
                return Container();
              }
              return SizedBox(
                height: controller.cardHeight+14.w,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.emptyPlaceList.length,
                  itemBuilder: (context,index){
                    var list = controller.emptyPlaceList[index];
                    Widget? child;
                    if(null==list.hissCardBean){
                      child=HissImagesWidget(name: "icon_empty_place", width: controller.cardWidth, height: controller.cardHeight);
                    }else{
                      child=HissImagesWidget(
                        name: getCardImages(list.hissCardBean),
                        width: controller.cardWidth,
                        height: controller.cardHeight,
                      );
                    }
                    return Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 14.w),
                          child: DragTarget<Map<String, dynamic>>(
                            onWillAccept: (data) {
                              return controller.emptyPlaceOnWillAccept(data,list);
                            },
                            onAccept: (data) {
                              controller.emptyPlaceOnAccept(data,index);
                            },
                            builder: (context, candidateData, rejectedData) {
                              if(null==list.hissCardBean){
                                return child!;
                              }
                              return Draggable<Map<String, dynamic>>(
                                data: {"fromEmpty": true, "cards": [list.hissCardBean!],"fromIndex":index},
                                onDragStarted: () {
                                  controller.onDragStockPileStarted();
                                },
                                onDragCompleted: () {
                                  controller.onDragStockPileCompleted();
                                },
                                onDraggableCanceled: (velocity, offset) {
                                  controller.onDraggableStockPileCanceled();
                                },
                                feedback: Transform.scale(
                                  scale: 1.05,
                                  child: Material(
                                    color: Colors.transparent,
                                    child: child,
                                  ),
                                ),
                                childWhenDragging: Opacity(
                                  opacity: 0.5,
                                  child: child,
                                ),
                                child: HissClickWidget(
                                  onTap: (){
                                    controller.clickEmptyPlaceItem(index);
                                  },
                                  child: SizedBox(
                                    key: list.globalKey,
                                    child: child,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Visibility(
                          visible: list.lock,
                          child: HissImagesWidget(name: "icon_video", width: 28.w, height: 28.w),
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(width: 6.w,),
                ),
              );
            },
          ),
        ],
      ),
    ),
  );

  _emptyPlaceTipsWidget()=>GetBuilder<BBBHissPlayController>(
    id: "empty_tip",
    builder: (_)=>Visibility(
      visible: controller.showEmptyTips,
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h),
        child: SizedBox(
          width: 220.w,
          height: 68.h,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              HissImagesWidget(name: "empty_tip_bg", width: double.infinity, height: double.infinity),
              Container(
                margin: EdgeInsets.only(left: 10.w,right: 10.w,top: 10.h),
                child: HissTextWidget(
                  textContent: "Temporary Spaces To Help\nYou Progress.",
                  textSize: 14.sp,
                  textAlign: TextAlign.center,
                  textColor: "#FFFFFF".toColor(),
                  outlineColor: "#3D2603".toColor(),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );

  _giftGuideWidget()=>GetBuilder<BBBHissPlayController>(
    id: "gift_guide",
    builder: (_){
      if(null==controller.giftGuideOffset){
        return Container();
      }
      var dx = controller.giftGuideOffset?.dx??0;
      var dy = controller.giftGuideOffset?.dy??0;
      return Container(
        margin: EdgeInsets.only(left: dx+80.w,top: dy-70.h),
        child: Stack(
          children: [
            HissImagesWidget(name: "puzzle_guide", width: 220.w, height: 68.h),
            Container(
              width: 220.w,
              height: 68.h,
              padding: EdgeInsets.only(left: 10.w,right: 10.w,top: 10.h),
              child: HissTextWidget(
                textContent: "Receive a surprise gift puzzle",
                textSize: 14.sp,
                fontWeight: FontWeight.bold,
                textColor: "#FFFFFF".toColor(),
                outlineColor: "#3D2603".toColor(),
              ),
            ),
          ],
        ),
      );
    },
  );
}