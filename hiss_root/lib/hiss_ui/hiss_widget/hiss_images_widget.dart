import 'package:flutter/material.dart';

class HissImagesWidget extends StatelessWidget{
  String name;
  double width;
  double height;
  BoxFit? boxFit;
  HissImagesWidget({
    required this.name,
    required this.width,
    required this.height,
    this.boxFit,
});
  @override
  Widget build(BuildContext context) => Image.asset("hiss_images/$name.webp",width: width,height: height,fit: boxFit??BoxFit.fill,);
}