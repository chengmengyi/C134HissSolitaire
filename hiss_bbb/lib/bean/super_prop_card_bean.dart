import 'package:hiss_bbb/bean/hiss_card_bean.dart';

class SuperPropCardBean{
  HissCardBean cardBean;
  int? foundationIndex;
  bool? fromCardList;
  bool? fromWaste;
  bool? fromStock;
  SuperPropCardBean({
    required this.cardBean,
    this.foundationIndex,
    this.fromCardList,
    this.fromWaste,
    this.fromStock,
});
}