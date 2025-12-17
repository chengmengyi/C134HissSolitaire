class HissAccountBean {
  HissAccountBean({
      this.cashType, 
      this.account,});

  HissAccountBean.fromJson(dynamic json) {
    cashType = json['cashType'];
    account = json['account'];
  }
  String? cashType;
  String? account;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cashType'] = cashType;
    map['account'] = account;
    return map;
  }

}