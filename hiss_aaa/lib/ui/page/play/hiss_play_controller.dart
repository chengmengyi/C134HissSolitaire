import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hiss_aaa/bean/game_state_snapshot_bean.dart';
import 'package:hiss_aaa/bean/hiss_card_bean.dart';
import 'package:hiss_aaa/bean/hiss_hint_bean.dart';
import 'package:hiss_aaa/ui/dialog/add_prop_dialog/add_prop_dialog.dart';
import 'package:hiss_aaa/ui/dialog/play_success_dialog/play_success_dialog.dart';
import 'package:hiss_aaa/ui/dialog/random_prop_dialog/random_prop_dialog.dart';
import 'package:hiss_aaa/utils/hiss_enum/hiss_card_type.dart';
import 'package:hiss_aaa/utils/hiss_enum/hiss_prop_type.dart';
import 'package:hiss_aaa/utils/hiss_storage.dart';
import 'package:hiss_aaa/utils/hiss_user_info_utils.dart';
import 'package:hiss_root/hiss_ui/hiss_root_controller.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_code.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_data.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_send_event_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';
import 'package:hiss_root/hiss_utils/hiss_routers_utils.dart';

class HissPlayController extends HissRootController{
  var cardWidth=0.0,cardHeight=0.0,_canClickStockPile=true,_canClickResetPlay=true,
      currentScore=0,currentStep=0,currentTime=0,appBackground=false,_showRandomPropDialog=true;
  bool _isDragging = false;
  int? _draggingFromCol;
  int? _draggingStartIndex;
  List<List<HissCardBean>> foundationsList=[[],[],[],[]];
  List<List<HissCardBean>> cardList=[];
  List<HissCardBean> stockPileList=[];
  List<HissCardBean> wastePileList=[];
  GlobalKey stockPileGlobalKey=GlobalKey();
  GlobalKey backPropGlobalKey=GlobalKey();
  GlobalKey tipsPropGlobalKey=GlobalKey();
  // 撤销栈
  final List<GameStateSnapshotBean> _historyList = [];
  List<GlobalKey> foundationsGlobalKeyList=[GlobalKey(),GlobalKey(),GlobalKey(),GlobalKey()];

  ShakeAnimationController shakeAnimationController=ShakeAnimationController();
  ShakeAnimationController tipsAnimationController=ShakeAnimationController();

  Timer? _playGameTimer;
  Timer? _noOperationTimer;

  @override
  void onInit() {
    super.onInit();
    _startTimer();
    _startNoOperationTimer();
  }

  @override
  void onReady() {
    super.onReady();
    _initCards();
  }

  clickHome(){
    HissRoutersUtils.instance.close();
  }

