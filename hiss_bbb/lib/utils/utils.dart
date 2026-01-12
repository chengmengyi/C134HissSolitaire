import 'dart:math';

import 'package:hiss_bbb/bean/hiss_card_bean.dart';
import 'package:hiss_bbb/utils/hiss_enum/hiss_home_gift_type.dart';
import 'package:hiss_bbb/utils/hiss_enum/hiss_task_type.dart';
import 'package:hiss_bbb/utils/hiss_storage.dart';

bool playGamePageOpen=false;

String getCardImages(HissCardBean? bean){
  if(bean?.isCoins==true){
    return "icon_card_money";
  }
  if(bean?.isWheel==true){
    return "icon_card_wheel";
  }
  return "${bean?.cardType.name}${bean?.value}";
}

int countCurrentDiamond() {
  var n=bDiamondNum.getData();
  if (n <= 100) return n;
  int v = n % 100;
  return v == 0 ? 100 : v;
}

double getProgress(int current,int total){
  try{
    if(total<=0){
      return 0.0;
    }
    var d = current/total;
    if(d<=0){
      return 0.0;
    }else if(d>=1.0){
      return 1.0;
    }else{
      return d;
    }
  }catch(e){
    return 0.0;
  }
}

String getGiftIcon(String? type){
  switch(type){
    case HissHomeGiftType.pay: return "home_gift_pay";
    case HissHomeGiftType.phone: return "home_gift_phone";
    case HissHomeGiftType.game: return "home_gift_s";
    case HissHomeGiftType.package23: return "home_gift_p2";
    case HissHomeGiftType.card: return "home_gift_card";
    case HissHomeGiftType.chuifengji: return "home_gift_m";
    case HissHomeGiftType.package2025: return "home_gift_p";
    default: return "home_gift_p";
  }
}

String getGiftName(String? type){
  switch(type){
    case HissHomeGiftType.pay: return "PayPal \$200";
    case HissHomeGiftType.phone: return "iPhone 17 Pro Max";
    case HissHomeGiftType.game: return "Switch 2";
    case HissHomeGiftType.package23: return "IDOL No. 23 Handbag";
    case HissHomeGiftType.card: return "\$500 Amazon";
    case HissHomeGiftType.chuifengji: return "Dyson Hair Dryer";
    case HissHomeGiftType.package2025: return " CHANEL 2026 Handbag";
    default: return "";
  }
}

String getGiftShortName(String? type){
  switch(type){
    case HissHomeGiftType.pay: return "\$200";
    case HissHomeGiftType.phone: return "iPhone 17";
    case HissHomeGiftType.game: return "Switch2";
    case HissHomeGiftType.package23: return "IDOL bag";
    case HissHomeGiftType.card: return "\$500";
    case HissHomeGiftType.chuifengji: return "Dyson";
    case HissHomeGiftType.package2025: return " CHANEL bag";
    default: return "";
  }
}

String getTaskTitle(String? taskName,int? totalPro){
  switch(taskName){
    case HissTaskType.game: return "Complete $totalPro games";
    case HissTaskType.card: return "$totalPro cash cards";
    case HissTaskType.tool: return "Use $totalPro tools";
    case HissTaskType.bubbles: return "$totalPro ad bubble rewards";
    case HissTaskType.rank: return "Rank top $totalPro today";
    case HissTaskType.puzzle: return "$totalPro puzzle pieces";
    default: return "";
  }
}

String randomString(int length) {
  const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  final random = Random.secure();
  return List.generate(length, (index) => chars[random.nextInt(chars.length)]).join();
}

String strSetStr(String id){
  if(id.length!=9){
    return id;
  }
  var start = id.substring(0,1);
  var end = id.substring(6,9);
  return "$start*****$end";
}

bool isTenDigitNumber(String input) {
  return RegExp(r'^\d{10}$').hasMatch(input);
}

bool isEmail(String input) {
  final emailRegex = RegExp(
    r'^[\w\.-]+@[\w\.-]+\.\w+$',
  );
  return emailRegex.hasMatch(input);
}


