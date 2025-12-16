import 'package:hiss_root/hiss_utils/hiss_utils.dart';

class HissValueConfigBean {
  HissValueConfigBean({
      this.giftPuzzle, 
      this.cashCard, 
      this.diamondNum, 
      this.openCollectCard, 
      this.settlementReward, 
      this.rankReward, 
      this.cyclicReward, 
      this.diamondPig,
  });

  HissValueConfigBean.fromJson(dynamic json) {
    giftPuzzle = json['gift_puzzle'] != null ? json['gift_puzzle'].cast<int>() : [];
    cashCard = json['cash_card'] != null ? CashCard.fromJson(json['cash_card']) : null;
    diamondNum = json['diamond_num'];
    if (json['open_collect_card'] != null) {
      openCollectCard = [];
      json['open_collect_card'].forEach((v) {
        openCollectCard?.add(OpenCollectCard.fromJson(v));
      });
    }
    if (json['settlement_reward'] != null) {
      settlementReward = [];
      json['settlement_reward'].forEach((v) {
        settlementReward?.add(SettlementReward.fromJson(v));
      });
    }
    if (json['rank_reward'] != null) {
      rankReward = [];
      json['rank_reward'].forEach((v) {
        rankReward?.add(RankReward.fromJson(v));
      });
    }
    if (json['cyclic_reward'] != null) {
      cyclicReward = [];
      json['cyclic_reward'].forEach((v) {
        cyclicReward?.add(CyclicReward.fromJson(v));
      });
    }
    diamondPig = json['diamond_pig'] != null ? json['diamond_pig'].cast<int>() : [];
  }
  List<int>? giftPuzzle;
  CashCard? cashCard;
  int? diamondNum;
  List<OpenCollectCard>? openCollectCard;
  List<SettlementReward>? settlementReward;
  List<RankReward>? rankReward;
  List<CyclicReward>? cyclicReward;
  List<int>? diamondPig;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['gift_puzzle'] = giftPuzzle;
    if (cashCard != null) {
      map['cash_card'] = cashCard?.toJson();
    }
    map['diamond_num'] = diamondNum;
    if (openCollectCard != null) {
      map['open_collect_card'] = openCollectCard?.map((v) => v.toJson()).toList();
    }
    if (settlementReward != null) {
      map['settlement_reward'] = settlementReward?.map((v) => v.toJson()).toList();
    }
    if (rankReward != null) {
      map['rank_reward'] = rankReward?.map((v) => v.toJson()).toList();
    }
    if (cyclicReward != null) {
      map['cyclic_reward'] = cyclicReward?.map((v) => v.toJson()).toList();
    }
    map['diamond_pig'] = diamondPig;
    return map;
  }

}

class CyclicReward {
  CyclicReward({
      this.min, 
      this.max, 
      this.reward,});

  CyclicReward.fromJson(dynamic json) {
    min = json['min'];
    max = json['max'];
    reward = json['reward'] != null ? json['reward'].cast<int>() : [];
  }
  int? min;
  int? max;
  List<int>? reward;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['min'] = min;
    map['max'] = max;
    map['reward'] = reward;
    return map;
  }

}

class RankReward {
  RankReward({
      this.name, 
      this.num,});

  RankReward.fromJson(dynamic json) {
    name = json['name'];
    num = json['num'];
  }
  String? name;
  int? num;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['num'] = num;
    return map;
  }

}

class SettlementReward {
  SettlementReward({
      this.min, 
      this.max, 
      this.reward,});

  SettlementReward.fromJson(dynamic json) {
    min = json['min'];
    max = json['max'];
    reward = json['reward'] != null ? json['reward'].cast<int>() : [];
  }
  int? min;
  int? max;
  List<int>? reward;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['min'] = min;
    map['max'] = max;
    map['reward'] = reward;
    return map;
  }

}

class OpenCollectCard {
  OpenCollectCard({
      this.min, 
      this.max, 
      this.reward,});

  OpenCollectCard.fromJson(dynamic json) {
    min = json['min'];
    max = json['max'];
    reward = json['reward'].toString().toDouble();
  }
  int? min;
  int? max;
  double? reward;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['min'] = min;
    map['max'] = max;
    map['reward'] = reward;
    return map;
  }

}

class CashCard {
  CashCard({
      this.num, 
      this.reward,});

  CashCard.fromJson(dynamic json) {
    num = json['num'] != null ? json['num'].cast<int>() : [];
    reward = json['reward'] != null ? json['reward'].cast<int>() : [];
  }
  List<int>? num;
  List<int>? reward;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['num'] = num;
    map['reward'] = reward;
    return map;
  }

}