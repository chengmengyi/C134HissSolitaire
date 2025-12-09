import 'package:hiss_bbb/bean/hiss_card_bean.dart';

class HissHintBean {
  int fromCol;         // 来源列
  int? startIndex;     // 移动起点 rowIndex（列 → 列 时用）
  int? toCol;          // 目标列
  int? toFoundation;   // 目标 foundation index
  List<HissCardBean> cards;

  HissHintBean({
    required this.fromCol,
    this.startIndex,
    this.toCol,
    this.toFoundation,
    required this.cards,
  });
}