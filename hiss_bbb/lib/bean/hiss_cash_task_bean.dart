class HissCashTaskBean {
  HissCashTaskBean({
      this.cashType, 
      this.cashMoney, 
      this.taskIndex, 
      this.currentPro, 
      this.totalPro,});

  HissCashTaskBean.fromJson(dynamic json) {
    cashType = json['cashType'];
    cashMoney = json['cashMoney'];
    taskIndex = json['taskIndex'];
    currentPro = json['currentPro'];
    totalPro = json['totalPro'];
  }
  String? cashType;
  int? cashMoney;
  int? taskIndex;
  int? currentPro;
  int? totalPro;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cashType'] = cashType;
    map['cashMoney'] = cashMoney;
    map['taskIndex'] = taskIndex;
    map['currentPro'] = currentPro;
    map['totalPro'] = totalPro;
    return map;
  }

}