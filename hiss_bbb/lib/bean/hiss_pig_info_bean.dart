class HissPigInfoBean {
  HissPigInfoBean({
      this.id,
      this.type,
      this.status,
      this.addNum,
  });

  HissPigInfoBean.fromJson(dynamic json) {
    type = json['type'];
    id = json['id'];
    status = json['status'];
    addNum = json['addNum'];
  }
  int? id;
  String? type;
  String? status;
  int? addNum;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['type'] = type;
    map['status'] = status;
    map['addNum'] = addNum;
    return map;
  }

  @override
  String toString() {
    return 'HissPigInfoBean{id: $id, type: $type, status: $status, addNum: $addNum}';
  }


}