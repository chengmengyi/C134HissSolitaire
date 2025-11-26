class HissPlayRecordBean {
  HissPlayRecordBean({
      this.score, 
      this.time, 
      this.step,});

  HissPlayRecordBean.fromJson(dynamic json) {
    score = json['score'];
    time = json['time'];
    step = json['step'];
  }
  int? score;
  int? time;
  int? step;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['score'] = score;
    map['time'] = time;
    map['step'] = step;
    return map;
  }

  @override
  String toString() {
    return 'HissPlayRecordBean{score: $score, time: $time, step: $step}';
  }

}