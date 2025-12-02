import 'package:flutter/material.dart';
import 'package:hiss_root/hiss_utils/hiss_mp3_utils.dart';

class HissClickWidget extends StatelessWidget{
  Widget? child;
  Function()? onTap;
  HissClickWidget({
    this.child,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: (){
        HissMp3Utils.instance.playOtherMp3(HissMp3Type.click);
        onTap?.call();
      },
      child: child,
    );
  }
}