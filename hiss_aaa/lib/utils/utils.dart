import 'package:hiss_aaa/bean/hiss_card_bean.dart';
import 'package:hiss_aaa/utils/hiss_enum/hiss_card_type.dart';

String getCardImages(HissCardBean? bean){
  if(bean?.isCoins==true){
    return "icon_card_coins";
  }
  return "${bean?.cardType.name}${bean?.value}";
}