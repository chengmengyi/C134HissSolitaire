import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hiss_bbb/bean/game_state_snapshot_bean.dart';
import 'package:hiss_bbb/bean/hiss_card_bean.dart';
import 'package:hiss_bbb/bean/hiss_hint_bean.dart';
import 'package:hiss_bbb/ui/dialog/add_prop_dialog/add_prop_dialog.dart';
import 'package:hiss_bbb/ui/dialog/money_card_reward_dialog/money_card_reward_dialog.dart';
import 'package:hiss_bbb/ui/dialog/play_success_dialog/play_success_dialog.dart';
import 'package:hiss_bbb/ui/dialog/random_prop_dialog/random_prop_dialog.dart';
import 'package:hiss_bbb/ui/dialog/set_dialog/set_dialog.dart';
import 'package:hiss_bbb/utils/hiss_b_routers.dart';
import 'package:hiss_bbb/utils/hiss_cash_task_utils.dart';
import 'package:hiss_bbb/utils/hiss_daily_task_utils.dart';
import 'package:hiss_bbb/utils/hiss_enum/hiss_card_type.dart';
import 'package:hiss_bbb/utils/hiss_enum/hiss_prop_type.dart';
import 'package:hiss_bbb/utils/hiss_enum/hiss_task_type.dart';
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
      currentScore=0,currentStep=0,currentTime=0,appBackground=false,_showRandomPropDialog=true,
      canClick=true;
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
    update(["foundations","stock_pile","card_bg"]);

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
    final random = Random();
    final allPos = <_Pos>[];

    for (int i = 0; i < list2D.length; i++) {
      final row = list2D[i];
      if (row.isEmpty) continue;

      for (int j = 0; j < row.length; j++) {
        final item = row[j];
        item.isCoins = false;
        item.isGift = false;

        if (j == row.length - 1) continue;

        allPos.add(_Pos(i, j));
      }
    }
    if (allPos.isEmpty) return;
    allPos.shuffle(random);
    final coinsCount = coinsNum.clamp(0, allPos.length);

    final usedPos = <_Pos>{};

    for (int i = 0; i < coinsCount; i++) {
      final p = allPos[i];
      list2D[p.i][p.j].isCoins = true;
      usedPos.add(p);
    }
    final giftCandidates =
    allPos.where((p) => !usedPos.contains(p)).toList();

    if (giftCandidates.isEmpty) return;
    giftCandidates.shuffle(random);
    final giftCount = puzzleNum.clamp(0, giftCandidates.length);

    for (int i = 0; i < giftCount; i++) {
      final p = giftCandidates[i];
      list2D[p.i][p.j].isGift = true;
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
      currentScore+=5;
    }
    cardList[colIndex].addAll(movingCards);
    _isDragging = false;
    _draggingFromCol = null;
    _draggingStartIndex = null;
    currentStep++;
    update(["card_list","stock_pile","step","score"]);
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

    if(stockPileList.isEmpty&&wastePileList.isEmpty&&allFront){
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
        canClick=false;
        card.showCard=false;
        update(["card_list"]);
        HissSendEventUtils.instance.sendEvent(
          data: HissEventData(
            eventCode: HissEventCode.aMoveCardToFoundation,
            anyEventValue: {
              "startGlobalKey":card.globalKey,
              "endGlobalKey":foundationsGlobalKeyList[foundationIndex],
              "card":card,
              "cardWidth":cardWidth,
              "cardHeight":cardHeight,
            },
          ),
        );
        await Future.delayed(Duration(milliseconds: 280));
        card.showCard=true;
        _saveSnapshot();
        foundationsList[foundationIndex].add(card);
        cardList[colIndex].removeLast();
        if (cardList[colIndex].isNotEmpty){
          cardList[colIndex].last.front = true;
        }
        currentScore+=10;
        update(["card_list","foundations","score"]);
        canClick=true;
        await Future.delayed(Duration(milliseconds: 50));
        _checkPlayEnd();
      }else{
        canClick=true;
      }
    }else{
      canClick=true;
    }
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
    if (!canClick||rowIndex != list.length - 1){
      return;
    }
    canClick=false;
    final card = cardList[colIndex][rowIndex];
    if(card.isCoins==true){
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
      return;
    }
    if (rowIndex != cardList[colIndex].length - 1 || !card.front){
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
    await Future.delayed(Duration(milliseconds: 280));
    card.showCard=true;
    _saveSnapshot();
    foundationsList[index].add(card);
    cardList[colIndex].removeLast();
    if (cardList[colIndex].isNotEmpty){
      cardList[colIndex].last.front = true;
      HissUserInfoUtils.instance.updateMoney(HissValueConfigUtils.instance.getFlipCardAddNum());
      var last = cardList[colIndex].last;
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
    currentScore+=10;
    update(["card_list","foundations","score"]);
    await Future.delayed(Duration(milliseconds: 100));
    canClick=true;
    //校验游戏通关了
    _checkPlayEnd();
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
            _showRandomPropDialog=true;
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
    update(["stock_pile"]);
    Future.delayed(Duration(milliseconds: 200),(){
      _canClickStockPile=true;
    });
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
    if(!canClick){
      return;
    }
    HissPointUtils.instance.pointEvent(hissPointEnum: HissPointEnum.game_retract);
    if(bBackPropNum.getData()<=0){
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
    HissDailyTaskUtils.instance.updateDailyTaskProgress(HissTaskType.tool);
    HissCashTaskUtils.instance.updateCashTask(HissTaskType.tool);
  }

  clickHint(){
    if(!canClick){
      return;
    }
    HissPointUtils.instance.pointEvent(hissPointEnum: HissPointEnum.game_remind);
    if(bTipsPropNum.getData()<=0){
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
    }
  }

  @override
  void onClose() {
    _playGameTimer?.cancel();
    _noOperationTimer?.cancel();
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
