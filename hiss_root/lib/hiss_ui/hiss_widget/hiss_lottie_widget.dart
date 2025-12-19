import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HissLottieWidget extends StatelessWidget{
  String name;
  double? width;
  double? height;
  BoxFit? fit;
  String ext;
  AnimationController? animationController;
  HissLottieWidget({
    required this.name,
    this.width,
    this.height,
    this.fit,
    this.ext=".json",
    this.animationController,
});

  @override
  Widget build(BuildContext context) => Lottie.asset(
    "assets/lottie/$name$ext",
    width: width,
    height: height,
    fit: fit,
    controller: animationController,
  );
}