import 'package:flutter/material.dart';
import 'package:hiss_bbb/bean/hiss_card_bean.dart';

class HissEmptyPlaceBean{
  bool lock;
  HissCardBean? hissCardBean;
  GlobalKey globalKey;
  HissEmptyPlaceBean({
    required this.lock,
    required this.globalKey,
    this.hissCardBean,
});
}