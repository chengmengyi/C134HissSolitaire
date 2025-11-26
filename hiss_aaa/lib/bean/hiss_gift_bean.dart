class HissGiftBean {
  String? giftType;
  int? addNum;
  int? showAd;
  String? giftStatus;

  HissGiftBean({
    this.giftType,
    this.addNum,
    this.showAd,
    this.giftStatus,
  });

  HissGiftBean.fromJson(dynamic json) {
    giftType = json['giftType'];
    addNum = json['addNum'];
    showAd = json['showAd'];
    giftStatus = json['giftStatus'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['giftType'] = giftType;
    map['addNum'] = addNum;
    map['showAd'] = showAd;
    map['giftStatus'] = giftStatus;
    return map;
  }

}