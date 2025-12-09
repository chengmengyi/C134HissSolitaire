import 'package:flutter/material.dart';
import 'package:hiss_bbb/ui/page/home/cash_child/cash_child_controller.dart';
import 'package:hiss_root/hiss_ui/hiss_root_child.dart';

class CashChild extends HissRootChild<CashChildController>{
  @override
  CashChildController initGetController() => CashChildController();

  @override
  Widget initContent() => Container();
}