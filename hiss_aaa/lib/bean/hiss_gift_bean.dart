class HissGiftBean {
  int? customId;
  String? giftType;
  int? addNum;
  int? showAd;
  String? giftStatus;

  HissGiftBean({
    this.customId,
    this.giftType,
    this.addNum,
    this.showAd,
    this.giftStatus,
  });

  HissGiftBean.fromJson(dynamic json) {
    customId = json['id'];
    giftType = json['giftType'];
    addNum = json['addNum'];
    showAd = json['showAd'];
    giftStatus = json['giftStatus'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = customId;
    map['giftType'] = giftType;
    map['addNum'] = addNum;
    map['showAd'] = showAd;
    map['giftStatus'] = giftStatus;
    return map;
  }

}