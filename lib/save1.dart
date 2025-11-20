import 'dart:math';
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

// ---------------- 页面 ----------------
class SolitairePage extends StatefulWidget {
  const SolitairePage({super.key});

  @override
  State<SolitairePage> createState() => _SolitairePageState();
}

class _SolitairePageState extends State<SolitairePage> {
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

  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

  void _initializeGame() {
    List<CardModel> fullDeck = [];
    for (var suit in Suit.values) {
      for (int v = 1; v <= 13; v++) {
        fullDeck.add(CardModel(v, suit, isFaceUp: false));
      }
    }

    fullDeck.shuffle();

    int index = 0;
    for (var i = 0; i < 7; i++) {
      List<CardModel> col = [];
      for (var j = 0; j <= i; j++) {
        col.add(fullDeck[index++]);
      }
      col.last.isFaceUp = true;
      cardList.add(col);
    }

    stockPile = fullDeck.sublist(index);
  }

  /// ---------------- Undo ----------------
  void _saveSnapshot() {
    _history.add(_GameStateSnapshot.from(cardList, foundations, stockPile, wastePile));
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
          if (cardList[colIndex].isNotEmpty) cardList[colIndex].last.isFaceUp = true;
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
        stockPile = wastePile.reversed.map((c) => CardModel(c.value, c.suit, isFaceUp: false)).toList();
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
  Widget buildCard(CardModel card, {bool isDragging = false}) {
    return Container(
      width: 50,
      height: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: card.isFaceUp ? (isRedSuit(card.suit) ? Colors.red : Colors.black) : Colors.blue,
        border: Border.all(width: 1, color: Colors.white),
        boxShadow: isDragging
            ? [BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 8, spreadRadius: 2, offset: Offset(0, 4))]
            : [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 2, spreadRadius: 1, offset: Offset(0, 1))],
      ),
      alignment: Alignment.center,
      child: card.isFaceUp
          ? Text("${suitName(card.suit)} ${card.value}", style: TextStyle(color: Colors.white, fontSize: 16))
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
    return _isDragging && _draggingFromCol == colIndex && _draggingStartIndex != null && rowIndex >= _draggingStartIndex!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("接龙示例（带撤销）"),
        actions: [
          IconButton(icon: Icon(Icons.undo), onPressed: _undoStep),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 120,
            child: Row(
              children: [
                GestureDetector(
                  onTap: flipCardFromStock,
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
                    child: stockPile.isNotEmpty ? Text("抽牌", style: TextStyle(color: Colors.white)) : SizedBox.shrink(),
                  ),
                ),
                Stack(
                  children: List.generate(wastePile.length, (index) {
                    return Container(
                      margin: EdgeInsets.only(left: index * 20),
                      child: GestureDetector(
                        onTap: tryMoveWasteToFoundation,
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
                          childWhenDragging: Opacity(opacity: 0.5, child: buildCard(wastePile[index])),
                          child: buildCard(wastePile[index]),
                        ),
                      ),
                    );
                  }),
                ),
                Expanded(
                  child: Row(
                    children: List.generate(4, (fIndex) {
                      return Expanded(
                        child: DragTarget<Map<String, dynamic>>(
                          onWillAccept: (data) {
                            List<CardModel> moving = data!['cards'];
                            if (moving.length != 1) return false;
                            return canMoveToFoundation(moving.first, foundations[fIndex]);
                          },
                          onAccept: (data) {
                            _saveSnapshot();
                            setState(() {
                              CardModel card = data['cards'][0];
                              if (data['fromWaste'] == true) wastePile.remove(card);
                              else {
                                int fromCol = data['fromCol'];
                                int startIndex = data['startIndex'];
                                cardList[fromCol].removeRange(startIndex, cardList[fromCol].length);
                                if (cardList[fromCol].isNotEmpty) cardList[fromCol].last.isFaceUp = true;
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
                              decoration: BoxDecoration(border: Border.all(color: Colors.white, width: 2)),
                              alignment: Alignment.center,
                              child: foundations[fIndex].isEmpty
                                  ? Text("Foundation ${fIndex + 1}", style: TextStyle(color: Colors.white))
                                  : buildCard(foundations[fIndex].last),
                            );
                          },
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
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
                        if (data['fromWaste'] == true) wastePile.remove(movingCards.first);
                        else {
                          int fromCol = data['fromCol'];
                          int startIndex = data['startIndex'];
                          cardList[fromCol].removeRange(startIndex, cardList[fromCol].length);
                          if (cardList[fromCol].isNotEmpty) cardList[fromCol].last.isFaceUp = true;
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
                      Color backgroundColor = candidateData.isNotEmpty ? Colors.green.withOpacity(0.3) : Colors.transparent;
                      return Container(
                        height: double.infinity,
                        decoration: BoxDecoration(color: backgroundColor, border: Border.all(color: Colors.grey.withOpacity(0.5), width: 1)),
                        child: Stack(
                          children: List.generate(list.length, (rowIndex) {
                            final card = list[rowIndex];
                            if (_isCardBeingDragged(colIndex, rowIndex)) return Positioned(top: rowIndex * 20, left: 0, right: 0, child: SizedBox(width: 60, height: 90));

                            Widget cardWidget;
                            if (card.isFaceUp) {
                              cardWidget = GestureDetector(
                                onTap: () => tryAutoMoveToFoundation(colIndex, rowIndex),
                                child: LongPressDraggable<Map<String, dynamic>>(
                                  delay: Duration(milliseconds: 0),
                                  hitTestBehavior: HitTestBehavior.translucent,
                                  data: {"fromCol": colIndex, "startIndex": rowIndex, "cards": list.sublist(rowIndex), "fromWaste": false},
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
                                  childWhenDragging: Opacity(opacity: 0.5, child: buildCard(card)),
                                  child: buildCard(card),
                                ),
                              );
                            } else cardWidget = buildCard(card);

                            return Positioned(top: rowIndex * 20, left: 0, right: 0, child: cardWidget);
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
    );
  }
}