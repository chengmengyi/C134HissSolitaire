class HissFkConfigBean {
  HissFkConfigBean({
    this.ui,
    this.behavior,
    this.device,});

  HissFkConfigBean.fromJson(dynamic json) {
    ui = json['ui'] != null ? Ui.fromJson(json['ui']) : null;
    behavior = json['behavior'] != null ? Behavior.fromJson(json['behavior']) : null;
    device = json['device'] != null ? json['device'].cast<String>() : [];
  }
  Ui? ui;
  Behavior? behavior;
  List<String>? device;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (ui != null) {
      map['ui'] = ui?.toJson();
    }
    if (behavior != null) {
      map['behavior'] = behavior?.toJson();
    }
    map['device'] = device;
    return map;
  }

}

class Behavior {
  Behavior({
    this.adShortShow,
    this.adShortClose,
    this.wrongDeemAdLess,
    this.wrongDeemAdMore,
    this.noInstall,
    this.adDailyShow,});

  Behavior.fromJson(dynamic json) {
    adShortShow = json['ad_short_show'] != null ? AdShortShow.fromJson(json['ad_short_show']) : null;
    adShortClose = json['ad_short_close'] != null ? AdShortClose.fromJson(json['ad_short_close']) : null;
    wrongDeemAdLess = json['wrong_deem_ad_less'];
    wrongDeemAdMore = json['wrong_deem_ad_more'];
    noInstall = json['no_install'];
    adDailyShow = json['ad_daily_show'];
  }
  AdShortShow? adShortShow;
  AdShortClose? adShortClose;
  int? wrongDeemAdLess;
  int? wrongDeemAdMore;
  int? noInstall;
  int? adDailyShow;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (adShortShow != null) {
      map['ad_short_show'] = adShortShow?.toJson();
    }
    if (adShortClose != null) {
      map['ad_short_close'] = adShortClose?.toJson();
    }
    map['wrong_deem_ad_less'] = wrongDeemAdLess;
    map['wrong_deem_ad_more'] = wrongDeemAdMore;
    map['no_install'] = noInstall;
    map['ad_daily_show'] = adDailyShow;
    return map;
  }

}

class AdShortClose {
  AdShortClose({
    this.duration,
    this.value,});

  AdShortClose.fromJson(dynamic json) {
    duration = json['duration'];
    value = json['value'];
  }
  int? duration;
  int? value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['duration'] = duration;
    map['value'] = value;
    return map;
  }

}

class AdShortShow {
  AdShortShow({
    this.duration,
    this.value,});

  AdShortShow.fromJson(dynamic json) {
    duration = json['duration'];
    value = json['value'];
  }
  int? duration;
  int? value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['duration'] = duration;
    map['value'] = value;
    return map;
  }

}

class Ui {
  Ui({
    this.number,
    this.behavior,
    this.device,});

  Ui.fromJson(dynamic json) {
    number = json['number'];
    behavior = json['behavior'];
    device = json['device'];
  }
  int? number;
  int? behavior;
  int? device;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['number'] = number;
    map['behavior'] = behavior;
    map['device'] = device;
    return map;
  }

}