import 'package:flutter/material.dart';
import 'package:hiss_aaa/test.dart';
import 'package:hiss_root/hiss_ui/hiss_root_controller.dart';

class HissHomeController extends HissRootController{

  clickPlay(){
    Navigator.push(buildContext, MaterialPageRoute(builder: (_)=>SolitairePage()));
  }
}