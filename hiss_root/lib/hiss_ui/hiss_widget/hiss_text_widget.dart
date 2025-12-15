import 'package:flutter/material.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';
import 'package:outlined_text/outlined_text.dart';

class HissTextWidget extends StatelessWidget{
  String textContent;
  Color textColor;
  double textSize;
  Color? outlineColor;
  FontWeight? fontWeight;
  TextOverflow? overflow;
  TextDecoration? decoration;
  Color? decorationColor;
  TextAlign? textAlign;
  HissTextWidget({
    required this.textContent,
    required this.textSize,
    required this.textColor,
    this.fontWeight,
    this.outlineColor,
    this.overflow,
    this.decoration,
    this.decorationColor,
    this.textAlign,
});

  @override
  Widget build(BuildContext context) => OutlinedText(
    text: Text(
      textContent,
      style: TextStyle(
        fontSize: textSize,
        color: textColor,
        fontWeight: fontWeight,
        height: 1.0,
        overflow: overflow,
        decoration: decoration,
        decorationColor: decorationColor,
      ),
      textAlign: textAlign,
    ),
    strokes: outlineColor==null?
    []:
    [
      OutlinedTextStroke(
        color: outlineColor??Colors.white,
        width: 2.w,
      ),
    ],
  );
}