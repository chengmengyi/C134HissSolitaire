class HissRankBean {
  HissRankBean({
      this.name, 
      this.head, 
      this.level, 
      this.diamond, 
      this.coins,
      this.isMe,
  });

  HissRankBean.fromJson(dynamic json) {
    name = json['name'];
    head = json['head'];
    level = json['level'];
    diamond = json['diamond'];
    coins = json['coins'];
  }
  String? name;
  String? head;
  int? level;
  int? diamond;
  int? coins;
  bool? isMe;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['head'] = head;
    map['level'] = level;
    map['diamond'] = diamond;
    map['coins'] = coins;
    return map;
  }

  @override
  String toString() {
    return 'HissRankBean{name: $name, head: $head, level: $level}';
  }


}