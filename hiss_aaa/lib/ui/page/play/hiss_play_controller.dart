import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hiss_aaa/bean/game_state_snapshot_bean.dart';
import 'package:hiss_aaa/bean/hiss_card_bean.dart';
import 'package:hiss_aaa/utils/hiss_enum/hiss_card_type.dart';
import 'package:hiss_root/hiss_ui/hiss_root_controller.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_code.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_data.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_send_event_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';
import 'package:hiss_root/hiss_utils/hiss_routers_utils.dart';

class HissPlayController extends HissRootController{
  var cardWidth=0.0,cardHeight=0.0,_canClickStockPile=true;
  bool _isDragging = false;
  int? _draggingFromCol;
  int? _draggingStartIndex;
  List<List<HissCardBean>> foundationsList=[[],[],[],[]];
  List<List<HissCardBean>> cardList=[];
  List<HissCardBean> stockPileList=[];
  List<HissCardBean> wastePileList=[];
  GlobalKey stockPileGlobalKey=GlobalKey();
  // 撤销栈
  final List<GameStateSnapshotBean> _historyList = [];
  List<GlobalKey> foundationsGlobalKeyList=[GlobalKey(),GlobalKey(),GlobalKey(),GlobalKey()];

  @override
  void onReady() {
    super.onReady();
    _initCards();
  }

  clickHome(){
    HissRoutersUtils.instance.close();
  }

  _initCards(){
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
      }
    }
    cardList[colIndex].addAll(movingCards);
    _isDragging = false;
    _draggingFromCol = null;
    _draggingStartIndex = null;
    update(["card_list","stock_pile"]);
  }

  onDragStarted(int colIndex, int rowIndex){
    _isDragging = true;
    _draggingFromCol = colIndex;
    _draggingStartIndex = rowIndex;
    update(["card_list"]);
  }

  onDragCompleted() {
    _isDragging = false;
    _draggingFromCol = null;
    _draggingStartIndex = null;
    update(["card_list"]);
  }

  onDraggableCanceled(){
    _isDragging = false;
    _draggingFromCol = null;
    _draggingStartIndex = null;
    update(["card_list"]);
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
    update(["card_list","foundations"]);

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
        update(["foundations"]);
        _canClickStockPile=true;
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
  }

  //抽牌区域拖动完成
  onDragStockPileCompleted(){
    _isDragging = false;
    _draggingFromCol = null;
    _draggingStartIndex = null;
    update(["card_list"]);
  }

  onDraggableStockPileCanceled(){
    _isDragging = false;
    _draggingFromCol = null;
    _draggingStartIndex = null;
    update(["card_list"]);
  }

  clickBackProp(){
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
  }

  _saveSnapshot() {
    _historyList.add(GameStateSnapshotBean.from(cardList, foundationsList, stockPileList, wastePileList));
  }
}