import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hiss_bbb/bean/game_state_snapshot_bean.dart';
import 'package:hiss_bbb/bean/hiss_card_bean.dart';
import 'package:hiss_bbb/bean/hiss_empty_place_bean.dart';
import 'package:hiss_bbb/bean/hiss_hint_bean.dart';
import 'package:hiss_bbb/bean/super_prop_card_bean.dart';
import 'package:hiss_bbb/ui/dialog/add_prop_dialog/add_prop_dialog.dart';
import 'package:hiss_bbb/ui/dialog/first_get_puzzle_dialog/first_get_puzzle_dialog.dart';
import 'package:hiss_bbb/ui/dialog/first_move_card_to_foundations_dialog/first_move_card_to_foundations_dialog.dart';
import 'package:hiss_bbb/ui/dialog/money_card_reward_dialog/money_card_reward_dialog.dart';
import 'package:hiss_bbb/ui/dialog/play_success_dialog/play_success_dialog.dart';
import 'package:hiss_bbb/ui/dialog/random_prop_dialog/random_prop_dialog.dart';
import 'package:hiss_bbb/ui/dialog/set_dialog/set_dialog.dart';
import 'package:hiss_bbb/ui/dialog/wheel_dialog/wheel_dialog.dart';
import 'package:hiss_bbb/ui/widget/hiss_puzzle_overlay.dart';
import 'package:hiss_bbb/utils/hiss_b_routers.dart';
import 'package:hiss_bbb/utils/hiss_cash_task_utils.dart';
import 'package:hiss_bbb/utils/hiss_daily_task_utils.dart';
import 'package:hiss_bbb/utils/hiss_enum/hiss_card_type.dart';
import 'package:hiss_bbb/utils/hiss_enum/hiss_prop_type.dart';
import 'package:hiss_bbb/utils/hiss_enum/hiss_task_type.dart';
import 'package:hiss_bbb/utils/hiss_overlay_utils.dart';
import 'package:hiss_bbb/utils/hiss_show_ad_utils.dart';
import 'package:hiss_bbb/utils/hiss_storage.dart';
import 'package:hiss_bbb/utils/hiss_user_info_utils.dart';
import 'package:hiss_bbb/utils/hiss_value_config_utils.dart';
import 'package:hiss_bbb/utils/utils.dart';
import 'package:hiss_root/hiss_ui/hiss_root_controller.dart';
import 'package:hiss_root/hiss_utils/hiss_ad_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_code.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_data.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_send_event_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';
import 'package:hiss_root/hiss_utils/hiss_mp3_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_ad_enum.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_point_enum.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_point_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_routers_utils.dart';

class BBBHissPlayController extends HissRootController{
  var cardWidth=0.0,cardHeight=0.0,_canClickStockPile=true,_canClickResetPlay=true,
      currentScore=0,currentStep=0,currentTime=0,appBackground=false,
      canClick=true;
  bool _isDragging = false,showEmptyTips=false,_firstGetRewardShowing=false,_canShowFirstGetPuzzle=false;
  int? _draggingFromCol;
  int? _draggingStartIndex;
  List<List<HissCardBean>> foundationsList=[[],[],[],[]];
  List<List<HissCardBean>> cardList=[];
  List<HissCardBean> stockPileList=[];
  List<HissCardBean> wastePileList=[];
  GlobalKey stockPileGlobalKey=GlobalKey();
  GlobalKey backPropGlobalKey=GlobalKey();
  GlobalKey tipsPropGlobalKey=GlobalKey();
  GlobalKey topMoneyGlobalKey=GlobalKey();
  GlobalKey diamondPigGlobalKey=GlobalKey();
  GlobalKey giftPuzzleGlobalKey=GlobalKey();
  // 撤销栈
  final List<GameStateSnapshotBean> _historyList = [];
  List<GlobalKey> foundationsGlobalKeyList=[GlobalKey(),GlobalKey(),GlobalKey(),GlobalKey()];

  ShakeAnimationController shakeAnimationController=ShakeAnimationController();
  ShakeAnimationController tipsAnimationController=ShakeAnimationController();

  Timer? _playGameTimer;
  Timer? _noOperationTimer;
  Timer? _emptyTipsTimer;

  Offset? giftGuideOffset;
  Timer? _giftGuideTimer;

  List<HissEmptyPlaceBean> emptyPlaceList=[
    HissEmptyPlaceBean(lock: false,globalKey: GlobalKey()),
    HissEmptyPlaceBean(lock: true,globalKey: GlobalKey()),
    HissEmptyPlaceBean(lock: true,globalKey: GlobalKey()),
  ];

  @override
  void onInit() {
    super.onInit();
    _startTimer();
    _startNoOperationTimer();
    playGamePageOpen=true;
    HissPointUtils.instance.pointEvent(hissPointEnum: HissPointEnum.game_page,params: {"level":bLevel.getData()});
  }

  @override
  void onReady() {
    super.onReady();
    _initCards();
  }

