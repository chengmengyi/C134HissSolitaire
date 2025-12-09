import 'package:flutter/material.dart';
import 'package:hiss_root/hiss_ui/hiss_root_controller.dart';
import '../hiss_utils/hiss_export.dart';

abstract class HissRootChild<T extends HissRootController> extends StatelessWidget{
  late T controller;
  bool _firstInitController=true;
  late BuildContext buildContext;

  @override
  Widget build(BuildContext context) {
    _initGetController(context);
    return initContent();
  }

  T initGetController();

  Widget initContent();

  _initGetController(BuildContext context){
    if(_firstInitController){
      controller=Get.put(initGetController());
    }
    _firstInitController=false;
    buildContext=context;
    controller.buildContext=context;
  }
}