import 'package:flutter/material.dart';

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
        onTap?.call();
      },
      child: child,
    );
  }
}