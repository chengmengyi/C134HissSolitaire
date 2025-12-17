import 'package:hiss_bbb/bean/hiss_rank_user_info_bean.dart';

class HissCashRankBean {
  HissCashRankBean({
      this.cashType, 
      this.cashMoney, 
      this.currentPro,
      this.totalPro,
  });

  HissCashRankBean.fromJson(dynamic json) {
    cashType = json['cashType'];
    cashMoney = json['cashMoney'];
    currentPro = json['currentPro'];
    totalPro = json['totalPro'];
  }
  String? cashType;
  int? cashMoney;
  int? currentPro;
  int? totalPro;
  List<HissRankUserInfoBean>? userList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cashType'] = cashType;
    map['cashMoney'] = cashMoney;
    map['currentPro'] = currentPro;
    map['totalPro'] = totalPro;
    return map;
  }

}