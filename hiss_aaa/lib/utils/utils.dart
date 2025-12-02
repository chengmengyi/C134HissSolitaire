import 'package:hiss_aaa/bean/hiss_card_bean.dart';
import 'package:hiss_aaa/utils/hiss_enum/hiss_card_type.dart';
import 'package:hiss_aaa/utils/hiss_storage.dart';

String getCardImages(HissCardBean? bean){
  if(bean?.isCoins==true){
    return "icon_card_coins";
  }
  return "${bean?.cardType.name}${bean?.value}";
}

int countCurrentDiamond() {
  var n=aDiamondNum.getData();
  if (n <= 100) return n;
  int v = n % 100;
  return v == 0 ? 100 : v;
}