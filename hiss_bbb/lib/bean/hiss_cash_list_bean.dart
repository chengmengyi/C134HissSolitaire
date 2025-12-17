import 'package:hiss_bbb/bean/hiss_cash_rank_bean.dart';
import 'package:hiss_bbb/bean/hiss_cash_task_bean.dart';

class HissCashListBean{
  int totalMoney;
  HissCashTaskBean? cashTaskBean;
  HissCashRankBean? cashRankBean;
  HissCashListBean({
    required this.totalMoney,
    this.cashTaskBean,
    this.cashRankBean,
});
}