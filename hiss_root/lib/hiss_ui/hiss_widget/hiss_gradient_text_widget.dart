import 'package:flutter/material.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_text_widget.dart';

class HissGradientTextWidget extends StatelessWidget{
  String textContent;
  Gradient gradient;
  double textSize;
  FontWeight? fontWeight;
  Color? outlineColor;
  TextOverflow? overflow;
  TextAlign? textAlign;
  HissGradientTextWidget({
    required this.textContent,
    required this.textSize,
    required this.gradient,
    this.fontWeight,
    this.outlineColor,
    this.overflow,
    this.textAlign,
});

  @override
  Widget build(BuildContext context) => ShaderMask(
    shaderCallback: (bounds) {
      return gradient.createShader(Offset.zero & bounds.size);
    },
    child: HissTextWidget(
      textContent: textContent,
      textSize: textSize,
      textColor: Colors.white,
      fontWeight: fontWeight,
      outlineColor: outlineColor,
      overflow: overflow,
      textAlign: textAlign,
    ),
  );
}