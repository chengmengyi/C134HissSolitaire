import 'dart:math';

class HissValueUtils {
  static final HissValueUtils _hissValueUtils=HissValueUtils();
  static HissValueUtils get instance=>_hissValueUtils;

  int propAddNum()=>1;

  int propCostMoney()=>100;

  int addDiamondNum()=>100;

  int addMoneyNum()=>100;

  int lookAdAddMoneyNum()=>100;

  //- a包每局给[3,5]个
  int randomCoinsCardNum()=>Random().nextInt(3)+3;

  bool showDiamondIcon()=>Random().nextBool();
}