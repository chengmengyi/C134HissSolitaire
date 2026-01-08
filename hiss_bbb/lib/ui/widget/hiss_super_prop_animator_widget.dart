import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hiss_bbb/ui/dialog/super_prop_dialog/super_prop_dialog.dart';
import 'package:hiss_bbb/utils/hiss_value_config_utils.dart';
import 'package:hiss_root/hiss_ui/hiss_root_stateful.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_breath_animator_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_click_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_images_widget.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_code.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_data.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';
import 'package:hiss_root/hiss_utils/hiss_mp3_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_routers_utils.dart';

class HissSuperPropAnimatorWidget extends HissRootStateful{
  @override
  State<StatefulWidget> createState() => _HissSuperPropAnimatorWidgetState();
}

class _HissSuperPropAnimatorWidgetState extends HissRootStatefulState<HissSuperPropAnimatorWidget> with TickerProviderStateMixin{
  AnimationController? _controller;
  Animation<Offset>? _animation;
  bool _isVisible = false,_appIsBack=false;

  Timer? _timer;

  AnimationController? _breathAnimationController;

  @override
  void initState() {
    super.initState();
    _timer=Timer.periodic(Duration(seconds: HissValueConfigUtils.instance.getSuperToolTime()), (t){
      if(_appIsBack){
        return;
      }
      _startAnimation();
    });
  }

  @override
  initContent() {
    if (_isVisible && _animation != null){
      return AnimatedBuilder(
        animation: _animation!,
        builder: (context, child) {
          return Positioned(
            left: _animation!.value.dx,
            top: _animation!.value.dy,
            child: HissClickWidget(
              onTap: _stopAnimation,
              child: child,
            ),
          );
        },
        child: HissBreathAnimatorWidget(
          start: false,
          controllerCallback: (c){
            _breathAnimationController=c;
          },
          child: HissImagesWidget(name: "play2", width: 100.w, height: 80.w),
        ),
      );
    }
    return Container();
  }

  _startAnimation() async{
    final size = MediaQuery.of(context).size;
    double startX = -100;
    double startY = (size.height - 100) / 2;

    double centerX = (size.width - 100) / 2;
    double centerY = startY;

    double endX = size.width + 100;
    double endY = startY;

    _controller?.dispose();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
    _animation = TweenSequence<Offset>([
      TweenSequenceItem(
        tween: Tween<Offset>(
          begin: Offset(startX, startY),
          end: Offset(centerX, centerY),
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 1.5, // 进入
      ),
      TweenSequenceItem(
        tween: ConstantTween<Offset>(Offset(centerX, centerY)),
        weight: 2, // 停留
      ),
      TweenSequenceItem(
        tween: Tween<Offset>(
          begin: Offset(centerX, centerY),
          end: Offset(endX, endY),
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 1.5, // 离开
      ),
    ]).animate(_controller!);

    setState(() {
      _isVisible = true;
    });

    HissMp3Utils.instance.playOtherMp3(HissMp3Type.super_prop);

    _controller!.forward().whenComplete(() {
      setState(() {
        _isVisible = false;
      });
    });
    await Future.delayed(Duration(seconds: 1));
    _breathAnimationController?.reset();
    _breathAnimationController?.repeat(reverse: true);
  }

  _stopAnimation() {
    _controller?.stop();
    HissRoutersUtils.instance.showDialog(
      child: SuperPropDialog(
        cancelCallback: (){
          _controller?.forward();
        },
        claimCallback: (){
          setState(() {
            _isVisible = false;
          });
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  bool canReceivedEventData() => true;

  @override
  handleEventBusData(HissEventData data) {
    switch(data.eventCode){
      case HissEventCode.onChangedAppLife:
        _appIsBack=data.boolEventValue??false;
        break;
    }
  }
}