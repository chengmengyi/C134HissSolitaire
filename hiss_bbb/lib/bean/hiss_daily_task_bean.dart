class HissDailyTaskBean {
  HissDailyTaskBean({
      this.type, 
      this.totalPro, 
      this.currentPro, 
      this.reward, 
      this.timer,
      this.status,
  });

  HissDailyTaskBean.fromJson(dynamic json) {
    type = json['type'];
    totalPro = json['totalPro'];
    currentPro = json['currentPro'];
    reward = json['reward'];
    timer = json['timer'];
    status = json['status'];
  }
  String? type;
  int? totalPro;
  int? currentPro;
  int? reward;
  String? timer;
  String? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['totalPro'] = totalPro;
    map['currentPro'] = currentPro;
    map['reward'] = reward;
    map['timer'] = timer;
    map['status'] = status;
    return map;
  }

}