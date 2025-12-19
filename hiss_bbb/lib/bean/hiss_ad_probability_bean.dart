class HissAdProbabilityBean {
  HissAdProbabilityBean({
      this.intAd,});

  HissAdProbabilityBean.fromJson(dynamic json) {
    if (json['int_ad'] != null) {
      intAd = [];
      json['int_ad'].forEach((v) {
        intAd?.add(IntAd.fromJson(v));
      });
    }
  }
  List<IntAd>? intAd;
  
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (intAd != null) {
      map['int_ad'] = intAd?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class IntAd {
  IntAd({
      this.firstNumber, 
      this.point, 
      this.endNumber,});

  IntAd.fromJson(dynamic json) {
    firstNumber = json['first_number'];
    point = json['point'];
    endNumber = json['end_number'];
  }
  int? firstNumber;
  int? point;
  int? endNumber;
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['first_number'] = firstNumber;
    map['point'] = point;
    map['end_number'] = endNumber;
    return map;
  }

}