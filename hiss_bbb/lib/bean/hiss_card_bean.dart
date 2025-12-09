import 'package:flutter/material.dart';
import 'package:hiss_bbb/utils/hiss_enum/hiss_card_type.dart';

class HissCardBean{
  int value;
  HissCardType cardType;
  bool front;
  bool isDefaultA;
  GlobalKey? globalKey;
  bool showCard;
  bool? isCoins;
  HissCardBean({
    required this.value,
    required this.cardType,
    required this.front,
    this.isDefaultA=false,
    this.showCard=false,
    this.globalKey,
    this.isCoins,
});

  @override
  String toString() {
    return 'HissCardBean{value: $value, cardType: $cardType, front: $front, showCard: $showCard}';
  }
}