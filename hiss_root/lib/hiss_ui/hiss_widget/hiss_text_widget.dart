import 'package:flutter/material.dart';

class HissTextWidget extends StatelessWidget{
  String textContent;
  Color textColor;
  double textSize;
  FontWeight? fontWeight;
  HissTextWidget({
    required this.textContent,
    required this.textSize,
    required this.textColor,
    this.fontWeight,
});

  @override
  Widget build(BuildContext context) => Text(
    textContent,
    style: TextStyle(
      fontSize: textSize,
      color: textColor,
      fontWeight: fontWeight,
    ),
  );
}