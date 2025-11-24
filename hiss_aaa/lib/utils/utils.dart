import 'package:hiss_aaa/bean/hiss_card_bean.dart';
import 'package:hiss_aaa/utils/hiss_enum/hiss_card_type.dart';

String getCardImages(HissCardBean? bean) => "${bean?.cardType.name}${bean?.value}";