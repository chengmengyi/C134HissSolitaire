import 'package:hiss_aaa/bean/hiss_card_bean.dart';

class GameStateSnapshotBean {
  final List<List<HissCardBean>> cardList;
  final List<List<HissCardBean>> foundations;
  final List<HissCardBean> stockPile;
  final List<HissCardBean> wastePile;

  GameStateSnapshotBean({
    required this.cardList,
    required this.foundations,
    required this.stockPile,
    required this.wastePile,
  });

  static List<List<HissCardBean>> cloneColumns(List<List<HissCardBean>> src) {
    return src
        .map(
          (col) => col
          .map((c) => HissCardBean(value: c.value, cardType: c.cardType, front: c.front,isDefaultA: c.showCard,showCard: c.showCard,globalKey: c.globalKey))
          .toList(),
    )
        .toList();
  }

  static List<HissCardBean> cloneList(List<HissCardBean> src) {
    return src
        .map((c) => HissCardBean(value: c.value, cardType: c.cardType, front: c.front,isDefaultA: c.showCard,showCard: c.showCard,globalKey: c.globalKey))
        .toList();
  }

  factory GameStateSnapshotBean.from(
      List<List<HissCardBean>> cardList,
      List<List<HissCardBean>> foundations,
      List<HissCardBean> stockPile,
      List<HissCardBean> wastePile,
      ) {
    return GameStateSnapshotBean(
      cardList: cloneColumns(cardList),
      foundations: cloneColumns(foundations),
      stockPile: cloneList(stockPile),
      wastePile: cloneList(wastePile),
    );
  }
}