  clickHome(){
    if(!canClick){
      return;
    }
    HissPointUtils.instance.pointEvent(hissPointEnum: HissPointEnum.game_home_c);
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
    update(["foundations","stock_pile","card_bg","empty_place"]);

    List<HissCardBean> fullDeck = [];
    for (var type in HissCardType.values) {
      for (int v = 1; v <= 13; v++) {
        fullDeck.add(HissCardBean(value: v, cardType: type, front: false,globalKey: GlobalKey()));
      }
    }
    if(bLevel.getData()<=1){
      _initLevel1Cards(fullDeck);
    }else{
      _initOtherLevelCards(fullDeck);
    }
    foundationsList=[[],[],[],[]];
    wastePileList.clear();
    update(["card_list","foundations","stock_pile"]);

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

  _initLevel1Cards(List<HissCardBean> fullDeck){
    List<HissCardBean> chain28 = [];

    for (int v = 1; v <= 7; v++) {
      List<HissCardBean> four = fullDeck.where((e) => e.value == v).take(4).toList();

      chain28.addAll(four);

      for (var c in four) {
        fullDeck.remove(c);
      }
    }

    List<List<HissCardBean>> columns = List.generate(7, (_) => []);

    int index = 0;

    for (int layer = 7; layer >= 1; layer--) {
      for (int col = 0; col < 7; col++) {
        int height = col + 1;

        if (height < layer) continue;

        HissCardBean card = chain28[index++];
        columns[col].insert(0, card);
      }
    }

    for (var col in columns) {
      for (int i = 0; i < col.length; i++) {
        col[i].front = (i == col.length - 1);
      }
    }
    var coinsCardNum=HissValueConfigUtils.instance.coinsCardNum();
    var giftPuzzleNum = HissValueConfigUtils.instance.getGiftPuzzleNum();
    _randomSetCoinsAndGifts(columns,coinsCardNum,giftPuzzleNum);

    cardList = columns;

    stockPileList.clear();
    for (var c in fullDeck) {
      c.front = false;
      stockPileList.add(c);
    }
  }

  _initOtherLevelCards(List<HissCardBean> fullDeck){
    fullDeck.shuffle();
    int index = 0;
    for (var i = 0; i < 7; i++) {
      List<HissCardBean> col = [];
      for (var j = 0; j <= i; j++) {
        var cardBean = fullDeck[index++];
        col.add(cardBean);
      }
      cardList.add(col);
    }

    var coinsCardNum=HissValueConfigUtils.instance.coinsCardNum();
    var giftPuzzleNum = HissValueConfigUtils.instance.getGiftPuzzleNum();
    _randomSetCoinsAndGifts(cardList,coinsCardNum,giftPuzzleNum);
    stockPileList = fullDeck.sublist(index);
  }

  _randomSetCoinsAndGifts(List<List<HissCardBean>> list2D, int coinsNum, int puzzleNum,) {
    final spinNum = HissValueConfigUtils.instance.getSpinNum();
    final random = Random();

    final allPos = <_Pos>[];

    for (int i = 0; i < list2D.length; i++) {
      final row = list2D[i];
      if (row.isEmpty) continue;

      for (int j = 0; j < row.length; j++) {
        final item = row[j];
        item.isCoins = false;
        item.isGift = false;
        item.isWheel = false;
        if (j == row.length - 1) continue;

        allPos.add(_Pos(i, j));
      }
    }

    if (allPos.isEmpty) return;

    allPos.shuffle(random);

    final usedPos = <_Pos>{};

    final coinCount = coinsNum.clamp(0, allPos.length);
    for (int i = 0; i < coinCount; i++) {
      final p = allPos[i];
      list2D[p.i][p.j].isCoins = true;
      usedPos.add(p);
    }

    final giftCandidates =
    allPos.where((p) => !usedPos.contains(p)).toList();

    giftCandidates.shuffle(random);

    final giftCount = puzzleNum.clamp(0, giftCandidates.length);
    for (int i = 0; i < giftCount; i++) {
      final p = giftCandidates[i];
      list2D[p.i][p.j].isGift = true;
      usedPos.add(p);
    }

    final wheelCandidates =
    allPos.where((p) => !usedPos.contains(p)).toList();

    wheelCandidates.shuffle(random);

    final wheelCount = spinNum.clamp(0, wheelCandidates.length);
    for (int i = 0; i < wheelCount; i++) {
      final p = wheelCandidates[i];
      list2D[p.i][p.j].isWheel = true;
    }
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
    if(targetCard.isCoins==true){
      return false;
    }
    if (targetCard.value != card.value + 1){
      return false;
    }
    return isRedCard(targetCard.cardType) != isRedCard(card.cardType);
  }

  onAccept(data, colIndex)async{
    _saveSnapshot();
    List<HissCardBean> movingCards = data['cards'];
    HissCardBean? showDiamondCard;
    HissCardBean? showGiftPuzzleCard;
    _uploadMovePoint();
    if (data['fromWaste'] == true){
      wastePileList.remove(movingCards.first);
      for (var value in movingCards) {
        value.showCard=true;
      }
    } else {
      if(data['fromEmpty']==true){
        emptyPlaceList[data["fromIndex"]].hissCardBean=null;
      }else{
        int fromCol = data['fromCol'];
        int startIndex = data['startIndex'];
        cardList[fromCol].removeRange(startIndex, cardList[fromCol].length);
        if (cardList[fromCol].isNotEmpty){
          var fromLast = cardList[fromCol].last;
          fromLast.front = true;
          if(fromLast.isWheel==true){
            HissPointUtils.instance.pointEvent(hissPointEnum: HissPointEnum.game_spin_card);
            _autoShowWheelDialog(fromLast);
          }
          if(fromLast.isCoins!=true){
            if(fromLast.isGift==true){
              showGiftPuzzleCard=fromLast;
            }else if(HissValueConfigUtils.instance.showDiamondIcon()){
              showDiamondCard=fromLast;
            }
          }
        }
      }
      currentScore+=5;
    }
    cardList[colIndex].addAll(movingCards);
    _isDragging = false;
    _draggingFromCol = null;
    _draggingStartIndex = null;
    currentStep++;
    update(["card_list","stock_pile","step","score","empty_place"]);
    _checkIsDiamondOrGiftPuzzle(showDiamondCard,showGiftPuzzleCard);
    _checkAllCardFront();
  }

  //校验所有牌都翻开了，就全部自动收到纸牌区
  _checkAllCardFront()async{
    var allFront=true;
    for (var value in cardList) {
      for (var value1 in value) {
        if(!value1.front){
          allFront=false;
          break;
        }
      }
    }

    if(allFront){
      for (var value in cardList) {
        for (var value1 in value) {
          if(value1.isCoins==true){
            value1.isCoins=false;
          }
        }
      }

      var foundationIndex=-1,colIndex=-1;
      HissCardBean? card;
      for (int  i = 0; i < cardList.length; i++) {
        var value = cardList[i];
        if(value.isNotEmpty){
          var value1 = value.last;
          for (int f = 0; f < 4; f++) {
            if (_canMoveToFoundation(value1, foundationsList[f])) {
              foundationIndex=f;
              card=value1;
              colIndex=i;
              break;
            }
          }
        }
      }

      if(null!=card){
        await _moveCardToFoundation(
          card: card,
          foundationIndex: foundationIndex,
          startGlobalKey: card.globalKey,
          moveCompleted: (){
            cardList[colIndex].removeLast();
            if (cardList[colIndex].isNotEmpty){
              cardList[colIndex].last.front = true;
            }
          },
        );
      }else{
        for (var value in stockPileList) {
          for (int f = 0; f < 4; f++) {
            if (_canMoveToFoundation(value, foundationsList[f])) {
              foundationIndex=f;
              card=value;
              break;
            }
          }
        }
        if(null!=card){
          await _moveCardToFoundation(
            card: card,
            startGlobalKey: stockPileGlobalKey,
            foundationIndex: foundationIndex,
            moveCompleted: (){
              stockPileList.remove(card);
            },
          );
        }else{
          for (var value in wastePileList) {
            for (int f = 0; f < 4; f++) {
              if (_canMoveToFoundation(value, foundationsList[f])) {
                foundationIndex=f;
                card=value;
                break;
              }
            }
          }
          if(null!=card){
            await _moveCardToFoundation(
              card: card,
              startGlobalKey: card.globalKey,
              foundationIndex: foundationIndex,
              moveCompleted: (){
                wastePileList.remove(card);
              },
            );
          }else{
            canClick=true;
          }
        }
      }
    }else{
      canClick=true;
    }
  }

  _moveCardToFoundation({
    required HissCardBean card,
    required int foundationIndex,
    required GlobalKey? startGlobalKey,
    required Function() moveCompleted,
  })async{
    canClick=false;
    card.showCard=false;
    update(["card_list"]);
    HissSendEventUtils.instance.sendEvent(
      data: HissEventData(
        eventCode: HissEventCode.aMoveCardToFoundation,
        anyEventValue: {
          "startGlobalKey":startGlobalKey,
          "endGlobalKey":foundationsGlobalKeyList[foundationIndex],
          "card":card,
          "cardWidth":cardWidth,
          "cardHeight":cardHeight,
          "fromAuto":true,
        },
      ),
    );
    await Future.delayed(Duration(milliseconds: 80));
    card.showCard=true;
    _saveSnapshot();
    foundationsList[foundationIndex].add(card);
    moveCompleted.call();
    currentScore+=10;
    update(["card_list","foundations","score","stock_pile"]);
    canClick=true;
    await Future.delayed(Duration(milliseconds: 50));
    _checkPlayEnd();
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
      _showEmptyPlaceTips();
    });
  }

  _showEmptyPlaceTips(){
    showEmptyTips=true;
    update(["empty_tip"]);
    _emptyTipsTimer=Timer(Duration(milliseconds: 3000), (){
      _emptyTipsTimer?.cancel();
      showEmptyTips=false;
      update(["empty_tip"]);
    });
  }

  tryAutoMoveToFoundation(int colIndex, int rowIndex, List<HissCardBean> list,) async{
    if (!canClick){
      return;
    }
    final card = cardList[colIndex][rowIndex];
    if (!card.front){
      canClick=true;
      return;
    }
    canClick=false;
    _cancelNoOperationTimer();
    if(card.isCoins==true){
      HissUserInfoUtils.instance.showGoodCommentDialog(
        callback: (){
          var cardAddRewardNum = HissValueConfigUtils.instance.coinsCardAddRewardNum();
          HissRoutersUtils.instance.showDialog(
            child: MoneyCardRewardDialog(
              reward: cardAddRewardNum,
              callback: (double reward)async{
                HissSendEventUtils.instance.sendEvent(
                  data: HissEventData(
                    eventCode: HissEventCode.aMoveCardToFoundation,
                    anyEventValue: {
                      "startGlobalKey":card.globalKey,
                      "endGlobalKey":topMoneyGlobalKey,
                      "card":card,
                      "cardWidth":cardWidth,
                      "cardHeight":cardHeight,
                    },
                  ),
                );
                HissDailyTaskUtils.instance.updateDailyTaskProgress(HissTaskType.card);
                HissCashTaskUtils.instance.updateCashTask(HissTaskType.card);
                await Future.delayed(Duration(milliseconds: 280));
                HissUserInfoUtils.instance.updateMoney(cardAddRewardNum,showAnimator: true);
                update(["card_list"]);
                card.isCoins=false;
                await Future.delayed(Duration(milliseconds: 100));
                canClick=true;
              },
            ),
          );
        },
      );
      return;
    }
    if(card.isWheel==true){
      _showWheelAnimator(card);
      card.isWheel=false;
      update(["card_list"]);
      canClick=true;
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
      var canMoveToCardList = _checkCanMoveToCardList(card);
      if(canMoveToCardList>=0){
        var sublist = cardList[colIndex].sublist(rowIndex,cardList[colIndex].length);
        cardList[colIndex].removeRange(rowIndex, cardList[colIndex].length);
        // cardList[colIndex].removeLast();
        update(["card_list"]);
        _uploadMovePoint();
        HissSendEventUtils.instance.sendEvent(
          data: HissEventData(
            eventCode: HissEventCode.moveToCardList,
            anyEventValue: {
              "startGlobalKey":card.globalKey,
              "endGlobalKey":cardList[canMoveToCardList].last.globalKey,
              "cardList":sublist,
              "cardWidth":cardWidth,
              "cardHeight":cardHeight,
            },
          ),
        );
        await Future.delayed(Duration(milliseconds: 280));
        _setCardLastShow(colIndex);
        cardList[canMoveToCardList].addAll(sublist);
        currentScore+=10;
        canClick=true;
        update(["card_list","score"]);
        _startNoOperationTimer();
        //校验游戏通关了
        _checkPlayEnd();
        return;
      }
      canClick=true;
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
    _uploadMovePoint();
    await Future.delayed(Duration(milliseconds: 280));
    card.showCard=true;
    _saveSnapshot();
    foundationsList[index].add(card);
    cardList[colIndex].removeLast();
    _checkFirstMoveCardToFoundations();
    _setCardLastShow(colIndex);
    currentScore+=10;
    update(["card_list","foundations","score"]);
    await Future.delayed(Duration(milliseconds: 100));
    canClick=true;
    //校验游戏通关了
    _checkPlayEnd();
  }

  _setCardLastShow(int colIndex){
    if (cardList[colIndex].isNotEmpty){
      cardList[colIndex].last.front = true;
      var alreadyShowDialog = HissUserInfoUtils.instance.updateMoney(HissValueConfigUtils.instance.getFlipCardAddNum());
      var last = cardList[colIndex].last;
      _autoShowWheelDialog(last,alreadyShowDialog: alreadyShowDialog);
      HissCardBean? showDiamondCard;
      HissCardBean? showGiftPuzzleCard;
      if(last.isCoins!=true){
        if(last.isGift==true){
          showGiftPuzzleCard=last;
        }else if(HissValueConfigUtils.instance.showDiamondIcon()){
          showDiamondCard=last;
        }
      }
      _checkIsDiamondOrGiftPuzzle(showDiamondCard,showGiftPuzzleCard);
    }
  }

  _checkIsDiamondOrGiftPuzzle(HissCardBean? diamondCardBean,HissCardBean? giftPuzzleCardBean)async{
    if(null!=diamondCardBean){
      HissMp3Utils.instance.playOtherMp3(HissMp3Type.cunqian);
      HissUserInfoUtils.instance.updateDiamondNum(1);
      HissSendEventUtils.instance.sendEvent(
        data: HissEventData(
          eventCode: HissEventCode.aShowDiamondPigAnimator,
          anyEventValue: {
            "cardWidth":cardWidth,
            "cardHeight":cardHeight,
            "endGlobalKey":diamondPigGlobalKey,
            "startGlobalKey":diamondCardBean.globalKey,
          },
        ),
      );
      await Future.delayed(Duration(milliseconds: 500));
      HissSendEventUtils.instance.sendEvent(data: HissEventData(eventCode: HissEventCode.aShowPigBtnTips));
    }
    if(null!=giftPuzzleCardBean){
      HissSendEventUtils.instance.sendEvent(
        data: HissEventData(
          eventCode: HissEventCode.showGiftPuzzleAnimator,
          anyEventValue: {
            "cardWidth":cardWidth,
            "cardHeight":cardHeight,
            "endGlobalKey":giftPuzzleGlobalKey,
            "startGlobalKey":giftPuzzleCardBean.globalKey,
          },
        ),
      );
      await Future.delayed(Duration(milliseconds: 500));
      HissUserInfoUtils.instance.updateWheelNum(1);
      _checkFirstGetPuzzle();
    }
  }

  _checkPlayEnd(){
    var playEnd=true;
    for (var value in foundationsList) {
      if(value.length<13){
        playEnd=false;
        break;
      }
    }
    if(playEnd){
      HissDailyTaskUtils.instance.updateDailyTaskProgress(HissTaskType.game);
      HissCashTaskUtils.instance.updateCashTask(HissTaskType.game);
      HissRoutersUtils.instance.showDialog(
        child: PlaySuccessDialog(
          time: currentTime,
          score: currentScore,
          step: currentStep,
          dismissCallback: (){
            HissUserInfoUtils.instance.updateUserLevel();
            clickResetPlay();
          },
        ),
      );
    }else{
      _startNoOperationTimer();
      _checkAllCardFront();
    }
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
    if(!_canClickStockPile||!canClick){
      return;
    }
    if (stockPileList.isEmpty && wastePileList.isEmpty){
      return;
    }
    _canClickStockPile=false;
    _cancelNoOperationTimer();
    _saveSnapshot();
    if (stockPileList.isEmpty) {
      stockPileList = wastePileList.reversed.map((c) => HissCardBean(value: c.value, cardType: c.cardType, front: c.front,isDefaultA: c.showCard,showCard: c.showCard,globalKey: c.globalKey)).toList();
      wastePileList.clear();
    } else {
      final card = stockPileList.removeLast();
      card.front = true;
      var toToFoundationIndex=-1;
      for (int f = 0; f < 4; f++) {
        if (_canMoveToFoundation(card, foundationsList[f])) {
          toToFoundationIndex=f;
          break;
        }
      }
      if(toToFoundationIndex>=0){
        HissSendEventUtils.instance.sendEvent(
          data: HissEventData(
            eventCode: HissEventCode.aMoveCardToFoundation,
            anyEventValue: {
              "startGlobalKey":stockPileGlobalKey,
              "endGlobalKey":foundationsGlobalKeyList[toToFoundationIndex],
              "card":card,
              "cardWidth":cardWidth,
              "cardHeight":cardHeight,
            },
          ),
        );
        await Future.delayed(Duration(milliseconds: 280));
        foundationsList[toToFoundationIndex].add(card);
        currentScore+=10;
        _checkFirstMoveCardToFoundations();
        update(["foundations","score","card_bg"]);
        _canClickStockPile=true;
        _startNoOperationTimer();
        //校验游戏通关了
        _checkPlayEnd();
        return;
      }
      var foundationMoveToCardListIndex = _checkCanMoveToCardList(card);
      if(foundationMoveToCardListIndex>=0){
        card.showCard=true;
        HissSendEventUtils.instance.sendEvent(
          data: HissEventData(
            eventCode: HissEventCode.moveToCardList,
            anyEventValue: {
              "startGlobalKey":stockPileGlobalKey,
              "endGlobalKey":cardList[foundationMoveToCardListIndex].last.globalKey,
              "cardList":[card],
              "cardWidth":cardWidth,
              "cardHeight":cardHeight,
            },
          ),
        );
        await Future.delayed(Duration(milliseconds: 280));
        cardList[foundationMoveToCardListIndex].add(card);
        currentScore+=10;
        update(["card_list","score","card_bg"]);
        _canClickStockPile=true;
        _startNoOperationTimer();
        //校验游戏通关了
        _checkPlayEnd();
        return;
      }
      if(wastePileList.isNotEmpty){
        HissSendEventUtils.instance.sendEvent(
          data: HissEventData(
            eventCode: HissEventCode.aMoveOtherWasteAnimator,
            anyEventValue: {
              "cardList":wastePileList.length<3?wastePileList:wastePileList.sublist(1,3),
              "cardWidth":cardWidth,
              "cardHeight":cardHeight,
            },
          ),
        );
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
    update(["stock_pile","card_bg"]);
    Future.delayed(Duration(milliseconds: 200),(){
      _canClickStockPile=true;
    });
    _startNoOperationTimer();
  }

  _checkFirstMoveCardToFoundations(){
    if(!firstMoveCardToFoundations.getData()){
      return;
    }
    _firstGetRewardShowing=true;
    firstMoveCardToFoundations.saveData(false);
    HissRoutersUtils.instance.showDialog(
      child: FirstMoveCardToFoundationsDialog(
        callback: (){
          _firstGetRewardShowing=false;
          if(_canShowFirstGetPuzzle){
            _checkFirstGetPuzzle();
          }
        },
      ),
    );
  }

  _checkFirstGetPuzzle(){
    if(!firstGetPuzzle.getData()){
      _checkShowPuzzleGuide();
      return;
    }
    _canShowFirstGetPuzzle=true;
    if(_firstGetRewardShowing){
      return;
    }
    firstGetPuzzle.saveData(false);
    HissRoutersUtils.instance.showDialog(
      child: FirstGetPuzzleDialog(
        toPuzzlePageCallback: (){
          clickGiftBtn();
        },
      ),
    );
    _canShowFirstGetPuzzle=false;
  }

  int _checkCanMoveToCardList(HissCardBean bean){
    for(var index=0;index<cardList.length;index++){
      if(cardList[index].isNotEmpty){
        var last = cardList[index].last;
        if(last.isCoins!=true&&last.value == bean.value+1&&isRedCard(last.cardType) != isRedCard(bean.cardType)){
          return index;
        }
      }
    }
    return -1;
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
    if(!canClick){
      return;
    }
    HissPointUtils.instance.pointEvent(hissPointEnum: HissPointEnum.game_retract);
    if(bBackPropNum.getData()<=0){
      if(showNewUserGivePropDialog.getData()){
        showNewUserGivePropDialog.saveData(false);
        HissRoutersUtils.instance.showDialog(
          child: RandomPropDialog(
            dismissCallback: (HissPropType hissPropType){
              _showPropMoveAnimator(hissPropType);
            },
          ),
        );
        return;
      }
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
    emptyPlaceList = GameStateSnapshotBean.cloneEmptyPlaceList(last.emptyPlace);

    _isDragging = false;
    _draggingFromCol = null;
    _draggingStartIndex = null;
    update(["stock_pile","foundations","card_list","empty_place"]);
    HissUserInfoUtils.instance.updatePropNum(hissPropType: HissPropType.back, addNum: -1);
    HissDailyTaskUtils.instance.updateDailyTaskProgress(HissTaskType.tool);
    HissCashTaskUtils.instance.updateCashTask(HissTaskType.tool);
  }

  clickHint(){
    if(!canClick){
      return;
    }
    HissPointUtils.instance.pointEvent(hissPointEnum: HissPointEnum.game_remind);
    if(bTipsPropNum.getData()<=0){
      if(showNewUserGivePropDialog.getData()){
        showNewUserGivePropDialog.saveData(false);
        HissRoutersUtils.instance.showDialog(
          child: RandomPropDialog(
            dismissCallback: (HissPropType hissPropType){
              _showPropMoveAnimator(hissPropType);
            },
          ),
        );
        return;
      }
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
      HissUserInfoUtils.instance.updatePropNum(hissPropType: HissPropType.tips, addNum: -1);
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
    HissDailyTaskUtils.instance.updateDailyTaskProgress(HissTaskType.tool);
    HissCashTaskUtils.instance.updateCashTask(HissTaskType.tool);
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
    if(card.isCoins==true){
      return false;
    }
    if (foundation.isEmpty){
      return card.value == 1;
    }
    final last = foundation.last;
    return last.cardType == card.cardType && last.value == card.value - 1;
  }

  bool canMoveToColumn(HissCardBean card, List<HissCardBean> targetColumn) {
    if(card.isCoins==true){
      return false;
    }
    if (targetColumn.isEmpty) {
      return true;
    }
    final targetCard = targetColumn.last;
    if (targetCard.value != card.value + 1) return false;
    return isRedCard(targetCard.cardType) != isRedCard(card.cardType);
  }

  clickResetPlay(){
    if(!canClick){
      return;
    }
    HissPointUtils.instance.pointEvent(hissPointEnum: HissPointEnum.game_again);
    currentStep=0;
    currentTime=0;
    currentScore=0;
    _startTimer();
    _initCards();
    for(var index=0;index<emptyPlaceList.length;index++){
      var bean = emptyPlaceList[index];
      bean.hissCardBean=null;
      if(index!=0){
        bean.lock=true;
      }
    }
    update(["empty_place"]);
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
    _historyList.add(GameStateSnapshotBean.from(cardList, foundationsList, stockPileList, wastePileList,emptyPlaceList));
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
    _noOperationTimer=Timer.periodic(Duration(milliseconds: 6000), (t){
      tipsAnimationController.start(shakeCount: 3);
      HissUserInfoUtils.instance.updatePropNum(hissPropType: HissPropType.tips, addNum: 1);
      clickHint();
    });
  }

  _cancelNoOperationTimer(){
    _noOperationTimer?.cancel();
    _noOperationTimer=null;
  }

  clickPig(){
    if(!canClick){
      return;
    }
    HissRoutersUtils.instance.toNextPageByNamed(routerName: HissBBBRouters.pig);
  }

  clickAdBtn(){
    if(!canClick){
      return;
    }
    HissPointUtils.instance.pointEvent(hissPointEnum: HissPointEnum.game_adc);
    HissAdUtils.instance.showBBBAd(
      adType: AdType.reward,
      hissAdEnum: HissAdEnum.ccqes_gamead_rv,
      showAd: HissShowAdUtils.instance.showAd(AdType.reward),
      closeAdCallback: (give){
        HissUserInfoUtils.instance.updateMoney(HissValueConfigUtils.instance.lookAdAddMoneyNum());
      },
    );
  }

  clickSet(){
    if(!canClick){
      return;
    }
    HissRoutersUtils.instance.showDialog(child: SetDialog());
  }

  clickGiftBtn(){
    HissRoutersUtils.instance.toNextPageByNamed(routerName: HissBBBRouters.wheel);
  }

  bool foundationsOnWillAccept(Map<String, dynamic>? data, int index){
    List<HissCardBean> moving = data!["cards"];
    if (moving.length != 1){
      return false;
    }
    return canMoveToFoundation(moving.first, foundationsList[index]);
  }

  foundationsOnAccept(Map<String, dynamic> data, int index){
    _saveSnapshot();
    HissCardBean card = data['cards'][0];
    if (data['fromWaste'] == true) {
      wastePileList.remove(card);
      foundationsList[index].add(card);
      _isDragging = false;
      _draggingFromCol = null;
      _draggingStartIndex = null;
      update(["stock_pile","foundations",]);
    }
    // else {
    //   int fromCol = data['fromCol'];
    //   int startIndex = data['startIndex'];
    //   cardList[fromCol].removeRange(startIndex, cardList[fromCol].length);
    //   if (cardList[fromCol].isNotEmpty) {
    //     cardList[fromCol].last.isFaceUp = true;
    //   }
    // }
    //校验游戏通关了
    _checkPlayEnd();
  }

  bool emptyPlaceOnWillAccept(Map<String, dynamic>? data, HissEmptyPlaceBean bean){
    if(null==data){
      return false;
    }
    List<HissCardBean?> moving = data["cards"];
    if (moving.length != 1){
      return false;
    }
    var indexWhere = moving.indexWhere((value)=>value?.isWheel==true||value?.isCoins==true);
    if(indexWhere>=0){
      return false;
    }
    if(null==bean.hissCardBean&&bean.lock){
      _unlockEmptyPlace(bean);
      return false;
    }
    return null==bean.hissCardBean&&!bean.lock;
  }

  emptyPlaceOnAccept(Map<String, dynamic> data, int index){
    _saveSnapshot();
    _uploadMovePoint();
    HissCardBean card = data['cards'][0];
    emptyPlaceList[index].hissCardBean=card;
    if(data['fromWaste'] == true){
      wastePileList.removeAt(data["wasteIndex"]);
      update(["stock_pile"]);
    }else{
      int fromCol = data['fromCol'];
      int startIndex = data['startIndex'];
      cardList[fromCol].removeAt(startIndex);
      HissCardBean? showDiamondCard;
      HissCardBean? showGiftPuzzleCard;
      if (cardList[fromCol].isNotEmpty){
        var fromLast = cardList[fromCol].last;
        fromLast.front = true;
        if(fromLast.isCoins!=true){
          if(fromLast.isGift==true){
            showGiftPuzzleCard=fromLast;
          }else if(HissValueConfigUtils.instance.showDiamondIcon()){
            showDiamondCard=fromLast;
          }
        }
      }
      _checkIsDiamondOrGiftPuzzle(showDiamondCard,showGiftPuzzleCard);
      update(["card_list"]);
    }
    update(["empty_place",]);
  }

  clickEmptyPlaceItem(int index)async{
    if(!canClick){
      return;
    }
    var bean = emptyPlaceList[index];
    if(null==bean.hissCardBean&&bean.lock){
      _unlockEmptyPlace(bean);
      return;
    }
    var card = bean.hissCardBean;
    if(null==card){
      return;
    }

    var foundationIndex=-1;
    for (int f = 0; f < 4; f++) {
      if (_canMoveToFoundation(card, foundationsList[f])) {
        foundationIndex=f;
        break;
      }
    }
    canClick=false;
    if(foundationIndex<0){
      var canMoveToCardList = _checkCanMoveToCardList(card);
      if(canMoveToCardList>=0){
        bean.hissCardBean=null;
        update(["empty_place"]);
        HissSendEventUtils.instance.sendEvent(
          data: HissEventData(
            eventCode: HissEventCode.moveToCardList,
            anyEventValue: {
              "startGlobalKey":bean.globalKey,
              "endGlobalKey":cardList[canMoveToCardList].last.globalKey,
              "cardList":[card],
              "cardWidth":cardWidth,
              "cardHeight":cardHeight,
            },
          ),
        );
        await Future.delayed(Duration(milliseconds: 280));
        cardList[canMoveToCardList].add(card);
        canClick=true;
        update(["card_list"]);
        return;
      }
      canClick=true;
      return;
    }
    _uploadMovePoint();
    _cancelNoOperationTimer();
    HissSendEventUtils.instance.sendEvent(
      data: HissEventData(
        eventCode: HissEventCode.aMoveCardToFoundation,
        anyEventValue: {
          "startGlobalKey":bean.globalKey,
          "endGlobalKey":foundationsGlobalKeyList[foundationIndex],
          "card":card,
          "cardWidth":cardWidth,
          "cardHeight":cardHeight,
        },
      ),
    );
    await Future.delayed(Duration(milliseconds: 280));
    _saveSnapshot();
    foundationsList[foundationIndex].add(card);
    currentScore+=10;
    bean.hissCardBean=null;
    update(["foundations","score","empty_place"]);
    canClick=true;
  }

  _unlockEmptyPlace(HissEmptyPlaceBean bean){
    HissPointUtils.instance.pointEvent(hissPointEnum: HissPointEnum.placeholder_card);
    HissAdUtils.instance.showBBBAd(
      adType: AdType.reward,
      hissAdEnum: HissAdEnum.ccqes_placeholder_rv,
      showAd: HissShowAdUtils.instance.showAd(AdType.reward),
      closeAdCallback: (give){
        if(give){
          bean.lock=false;
          update(["empty_place"]);
        }
      },
    );
  }

  _checkShowPuzzleGuide(){

    // if(!showPuzzleGuide.getData()){
    //   return;
    // }
    //实物对话框显示
    showPuzzleGuide.saveData(false);
    var renderBox = giftPuzzleGlobalKey.currentContext?.findRenderObject() as RenderBox;
    giftGuideOffset = renderBox.localToGlobal(Offset.zero);
    update(["gift_guide"]);
    _giftGuideTimer?.cancel();
    _giftGuideTimer=Timer(Duration(milliseconds: 3000), (){
      giftGuideOffset=null;
      update(["gift_guide"]);
    });
    // HissOverlayUtils.instance.showOverlay(
    //     context: buildContext,
    //     widget: HissPuzzleOverlay(
    //       offset: offset,
    //       callback: (){
    //         HissOverlayUtils.instance.hideOverlay();
    //       },
    //     ),
    // );
  }

  toCashPage(){
    HissRoutersUtils.instance.toNextPageByNamed(routerName: HissBBBRouters.cash);
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
      case HissEventCode.updateWheelNum:
        update(["wheel_num"]);
        break;
      case HissEventCode.useSuperProp:
        useSuperProp();
        break;
    }
  }

  //使用超级道具，就是把牌区或者待牌区抽4张牌移动到收纳区
  useSuperProp()async{
    List<SuperPropCardBean> resultListFromCardList=[];
    for(var foundationIndex=0;foundationIndex<foundationsList.length;foundationIndex++){
      var foundationsValue = foundationsList[foundationIndex];
      HissCardBean? targetBean;
      if(foundationsValue.isNotEmpty){
        targetBean=foundationsValue.last;
      }
      var hissCardBean = _getCanToFoundationsInAllCard(targetBean,resultListFromCardList);
      if(null!=hissCardBean){
        resultListFromCardList.add(SuperPropCardBean(cardBean: hissCardBean,foundationIndex: foundationIndex,fromCardList: true));
      }else{
        var hissCardBean2 = _getCanToFoundationsFromWaste(targetBean,resultListFromCardList);
        if(null!=hissCardBean2){
          resultListFromCardList.add(SuperPropCardBean(cardBean: hissCardBean2,foundationIndex: foundationIndex,fromWaste: true));
        }else{
          var hissCardBean3 = _getCanToFoundationsFromStock(targetBean,resultListFromCardList);
          if(null!=hissCardBean3){
            resultListFromCardList.add(SuperPropCardBean(cardBean: hissCardBean3,foundationIndex: foundationIndex,fromStock: true));
          }
        }
      }
    }
    if(resultListFromCardList.isNotEmpty){
      canClick=false;
      for (var value in resultListFromCardList) {
        HissSendEventUtils.instance.sendEvent(
          data: HissEventData(
            eventCode: HissEventCode.aMoveCardToFoundation,
            anyEventValue: {
              "startGlobalKey":value.fromStock==true?stockPileGlobalKey:value.cardBean.globalKey,
              "endGlobalKey":foundationsGlobalKeyList[value.foundationIndex??0],
              "card":value.cardBean,
              "cardWidth":cardWidth,
              "cardHeight":cardHeight,
            },
          ),
        );
        await Future.delayed(Duration(milliseconds: 300));
        _saveSnapshot();
        foundationsList[value.foundationIndex??0].add(value.cardBean);
        currentScore+=10;
        for (var value1 in cardList) {
          value1.removeWhere((v)=>v.value==value.cardBean.value&&v.cardType==value.cardBean.cardType);
          if(value1.isNotEmpty&&!value1.last.front){
            value1.last.front=true;
          }
        }
        wastePileList.removeWhere((v)=>v.value==value.cardBean.value&&v.cardType==value.cardBean.cardType);
        stockPileList.removeWhere((v)=>v.value==value.cardBean.value&&v.cardType==value.cardBean.cardType);
        update(["card_list","foundations","score","stock_pile"]);
        await Future.delayed(Duration(milliseconds: 100));
      }
      canClick=true;
      await Future.delayed(Duration(milliseconds: 50));
      _checkPlayEnd();
      return;
    }
  }

  //从全部牌区选出4个能移动到收纳区的牌
  HissCardBean? _getCanToFoundationsInAllCard(HissCardBean? targetBean,List<SuperPropCardBean> resourceList){
    for (var value in cardList) {
      for (var value1 in value) {
        var indexWhere = resourceList.indexWhere((v)=>v.cardBean.value==value1.value&&v.cardBean.cardType==value1.cardType);
        if(value1.isCoins==true||value1.isWheel==true||indexWhere>=0){
          continue;
        }
        //直接找A
        if(null==targetBean){
          if(value1.value==1){
            return value1;
          }
        }else{
          if(targetBean.value+1==value1.value&&targetBean.cardType == value1.cardType){
            return value1;
          }
        }
      }
    }
    return null;
  }

  //从waste选出能移动到收纳区的牌
  HissCardBean? _getCanToFoundationsFromWaste(HissCardBean? targetBean,List<SuperPropCardBean> resourceList){
    for (var value1 in wastePileList) {
      var indexWhere = resourceList.indexWhere((v)=>v.cardBean.value==value1.value&&v.cardBean.cardType==value1.cardType);
      if(indexWhere>=0){
        continue;
      }
      //直接找A
      if(null==targetBean){
        if(value1.value==1){
          return value1;
        }
      }else{
        if(targetBean.value+1==value1.value&&targetBean.cardType == value1.cardType){
          return value1;
        }
      }
    }
    return null;
  }

  //从stock选出能移动到收纳区的牌
  HissCardBean? _getCanToFoundationsFromStock(HissCardBean? targetBean,List<SuperPropCardBean> resourceList){
    for (var value1 in stockPileList) {
      var indexWhere = resourceList.indexWhere((v)=>v.cardBean.value==value1.value&&v.cardBean.cardType==value1.cardType);
      if(indexWhere>=0){
        continue;
      }
      //直接找A
      if(null==targetBean){
        if(value1.value==1){
          return value1;
        }
      }else{
        if(targetBean.value+1==value1.value&&targetBean.cardType == value1.cardType){
          return value1;
        }
      }
    }
    return null;
  }

  _uploadMovePoint(){
    HissPointUtils.instance.pointEvent(hissPointEnum: HissPointEnum.move_card);
  }

  _autoShowWheelDialog(HissCardBean? bean,{bool alreadyShowDialog = false})async{
    if(firstMoveCardToFoundations.getData()||firstGetPuzzle.getData()){
      return;
    }

    await Future.delayed(Duration(milliseconds: 1000));

    if(bean?.isWheel==true&&!alreadyShowDialog){
      _showWheelAnimator(bean);
      bean?.isWheel=false;
      update(["card_list"]);
    }
  }

  _showWheelAnimator(HissCardBean? bean)async{
    HissSendEventUtils.instance.sendEvent(
      data: HissEventData(
        eventCode: HissEventCode.showWheelAnimator,
        anyEventValue: {
          "card":bean,
          "cardWidth":cardWidth,
          "cardHeight":cardHeight,
        },
      ),
    );
    await Future.delayed(Duration(milliseconds: 1000));
    HissRoutersUtils.instance.showDialog(
      child: WheelDialog(),
    );
  }

  @override
  void onClose() {
    _playGameTimer?.cancel();
    _noOperationTimer?.cancel();
    _emptyTipsTimer?.cancel();
    _giftGuideTimer?.cancel();
    playGamePageOpen=false;
    super.onClose();
  }
}

class _Pos {
  final int i;
  final int j;

  _Pos(this.i, this.j);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is _Pos && i == other.i && j == other.j;

  @override
  int get hashCode => i.hashCode ^ j.hashCode;
}
