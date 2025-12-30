class HuDongUrlBean {
  HuDongUrlBean({
      this.junior, 
      this.agent, 
      this.point,});

  HuDongUrlBean.fromJson(dynamic json) {
    junior = json['junior'];
    agent = json['agent'] != null ? Agent.fromJson(json['agent']) : null;
    point = json['point'] != null ? Point.fromJson(json['point']) : null;
  }
  String? junior;
  Agent? agent;
  Point? point;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['junior'] = junior;
    if (agent != null) {
      map['agent'] = agent?.toJson();
    }
    if (point != null) {
      map['point'] = point?.toJson();
    }
    return map;
  }

}

class Point {
  Point({
      this.junior, 
      this.ideal,});

  Point.fromJson(dynamic json) {
    junior = json['junior'];
    ideal = json['ideal'];
  }
  String? junior;
  String? ideal;
Point copyWith({  String? junior,
  String? ideal,
}) => Point(  junior: junior ?? this.junior,
  ideal: ideal ?? this.ideal,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['junior'] = junior;
    map['ideal'] = ideal;
    return map;
  }

}

class Agent {
  Agent({
      this.land,});

  Agent.fromJson(dynamic json) {
    land = json['land'];
  }
  String? land;
Agent copyWith({  String? land,
}) => Agent(  land: land ?? this.land,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['land'] = land;
    return map;
  }

}