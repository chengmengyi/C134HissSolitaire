import 'package:hiss_bbb/bean/hiss_card_bean.dart';
import 'package:hiss_bbb/utils/hiss_enum/hiss_card_type.dart';
import 'package:hiss_bbb/utils/hiss_enum/hiss_home_gift_type.dart';
import 'package:hiss_bbb/utils/hiss_storage.dart';

String getCardImages(HissCardBean? bean){
  if(bean?.isCoins==true){
    return "icon_card_coins";
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