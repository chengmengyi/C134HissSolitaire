import 'dart:async';

import 'package:flutter/material.dart';

// ---------------- 花色 ----------------
enum Suit { hearts, spades, clubs, diamonds }

String suitName(Suit s) {
  switch (s) {
    case Suit.hearts:
      return "红桃";
    case Suit.spades:
      return "黑桃";
    case Suit.clubs:
      return "梅花";
    case Suit.diamonds:
      return "方块";
  }
}

// 判断花色是否为红色
bool isRedSuit(Suit suit) {
  return suit == Suit.hearts || suit == Suit.diamonds;
}

// ---------------- 牌模型 ----------------
class CardModel {
  final int value; // 1~13 代表 A ~ K
  final Suit suit;
  bool isFaceUp;

  CardModel(this.value, this.suit, {this.isFaceUp = true});

  @override
  String toString() {
    return 'CardModel {$suit $value faceUp=$isFaceUp}';
  }
}

// ---------------- 游戏快照 ----------------
class _GameStateSnapshot {
  final List<List<CardModel>> cardList;
  final List<List<CardModel>> foundations;
  final List<CardModel> stockPile;
  final List<CardModel> wastePile;

  _GameStateSnapshot({
    required this.cardList,
    required this.foundations,
    required this.stockPile,
    required this.wastePile,
  });

  /// 深拷贝列
  static List<List<CardModel>> cloneColumns(List<List<CardModel>> src) {
    return src
        .map(
          (col) => col
          .map((c) => CardModel(c.value, c.suit, isFaceUp: c.isFaceUp))
          .toList(),
    )
        .toList();
  }

  /// 深拷贝一维列表
  static List<CardModel> cloneList(List<CardModel> src) {
    return src
        .map((c) => CardModel(c.value, c.suit, isFaceUp: c.isFaceUp))
        .toList();
  }

  factory _GameStateSnapshot.from(
      List<List<CardModel>> cardList,
      List<List<CardModel>> foundations,
      List<CardModel> stockPile,
      List<CardModel> wastePile,
      ) {
    return _GameStateSnapshot(
      cardList: cloneColumns(cardList),
      foundations: cloneColumns(foundations),
      stockPile: cloneList(stockPile),
      wastePile: cloneList(wastePile),
    );
  }
}

// ---------------- 发牌动画数据 ----------------
class _DealingCard {
  final CardModel card;
  final int targetColumn;
  final int targetRow;
  AnimationController? controller;
  Animation<Offset>? animation;

  _DealingCard({
    required this.card,
    required this.targetColumn,
    required this.targetRow,
  });
}

// ---------------- 页面 ----------------
class SolitairePage extends StatefulWidget {
  const SolitairePage({super.key});

  @override
  State<SolitairePage> createState() => _SolitairePageState();
}

class _SolitairePageState extends State<SolitairePage> with SingleTickerProviderStateMixin {
  List<List<CardModel>> cardList = [];
  List<List<CardModel>> foundations = [[], [], [], []];
  List<CardModel> stockPile = [];
  List<CardModel> wastePile = [];

  // 拖动状态
  bool _isDragging = false;
  int? _draggingFromCol;
  int? _draggingStartIndex;
  List<CardModel>? _draggingCards;

  // 撤销栈
  List<_GameStateSnapshot> _history = [];

  // 发牌动画相关
  bool _isDealing = true;
  List<_DealingCard> _dealingCards = [];
  List<Offset> _columnPositions = [];
  int _cardsDealt = 0;
  Timer? _dealTimer;

  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

  @override
  void dispose() {
    _dealTimer?.cancel();
    // 清理所有动画控制器
    for (var dealingCard in _dealingCards) {
      dealingCard.controller?.dispose();
    }
    super.dispose();
  }

  void _initializeGame() {
    List<CardModel> fullDeck = [];
    for (var suit in Suit.values) {
      for (int v = 1; v <= 13; v++) {
        fullDeck.add(CardModel(v, suit, isFaceUp: false));
      }
    }

    fullDeck.shuffle();

    // 初始化7列空列表
    for (var i = 0; i < 7; i++) {
      cardList.add([]);
    }

    // 设置发牌堆
    stockPile = fullDeck;

    // 开始发牌动画
    _startDealAnimation();
  }

