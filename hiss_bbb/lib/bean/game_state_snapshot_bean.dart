import 'package:hiss_bbb/bean/hiss_card_bean.dart';
import 'package:hiss_bbb/bean/hiss_empty_place_bean.dart';

class GameStateSnapshotBean {
  final List<List<HissCardBean>> cardList;
  final List<List<HissCardBean>> foundations;
  final List<HissCardBean> stockPile;
  final List<HissCardBean> wastePile;
  final List<HissEmptyPlaceBean> emptyPlace;

  GameStateSnapshotBean({
    required this.cardList,
    required this.foundations,
    required this.stockPile,
    required this.wastePile,
    required this.emptyPlace,
  });

  static List<List<HissCardBean>> cloneColumns(List<List<HissCardBean>> src) {
    return src.map((col) => col.map((c) =>
        HissCardBean(
          value: c.value,
          cardType: c.cardType,
          front: c.front,
          isDefaultA: c.showCard,
          showCard: c.showCard,
          globalKey: c.globalKey,
          isCoins: c.isCoins,
        ),
    )
        .toList(),
    ).toList();
  }

  static List<HissCardBean> cloneList(List<HissCardBean> src) {
    return src.map((c) => HissCardBean(
        value: c.value,
        cardType: c.cardType,
        front: c.front,
        isDefaultA: c.showCard,
        showCard: c.showCard,
        globalKey: c.globalKey,
        isCoins: c.isCoins,
      ),
    )
        .toList();
  }

  static List<HissEmptyPlaceBean> cloneEmptyPlaceList(List<HissEmptyPlaceBean> src) {
    return src.map((c) => HissEmptyPlaceBean(
      lock: c.lock,
      hissCardBean: c.hissCardBean,
      globalKey: c.globalKey
    ),
    )
        .toList();
  }

  factory GameStateSnapshotBean.from(
      List<List<HissCardBean>> cardList,
      List<List<HissCardBean>> foundations,
      List<HissCardBean> stockPile,
      List<HissCardBean> wastePile,
      List<HissEmptyPlaceBean> emptyPlace,
      ) {
    return GameStateSnapshotBean(
      cardList: cloneColumns(cardList),
      foundations: cloneColumns(foundations),
      stockPile: cloneList(stockPile),
      wastePile: cloneList(wastePile),
      emptyPlace: cloneEmptyPlaceList(emptyPlace),
    );
  }
}