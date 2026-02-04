import 'package:flutter/material.dart';
import 'package:hiss_bbb/ui/page/home/gift_child/bbb_gift_child_controller.dart';
import 'package:hiss_bbb/ui/widget/hiss_gift_widget/hiss_gift_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_root_child.dart';

class BBBGiftChild extends HissRootChild<BBBGiftChildController>{
  @override
  BBBGiftChildController initGetController() => BBBGiftChildController();

  @override
  Widget initContent() => HissGiftWidget(tagStr: "gift_tab",fromHomeTab: true,);
}