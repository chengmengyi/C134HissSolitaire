class HissGiftRewardTaskBean {
  HissGiftRewardTaskBean({
      this.currentPro, 
      this.totalPro, 
      this.type,
      this.taskType,});

  HissGiftRewardTaskBean.fromJson(dynamic json) {
    currentPro = json['currentPro'];
    totalPro = json['totalPro'];
    type = json['type'];
    taskType = json['taskType'];
  }
  int? currentPro;
  int? totalPro;
  String? type;
  String? taskType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['currentPro'] = currentPro;
    map['totalPro'] = totalPro;
    map['type'] = type;
    map['taskType'] = taskType;
    return map;
  }

}