import 'package:flutter/material.dart';
import 'package:hiss_bbb/ui/page/home/cash_child/bbb_cash_child_controller.dart';
import 'package:hiss_bbb/ui/widget/hiss_cash_widget/hiss_cash_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_root_child.dart';

class BBBCashChild extends HissRootChild<BBBCashChildController>{
  @override
  BBBCashChildController initGetController() => BBBCashChildController();

  @override
  Widget initContent() => HissCashWidget(tag: "home_cash");

}