  _initCards(){
    if(!_canClickResetPlay){
      return;
    }
    _canClickResetPlay=false;
    cardList.clear();
    double screenWidth = MediaQuery.of(buildContext).size.width;
    cardWidth = (screenWidth-68.w)/7;
    cardHeight = cardWidth/0.68;
    update(["foundations","stock_pile","card_bg"]);
    List<HissCardBean> fullDeck = [];
    for (var type in HissCardType.values) {
      for (int v = 1; v <= 13; v++) {
        fullDeck.add(HissCardBean(value: v, cardType: type, front: false,globalKey: GlobalKey()));
      }
    }
    fullDeck.shuffle();
    int index = 0;
    for (var i = 0; i < 7; i++) {
      List<HissCardBean> col = [];
      for (var j = 0; j <= i; j++) {
        col.add(fullDeck[index++]);
      }
      cardList.add(col);
    }

    // if(kDebugMode){
    //   cardList[0][0].value=1;
    //   cardList[0][0].cardType=HissCardType.hongtao;
    //   cardList[1].last.value=1;
    //   cardList[1].last.cardType=HissCardType.heitao;
    //   cardList[2].last.value=1;
    //   cardList[2].last.cardType=HissCardType.fangkuai;
    //   cardList[3].last.value=1;
    //   cardList[3].last.cardType=HissCardType.meihua;
    // }
    stockPileList = fullDeck.sublist(index);

    update(["card_list"]);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      HissSendEventUtils.instance.sendEvent(
        data: HissEventData(
          eventCode: HissEventCode.aStartDealCardsAnimator,
          anyEventValue: {
            "stockPileGlobalKey":stockPileGlobalKey,
            "cardList": cardList,
            "cardWidth":cardWidth,
            "cardHeight":cardHeight,
          },
        ),
      );
    });
  }

  bool onAcceptWithDetails(data,int columnIndex){
    List<HissCardBean> movingCards = data!['cards'];
    if (movingCards.isEmpty){
      return false;
    }
    var card = movingCards.first;
    var targetColumn = cardList[columnIndex];
    if (targetColumn.isEmpty) {
      return true;
    }
    final targetCard = targetColumn.last;
    if (targetCard.value != card.value + 1){
      return false;
    }
    return isRedCard(targetCard.cardType) != isRedCard(card.cardType);
  }

  onAccept(data, colIndex){
    _saveSnapshot();
    List<HissCardBean> movingCards = data['cards'];
    if (data['fromWaste'] == true){
      wastePileList.remove(movingCards.first);
      for (var value in movingCards) {
        value.showCard=true;
      }
    } else {
      int fromCol = data['fromCol'];
      int startIndex = data['startIndex'];
      cardList[fromCol].removeRange(startIndex, cardList[fromCol].length);
      if (cardList[fromCol].isNotEmpty){
        cardList[fromCol].last.front = true;
        currentScore+=5;
      }
    }
    cardList[colIndex].addAll(movingCards);
    _isDragging = false;
    _draggingFromCol = null;
    _draggingStartIndex = null;
    currentStep++;
    update(["card_list","stock_pile","step","score"]);
  }

  onDragStarted(int colIndex, int rowIndex){
    _isDragging = true;
    _draggingFromCol = colIndex;
    _draggingStartIndex = rowIndex;
    update(["card_list"]);
    _cancelNoOperationTimer();
  }

  onDragCompleted() {
    _isDragging = false;
    _draggingFromCol = null;
    _draggingStartIndex = null;
    update(["card_list"]);
    _startNoOperationTimer();
  }

  onDraggableCanceled(){
    _isDragging = false;
    _draggingFromCol = null;
    _draggingStartIndex = null;
    update(["card_list"]);
    _startNoOperationTimer();
  }

  // 判断花色是否为红色
  bool isRedCard(HissCardType cardType) => cardType == HissCardType.hongtao || cardType == HissCardType.fangkuai;

  bool isCardBeingDragged(int colIndex, int rowIndex) => _isDragging && _draggingFromCol == colIndex && _draggingStartIndex != null && rowIndex >= _draggingStartIndex!;

  //所有发牌动画已完成
  onAllAnimationsCompleted(){
    List<HissCardBean> list=[];
    for (var value in cardList) {
      if(value.isNotEmpty){
        for (var value1 in value) {
          value1.showCard=true;
        }
        list.add(value.last);
      }
    }
    update(["card_list"]);
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      for (var value in list) {
        HissSendEventUtils.instance.sendEvent(data: HissEventData(eventCode: HissEventCode.aFlipCard,anyEventValue: value));
      }
      await Future.delayed(Duration(milliseconds: 500));
      for (var col in cardList) {
        for (var card in col) {
          if (list.any((c) => c.value == card.value && c.cardType == card.cardType)) {
            card.front = true;
          }
        }
      }
      update(["card_list"]);
      _canClickResetPlay=true;
      if(_showRandomPropDialog){
        HissRoutersUtils.instance.showDialog(
          child: RandomPropDialog(
            dismissCallback: (HissPropType hissPropType){
              _showPropMoveAnimator(hissPropType);
            },
          ),
        );
      }
      _showRandomPropDialog=false;
    });
  }

  tryAutoMoveToFoundation(int colIndex, int rowIndex, List<HissCardBean> list,) async{
    if (rowIndex != list.length - 1){
      return;
    }
    final card = cardList[colIndex][rowIndex];
    if (rowIndex != cardList[colIndex].length - 1 || !card.front){
      return;
    }
    var index=-1;
    for (int f = 0; f < 4; f++) {
      if (_canMoveToFoundation(card, foundationsList[f])) {
        index=f;
        break;
      }
    }
    if(index<0){
      return;
    }
    _cancelNoOperationTimer();
    card.showCard=false;
    update(["card_list"]);
    HissSendEventUtils.instance.sendEvent(
      data: HissEventData(
        eventCode: HissEventCode.aMoveCardToFoundation,
        anyEventValue: {
          "startGlobalKey":card.globalKey,
          "endGlobalKey":foundationsGlobalKeyList[index],
          "card":card,
          "cardWidth":cardWidth,
          "cardHeight":cardHeight,
        },
      ),
    );
    await Future.delayed(Duration(milliseconds: 280));
    card.showCard=true;
    _saveSnapshot();
    foundationsList[index].add(card);
    cardList[colIndex].removeLast();
    if (cardList[colIndex].isNotEmpty){
      cardList[colIndex].last.front = true;
    }
    currentScore+=10;
    update(["card_list","foundations","score"]);
    //校验游戏通关了
    if(_checkPlayEnd()){
      HissRoutersUtils.instance.showDialog(
        child: PlaySuccessDialog(
          time: currentTime,
          score: currentScore,
          step: currentStep,
          dismissCallback: (){
            HissUserInfoUtils.instance.updateUserLevel();
            _showRandomPropDialog=true;
            clickResetPlay();
          },
        ),
      );
    }else{
      _startNoOperationTimer();
    }
  }

  bool _checkPlayEnd(){
    for (var value in foundationsList) {
      if(value.length<13){
        return false;
      }
    }
    return true;
  }

  //是否可移动到func
  bool _canMoveToFoundation(HissCardBean card, List<HissCardBean> foundation) {
    if (foundation.isEmpty){
      return card.value == 1;
    }
    final last = foundation.last;
    return last.cardType == card.cardType && last.value == card.value - 1;
  }

  //点击抽牌区域
  clickFlipCardFromStock()async{
    if(!_canClickStockPile){
      return;
    }
    _canClickStockPile=false;
    if (stockPileList.isEmpty && wastePileList.isEmpty){
      return;
    }
    _cancelNoOperationTimer();
    _saveSnapshot();
    if (stockPileList.isEmpty) {
      stockPileList = wastePileList.reversed.map((c) => HissCardBean(value: c.value, cardType: c.cardType, front: c.front,isDefaultA: c.showCard,showCard: c.showCard,globalKey: c.globalKey)).toList();
      wastePileList.clear();
    } else {
      final card = stockPileList.removeLast();
      card.front = true;
      var index=-1;
      for (int f = 0; f < 4; f++) {
        if (_canMoveToFoundation(card, foundationsList[f])) {
          index=f;
          break;
        }
      }
      if(index>=0){
        HissSendEventUtils.instance.sendEvent(
          data: HissEventData(
            eventCode: HissEventCode.aMoveCardToFoundation,
            anyEventValue: {
              "startGlobalKey":stockPileGlobalKey,
              "endGlobalKey":foundationsGlobalKeyList[index],
              "card":card,
              "cardWidth":cardWidth,
              "cardHeight":cardHeight,
            },
          ),
        );
        await Future.delayed(Duration(milliseconds: 280));
        foundationsList[index].add(card);
        currentScore+=10;
        update(["foundations","score"]);
        _canClickStockPile=true;
        _startNoOperationTimer();
        return;
      }
      HissSendEventUtils.instance.sendEvent(
        data: HissEventData(
          eventCode: HissEventCode.aMoveCardToWaste,
          anyEventValue: {
            "startGlobalKey":stockPileGlobalKey,
            "card":card,
            "cardWidth":cardWidth,
            "cardHeight":cardHeight,
          },
        ),
      );
      await Future.delayed(Duration(milliseconds: 280));
      wastePileList.add(card);
      if (wastePileList.length > 3) {
        final firstCard = wastePileList.removeAt(0);
        firstCard.front = false;
        stockPileList.insert(0, firstCard);
      }
    }
    update(["stock_pile"]);
    _canClickStockPile=true;
    _startNoOperationTimer();
  }

  onDragStockPileStarted(){
    _cancelNoOperationTimer();
  }

  //抽牌区域拖动完成
  onDragStockPileCompleted(){
    _isDragging = false;
    _draggingFromCol = null;
    _draggingStartIndex = null;
    update(["card_list"]);
    _startNoOperationTimer();
  }

  onDraggableStockPileCanceled(){
    _isDragging = false;
    _draggingFromCol = null;
    _draggingStartIndex = null;
    update(["card_list"]);
    _startNoOperationTimer();
  }

  clickBackProp(){
    if(aBackPropNum.getData()<=0){
      HissRoutersUtils.instance.showDialog(
        child: AddPropDialog(
          hissPropType: HissPropType.back,
          dismissCallback: (){
            _showPropMoveAnimator(HissPropType.back);
          },
        ),
      );
      return;
    }
    if (_historyList.isEmpty) {
      return;
    }
    final last = _historyList.removeLast();

    cardList = GameStateSnapshotBean.cloneColumns(last.cardList);
    foundationsList = GameStateSnapshotBean.cloneColumns(last.foundations);
    stockPileList = GameStateSnapshotBean.cloneList(last.stockPile);
    wastePileList = GameStateSnapshotBean.cloneList(last.wastePile);

    _isDragging = false;
    _draggingFromCol = null;
    _draggingStartIndex = null;
    update(["stock_pile","foundations","card_list"]);
    HissUserInfoUtils.instance.updatePropNum(hissPropType: HissPropType.back, addNum: -1);
  }

  clickHint(){
    if(aTipsPropNum.getData()<=0){
      HissRoutersUtils.instance.showDialog(
        child: AddPropDialog(
          hissPropType: HissPropType.tips,
          dismissCallback: (){
            _showPropMoveAnimator(HissPropType.tips);
          },
        ),
      );
      return;
    }
    List<HissHintBean> hints = _findMoveHints();
    if (hints.isEmpty) {
      shakeAnimationController.start();
      return;
    }
    HissSendEventUtils.instance.sendEvent(
      data: HissEventData(
        eventCode: HissEventCode.aHintAnimator,
        anyEventValue: {
          "hints":hints,
          "cardList":cardList,
          "cardWidth":cardWidth,
          "cardHeight":cardHeight,
          "foundationsGlobalKeyList":foundationsGlobalKeyList,
        },
      ),
    );
    HissUserInfoUtils.instance.updatePropNum(hissPropType: HissPropType.tips, addNum: -1);
  }

  /// 查找所有可移动提示
  List<HissHintBean> _findMoveHints() {
    List<HissHintBean> hints = [];

    // -------------------------
    // ① 找 “列 → 列” 可移动
    // -------------------------
    for (int fromCol = 0; fromCol < cardList.length; fromCol++) {
      final column = cardList[fromCol];

      for (int start = 0; start < column.length; start++) {
        final movingCards = column.sublist(start);

        // 必须是翻开的
        if (!movingCards.first.front) continue;

        for (int toCol = 0; toCol < cardList.length; toCol++) {
          if (toCol == fromCol) continue;

          // 判断能否移动到该列
          if (canMoveToColumn(movingCards.first, cardList[toCol])) {
            hints.add(
              HissHintBean(
                fromCol: fromCol,
                startIndex: start,
                toCol: toCol,
                cards: movingCards,
              ),
            );
          }
        }
      }
    }

    // if (hints.isNotEmpty) return hints;

    // ----------------------------------------
    // ② 若无列→列，再找 “列顶牌 → Foundation”
    // ----------------------------------------
    for (int col = 0; col < cardList.length; col++) {
      if (cardList[col].isEmpty) continue;

      final topCard = cardList[col].last;
      if (!topCard.front) continue;

      for (int f = 0; f < 4; f++) {
        if (canMoveToFoundation(topCard, foundationsList[f])) {
          hints.add(
            HissHintBean(
              fromCol: col,
              startIndex: cardList[col].length - 1,
              toFoundation: f,
              cards: [topCard],
            ),
          );
          break;
        }
      }
    }
    return hints;
  }

  bool canMoveToFoundation(HissCardBean card, List<HissCardBean> foundation) {
    if (foundation.isEmpty) return card.value == 1;
    final last = foundation.last;
    return last.cardType == card.cardType && last.value == card.value - 1;
  }

  bool canMoveToColumn(HissCardBean card, List<HissCardBean> targetColumn) {
    if (targetColumn.isEmpty) return true;
    final targetCard = targetColumn.last;
    if (targetCard.value != card.value + 1) return false;
    return isRedCard(targetCard.cardType) != isRedCard(card.cardType);
  }

  clickResetPlay(){
    currentStep=0;
    currentTime=0;
    currentScore=0;
    _startTimer();
    _initCards();
  }

  _showPropMoveAnimator(HissPropType hissPropType){
    HissSendEventUtils.instance.sendEvent(
      data: HissEventData(
        eventCode: HissEventCode.aShowPropAnimator,
        anyEventValue: {
          "hissPropType":hissPropType,
          "endGlobalKey":hissPropType==HissPropType.tips?tipsPropGlobalKey:backPropGlobalKey,
        }
      ),
    );
    _startNoOperationTimer();
  }

  _saveSnapshot() {
    _historyList.add(GameStateSnapshotBean.from(cardList, foundationsList, stockPileList, wastePileList));
  }

  _startTimer(){
    _playGameTimer?.cancel();
    currentTime=0;
    _playGameTimer=Timer.periodic(Duration(seconds: 1), (t){
      if(appBackground){
        return;
      }
      currentTime++;
      update(["time"]);
    });
  }

  _startNoOperationTimer(){
    _noOperationTimer?.cancel();
    _noOperationTimer=Timer(Duration(milliseconds: 3000), (){
      tipsAnimationController.start(shakeCount: 3);
    });
  }

  _cancelNoOperationTimer(){
    _noOperationTimer?.cancel();
    _noOperationTimer=null;
  }

  @override
  bool canReceivedEventData() => true;

  @override
  handleEventBusData(HissEventData data) {
    switch(data.eventCode){
      case HissEventCode.aUpdatePropNum:
        update(["tips_prop","back_prop"]);
        break;
      case HissEventCode.aUpdateLevel:
        update(["level"]);
        break;
      case HissEventCode.onChangedAppLife:
        appBackground=data.boolEventValue??false;
        break;
    }
  }

  @override
  void onClose() {
    _playGameTimer?.cancel();
    _noOperationTimer?.cancel();
    super.onClose();
  }
}