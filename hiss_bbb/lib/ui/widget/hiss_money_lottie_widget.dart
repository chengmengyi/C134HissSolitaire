import 'package:flutter/material.dart';
import 'package:hiss_root/hiss_ui/hiss_root_stateful.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_lottie_widget.dart';

class HissMoneyLottieWidget extends HissRootStateful{
  Function() callback;
  HissMoneyLottieWidget({
    required this.callback,
});
  @override
  State<StatefulWidget> createState() => _HissMoneyLottieWidgetState();
}

class _HissMoneyLottieWidgetState extends HissRootStatefulState<HissMoneyLottieWidget> with TickerProviderStateMixin{
  late AnimationController moneyLottieController;

  @override
  void initState() {
    super.initState();
    moneyLottieController=AnimationController(vsync: this,duration: const Duration(milliseconds: 1000))..addStatusListener((status) {
      if(status==AnimationStatus.completed){
        widget.callback.call();
      }
    });
    moneyLottieController.forward();
  }

  @override
  initContent() => HissLottieWidget(
    name: "money",
    animationController: moneyLottieController,
  );
}