class HissTaskQueueConfigBean {
  HissTaskQueueConfigBean({
      this.dailyTask, 
      this.withdrawalTask, 
      this.giftTaskPuzzleNum, 
      this.queue,});

  HissTaskQueueConfigBean.fromJson(dynamic json) {
    if (json['daily_task'] != null) {
      dailyTask = [];
      json['daily_task'].forEach((v) {
        dailyTask?.add(DailyTask.fromJson(v));
      });
    }
    if (json['withdrawal_task'] != null) {
      withdrawalTask = [];
      json['withdrawal_task'].forEach((v) {
        withdrawalTask?.add(WithdrawalTask.fromJson(v));
      });
    }
    giftTaskPuzzleNum = json['gift_task_puzzle_num'];
    queue = json['queue'] != null ? Queue.fromJson(json['queue']) : null;
  }
  List<DailyTask>? dailyTask;
  List<WithdrawalTask>? withdrawalTask;
  int? giftTaskPuzzleNum;
  Queue? queue;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (dailyTask != null) {
      map['daily_task'] = dailyTask?.map((v) => v.toJson()).toList();
    }
    if (withdrawalTask != null) {
      map['withdrawal_task'] = withdrawalTask?.map((v) => v.toJson()).toList();
    }
    map['gift_task_puzzle_num'] = giftTaskPuzzleNum;
    if (queue != null) {
      map['queue'] = queue?.toJson();
    }
    return map;
  }

}

class Queue {
  Queue({
      this.mM, 
      this.sS,});

  Queue.fromJson(dynamic json) {
    mM = json['m_m'] != null ? json['m_m'].cast<int>() : [];
    sS = json['s_s'] != null ? json['s_s'].cast<int>() : [];
  }
  List<int>? mM;
  List<int>? sS;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['m_m'] = mM;
    map['s_s'] = sS;
    return map;
  }

}

class WithdrawalTask {
  WithdrawalTask({
      this.name, 
      this.num,});

  WithdrawalTask.fromJson(dynamic json) {
    name = json['name'];
    num = json['num'];
  }
  String? name;
  int? num;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['num'] = num;
    return map;
  }

}

class DailyTask {
  DailyTask({
      this.name, 
      this.num, 
      this.award,});

  DailyTask.fromJson(dynamic json) {
    name = json['name'];
    num = json['num'];
    award = json['award'];
  }
  String? name;
  int? num;
  int? award;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['num'] = num;
    map['award'] = award;
    return map;
  }

}