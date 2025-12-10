class HissHomeGiftProgressBean {
  HissHomeGiftProgressBean({
      this.currentPro, 
      this.totalPro, 
      this.type, 
      this.status,});

  HissHomeGiftProgressBean.fromJson(dynamic json) {
    currentPro = json['currentPro'];
    totalPro = json['totalPro'];
    type = json['type'];
    status = json['status'];
  }
  int? currentPro;
  int? totalPro;
  String? type;
  String? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['currentPro'] = currentPro;
    map['totalPro'] = totalPro;
    map['type'] = type;
    map['status'] = status;
    return map;
  }

}