  /// 开始发牌动画
  void _startDealAnimation() {
    // 延迟一帧以确保布局完成
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _calculateColumnPositions();
      _startContinuousDealing();
    });
  }

  /// 计算各列的位置
  void _calculateColumnPositions() {
    _columnPositions.clear();

    final screenWidth = MediaQuery.of(context).size.width;
    final columnWidth = screenWidth / 7;

    for (int i = 0; i < 7; i++) {
      _columnPositions.add(Offset(
        i * columnWidth + columnWidth / 2 - 25,
        250, // 所有牌从同一高度开始
      ));
    }
  }

  /// 开始连续发牌
  void _startContinuousDealing() {
    // 创建所有要发的牌
    _createDealingCards();

    // 开始定时发牌
    _dealTimer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      if (_cardsDealt >= _dealingCards.length) {
        timer.cancel();
        _finishDealing();
        return;
      }

      _dealNextCard();
    });
  }

  /// 创建所有发牌动画数据
  void _createDealingCards() {
    _dealingCards.clear();

    // 复制stockPile用于发牌
    List<CardModel> tempStock = List.from(stockPile.reversed);

    // 按照接龙发牌规则创建发牌数据
    for (int col = 0; col < 7; col++) {
      for (int row = 0; row <= col; row++) {
        if (tempStock.isNotEmpty) {
          final card = tempStock.removeLast();
          _dealingCards.add(_DealingCard(
            card: card,
            targetColumn: col,
            targetRow: row,
          ));
        }
      }
    }

    // 更新实际的stockPile（移除已经安排发牌的牌）
    stockPile = tempStock.reversed.toList();
  }

  /// 发下一张牌
  void _dealNextCard() {
    if (_cardsDealt >= _dealingCards.length) return;

    final dealingCard = _dealingCards[_cardsDealt];

    // 创建动画控制器
    dealingCard.controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    // 创建位置动画
    dealingCard.animation = Tween<Offset>(
      begin: Offset(MediaQuery.of(context).size.width - 80, 50), // 从抽牌区域开始
      end: Offset(
        _columnPositions[dealingCard.targetColumn].dx,
        _columnPositions[dealingCard.targetColumn].dy + dealingCard.targetRow * 20,
      ),
    ).animate(CurvedAnimation(
      parent: dealingCard.controller!,
      curve: Curves.easeOut,
    ));

    // 启动动画
    dealingCard.controller!.forward();

    // 将牌添加到目标列
    cardList[dealingCard.targetColumn].add(dealingCard.card);

    _cardsDealt++;
    setState(() {});
  }

  /// 完成发牌
  void _finishDealing() {
    setState(() {
      _isDealing = false;
      // 翻开每列的最后一张牌
      for (var col in cardList) {
        if (col.isNotEmpty) {
          col.last.isFaceUp = true;
        }
      }
      // 清理发牌数据
      _dealingCards.clear();
    });
  }

  /// ---------------- Undo ----------------
  void _saveSnapshot() {
    _history.add(_GameStateSnapshot.from(
        cardList, foundations, stockPile, wastePile));
  }

  void _undoStep() {
    if (_history.isEmpty) return;

    final last = _history.removeLast();

    setState(() {
      cardList = _GameStateSnapshot.cloneColumns(last.cardList);
      foundations = _GameStateSnapshot.cloneColumns(last.foundations);
      stockPile = _GameStateSnapshot.cloneList(last.stockPile);
      wastePile = _GameStateSnapshot.cloneList(last.wastePile);

      _isDragging = false;
      _draggingFromCol = null;
      _draggingStartIndex = null;
      _draggingCards = null;
    });
  }

  /// ---------------- 移动规则 ----------------
  bool canMoveToFoundation(CardModel card, List<CardModel> foundation) {
    if (foundation.isEmpty) return card.value == 1;
    final last = foundation.last;
    return last.suit == card.suit && last.value == card.value - 1;
  }

  bool canMoveToColumn(CardModel card, List<CardModel> targetColumn) {
    if (targetColumn.isEmpty) return true;
    final targetCard = targetColumn.last;
    if (targetCard.value != card.value + 1) return false;
    return isRedSuit(targetCard.suit) != isRedSuit(card.suit);
  }

  void tryAutoMoveToFoundation(int colIndex, int rowIndex) {
    final card = cardList[colIndex][rowIndex];
    if (rowIndex != cardList[colIndex].length - 1 || !card.isFaceUp) return;

    for (int f = 0; f < 4; f++) {
      if (canMoveToFoundation(card, foundations[f])) {
        _saveSnapshot();
        setState(() {
          foundations[f].add(card);
          cardList[colIndex].removeLast();
          if (cardList[colIndex].isNotEmpty)
            cardList[colIndex].last.isFaceUp = true;
        });
        return;
      }
    }
  }

  void flipCardFromStock() {
    if (stockPile.isEmpty && wastePile.isEmpty) return;

    _saveSnapshot();
    setState(() {
      if (stockPile.isEmpty) {
        stockPile = wastePile
            .reversed
            .map((c) => CardModel(c.value, c.suit, isFaceUp: false))
            .toList();
        wastePile.clear();
      } else {
        final card = stockPile.removeLast();
        card.isFaceUp = true;
        wastePile.add(card);
        if (wastePile.length > 3) {
          final firstCard = wastePile.removeAt(0);
          firstCard.isFaceUp = false;
          stockPile.insert(0, firstCard);
        }
      }
      _checkAutoMoveWasteToFoundation();
    });
  }

  void _checkAutoMoveWasteToFoundation() {
    if (wastePile.isEmpty) return;
    final topCard = wastePile.last;
    for (int f = 0; f < 4; f++) {
      if (canMoveToFoundation(topCard, foundations[f])) {
        _saveSnapshot();
        setState(() {
          foundations[f].add(topCard);
          wastePile.removeLast();
          _checkAutoMoveWasteToFoundation();
        });
        return;
      }
    }
  }

  void tryMoveWasteToFoundation() {
    if (wastePile.isEmpty) return;
    final topCard = wastePile.last;
    for (int f = 0; f < 4; f++) {
      if (canMoveToFoundation(topCard, foundations[f])) {
        _saveSnapshot();
        setState(() {
          foundations[f].add(topCard);
          wastePile.removeLast();
        });
        return;
      }
    }
  }

  /// ---------------- 构建卡牌 ----------------
  Widget buildCard(CardModel card, {bool isDragging = false, bool isDealing = false}) {
    return Container(
      width: 50,
      height: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: card.isFaceUp
            ? (isRedSuit(card.suit) ? Colors.red : Colors.black)
            : Colors.blue,
        border: Border.all(width: 1, color: Colors.white),
        boxShadow: isDragging
            ? [
          BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 8,
              spreadRadius: 2,
              offset: Offset(0, 4))
        ]
            : isDealing
            ? [
          BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 4,
              spreadRadius: 1,
              offset: Offset(0, 2))
        ]
            : [
          BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 2,
              spreadRadius: 1,
              offset: Offset(0, 1))
        ],
      ),
      alignment: Alignment.center,
      child: card.isFaceUp
          ? Text("${suitName(card.suit)} ${card.value}",
          style: TextStyle(color: Colors.white, fontSize: 16))
          : SizedBox.shrink(),
    );
  }

  Widget _buildDragFeedback(List<CardModel> cards) {
    return Transform.scale(
      scale: 1.05,
      child: Material(
        color: Colors.transparent,
        child: SizedBox(
          width: 50,
          height: 90 + 20 * (cards.length - 1),
          child: Stack(
            children: List.generate(cards.length, (i) {
              return Positioned(
                top: i * 20,
                child: buildCard(cards[i], isDragging: true),
              );
            }),
          ),
        ),
      ),
    );
  }

  bool _isCardBeingDragged(int colIndex, int rowIndex) {
    return _isDragging &&
        _draggingFromCol == colIndex &&
        _draggingStartIndex != null &&
        rowIndex >= _draggingStartIndex!;
  }

  /// 构建发牌动画中的卡牌
  Widget _buildDealingCard(_DealingCard dealingCard) {
    if (dealingCard.animation == null) return SizedBox();

    return AnimatedBuilder(
      animation: dealingCard.animation!,
      builder: (context, child) {
        return Positioned(
          left: dealingCard.animation!.value.dx,
          top: dealingCard.animation!.value.dy,
          child: buildCard(dealingCard.card, isDealing: true),
        );
      },
    );
  }

  /// 构建所有发牌动画的卡牌
  List<Widget> _buildAllDealingCards() {
    return _dealingCards
        .where((dealingCard) => dealingCard.animation != null)
        .map((dealingCard) => _buildDealingCard(dealingCard))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isDealing ? "接龙示例（发牌中...）" : "接龙示例（带撤销）"),
        actions: [
          if (!_isDealing) IconButton(icon: Icon(Icons.undo), onPressed: _undoStep),
        ],
      ),
      body: Stack(
        children: [
          // 主游戏区域
          Column(
            children: [
              Container(
                height: 120,
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: List.generate(4, (fIndex) {
                          return Expanded(
                            child: DragTarget<Map<String, dynamic>>(
                              onWillAccept: (data) {
                                if (_isDealing) return false;
                                List<CardModel> moving = data!['cards'];
                                if (moving.length != 1) return false;
                                return canMoveToFoundation(moving.first, foundations[fIndex]);
                              },
                              onAccept: (data) {
                                _saveSnapshot();
                                setState(() {
                                  CardModel card = data['cards'][0];
                                  if (data['fromWaste'] == true)
                                    wastePile.remove(card);
                                  else {
                                    int fromCol = data['fromCol'];
                                    int startIndex = data['startIndex'];
                                    cardList[fromCol].removeRange(
                                        startIndex, cardList[fromCol].length);
                                    if (cardList[fromCol].isNotEmpty)
                                      cardList[fromCol].last.isFaceUp = true;
                                  }
                                  foundations[fIndex].add(card);
                                  _isDragging = false;
                                  _draggingFromCol = null;
                                  _draggingStartIndex = null;
                                  _draggingCards = null;
                                });
                              },
                              builder: (context, candidateData, rejectedData) {
                                return Container(
                                  height: 100,
                                  margin: EdgeInsets.all(6),
                                  decoration:
                                  BoxDecoration(border: Border.all(color: Colors.white, width: 2)),
                                  alignment: Alignment.center,
                                  child: foundations[fIndex].isEmpty
                                      ? Text("Foundation ${fIndex + 1}",
                                      style: TextStyle(color: Colors.white))
                                      : buildCard(foundations[fIndex].last),
                                );
                              },
                            ),
                          );
                        }),
                      ),
                    ),
                    Stack(
                      children: List.generate(wastePile.length, (index) {
                        return Container(
                          margin: EdgeInsets.only(left: index * 20),
                          child: GestureDetector(
                            onTap: _isDealing ? null : tryMoveWasteToFoundation,
                            child: Draggable<Map<String, dynamic>>(
                              data: {"fromWaste": true, "cards": [wastePile[index]]},
                              onDragStarted: () {
                                setState(() {
                                  _isDragging = true;
                                  _draggingCards = [wastePile[index]];
                                });
                              },
                              onDragCompleted: () {
                                setState(() {
                                  _isDragging = false;
                                  _draggingFromCol = null;
                                  _draggingStartIndex = null;
                                  _draggingCards = null;
                                });
                              },
                              onDraggableCanceled: (velocity, offset) {
                                setState(() {
                                  _isDragging = false;
                                  _draggingFromCol = null;
                                  _draggingStartIndex = null;
                                  _draggingCards = null;
                                });
                              },
                              feedback: _buildDragFeedback([wastePile[index]]),
                              childWhenDragging:
                              Opacity(opacity: 0.5, child: buildCard(wastePile[index])),
                              child: buildCard(wastePile[index]),
                            ),
                          ),
                        );
                      }),
                    ),
                    GestureDetector(
                      onTap: _isDealing ? null : flipCardFromStock,
                      child: Container(
                        width: 60,
                        height: 90,
                        margin: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.blue,
                          border: Border.all(width: 1, color: Colors.white),
                        ),
                        alignment: Alignment.center,
                        child: stockPile.isNotEmpty
                            ? Text("抽牌", style: TextStyle(color: Colors.white))
                            : SizedBox.shrink(),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: _isDealing
                    ? Container() // 发牌时不显示常规的列布局
                    : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(cardList.length, (colIndex) {
                    return Expanded(
                      child: DragTarget<Map<String, dynamic>>(
                        onWillAccept: (data) {
                          List<CardModel> movingCards = data!['cards'];
                          if (movingCards.isEmpty) return false;
                          return canMoveToColumn(movingCards.first, cardList[colIndex]);
                        },
                        onAccept: (data) {
                          _saveSnapshot();
                          setState(() {
                            List<CardModel> movingCards = data['cards'];
                            if (data['fromWaste'] == true)
                              wastePile.remove(movingCards.first);
                            else {
                              int fromCol = data['fromCol'];
                              int startIndex = data['startIndex'];
                              cardList[fromCol]
                                  .removeRange(startIndex, cardList[fromCol].length);
                              if (cardList[fromCol].isNotEmpty)
                                cardList[fromCol].last.isFaceUp = true;
                            }
                            cardList[colIndex].addAll(movingCards);
                            _isDragging = false;
                            _draggingFromCol = null;
                            _draggingStartIndex = null;
                            _draggingCards = null;
                          });
                        },
                        builder: (context, candidateData, rejectedData) {
                          final list = cardList[colIndex];
                          Color backgroundColor = candidateData.isNotEmpty
                              ? Colors.green.withOpacity(0.3)
                              : Colors.transparent;
                          return Container(
                            height: double.infinity,
                            decoration: BoxDecoration(
                                color: backgroundColor,
                                border: Border.all(
                                    color: Colors.grey.withOpacity(0.5), width: 1)),
                            child: Stack(
                              children: List.generate(list.length, (rowIndex) {
                                final card = list[rowIndex];
                                if (_isCardBeingDragged(colIndex, rowIndex))
                                  return Positioned(
                                      top: rowIndex * 20,
                                      left: 0,
                                      right: 0,
                                      child: SizedBox(width: 60, height: 90));

                                Widget cardWidget;
                                if (card.isFaceUp) {
                                  // ---------------- 点击 + 拖拽 ----------------
                                  cardWidget = GestureDetector(
                                    behavior: HitTestBehavior.translucent,
                                    onTap: () {
                                      // 仅列顶部牌可自动上 Foundation
                                      if (rowIndex == list.length - 1)
                                        tryAutoMoveToFoundation(colIndex, rowIndex);
                                    },
                                    child: LongPressDraggable<Map<String, dynamic>>(
                                      delay: Duration(milliseconds: 50),
                                      hitTestBehavior: HitTestBehavior.translucent,
                                      data: {
                                        "fromCol": colIndex,
                                        "startIndex": rowIndex,
                                        "cards": list.sublist(rowIndex),
                                        "fromWaste": false
                                      },
                                      onDragStarted: () {
                                        setState(() {
                                          _isDragging = true;
                                          _draggingFromCol = colIndex;
                                          _draggingStartIndex = rowIndex;
                                          _draggingCards = list.sublist(rowIndex);
                                        });
                                      },
                                      onDragCompleted: () {
                                        setState(() {
                                          _isDragging = false;
                                          _draggingFromCol = null;
                                          _draggingStartIndex = null;
                                          _draggingCards = null;
                                        });
                                      },
                                      onDraggableCanceled: (velocity, offset) {
                                        setState(() {
                                          _isDragging = false;
                                          _draggingFromCol = null;
                                          _draggingStartIndex = null;
                                          _draggingCards = null;
                                        });
                                      },
                                      feedback: _buildDragFeedback(list.sublist(rowIndex)),
                                      childWhenDragging:
                                      Opacity(opacity: 0.5, child: buildCard(card)),
                                      child: buildCard(card),
                                    ),
                                  );
                                } else
                                  cardWidget = buildCard(card);

                                return Positioned(
                                    top: rowIndex * 20, left: 0, right: 0, child: cardWidget);
                              }),
                            ),
                          );
                        },
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),

          // 发牌动画层
          if (_isDealing) ..._buildAllDealingCards(),
        ],
      ),
    );
  }
}