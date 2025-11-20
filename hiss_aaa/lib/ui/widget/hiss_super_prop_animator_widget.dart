import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hiss_root/hiss_ui/hiss_root_stateful.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_click_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_images_widget.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_code.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_data.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';

class HissSuperPropAnimatorWidget extends HissRootStateful{
  @override
  State<StatefulWidget> createState() => _HissSuperPropAnimatorWidgetState();
}

class _HissSuperPropAnimatorWidgetState extends HissRootStatefulState<HissSuperPropAnimatorWidget> with TickerProviderStateMixin{
  AnimationController? _controller;
  Animation<Offset>? _animation;
  bool _isVisible = false,_appIsBack=false;
  final Random _random = Random();

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer=Timer.periodic(Duration(seconds: kDebugMode?10:60), (t){
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
        child: HissImagesWidget(name: "play2", width: 100.w, height: 80.w),
      );
    }
    return Container();
  }

  _startAnimation() {
    final size = MediaQuery.of(context).size;

    double startX = _random.nextBool() ? -100 : size.width + 100;
    double startY = _random.nextDouble() * (size.height - 100);

    double centerX = (size.width - 100) / 2;
    double centerY = (size.height - 100) / 2;

    double endX = _random.nextBool() ? -100 : size.width + 100;
    double endY = _random.nextDouble() * (size.height - 100);

    _controller?.dispose();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _animation = TweenSequence<Offset>([
      TweenSequenceItem(
        tween: Tween<Offset>(
          begin: Offset(startX, startY),
          end: Offset(centerX, centerY),
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 2,
      ),
      TweenSequenceItem(
        tween: ConstantTween<Offset>(Offset(centerX, centerY)),
        weight: 2,
      ),
      TweenSequenceItem(
        tween: Tween<Offset>(
          begin: Offset(centerX, centerY),
          end: Offset(endX, endY),
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 2,
      ),
    ]).animate(_controller!);

    setState(() {
      _isVisible = true;
    });

    _controller!.forward().whenComplete(() {
      setState(() {
        _isVisible = false;
      });
    });
  }

  _stopAnimation() {
    _controller?.stop();
    setState(() {
      _isVisible = false;
    });
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