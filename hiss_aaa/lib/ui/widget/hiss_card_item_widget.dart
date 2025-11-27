import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hiss_aaa/bean/hiss_card_bean.dart';
import 'package:hiss_aaa/utils/utils.dart';
import 'package:hiss_root/hiss_ui/hiss_root_stateful.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_images_widget.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_code.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_data.dart';

class HissCardItemWidget extends HissRootStateful{
  HissCardBean cardBean;
  double cardWidth;
  double cardHeight;
  HissCardItemWidget({
    required this.cardBean,
    required this.cardWidth,
    required this.cardHeight,
});
  @override
  State<StatefulWidget> createState() => _HissCardItemWidgetState();
}

class _HissCardItemWidgetState extends HissRootStatefulState<HissCardItemWidget> with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _animation = Tween<double>(begin: pi, end: 0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  initContent() {
    if(widget.cardBean.front){
      return _frontWidget();
    }
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, child) {
        bool showFront = _animation.value < pi / 2;
        return Transform(
          transform: Matrix4.rotationY(_animation.value),
          alignment: Alignment.center,
          child: showFront ?
          _frontWidget():
          Transform(
            transform: Matrix4.rotationY(pi),
            alignment: Alignment.center,
            child: HissImagesWidget(
              name: "card_bg",
              width: widget.cardWidth,
              height: widget.cardHeight,
            ),
          ),
        );
      },
    );
  }

  _frontWidget()=>HissImagesWidget(
    name: getCardImages(widget.cardBean),
    width: widget.cardWidth,
    height: widget.cardHeight,
  );

  @override
  bool canReceivedEventData() => true;

  @override
  handleEventBusData(HissEventData data) {
    switch(data.eventCode){
      case HissEventCode.aFlipCard:
        _flipCard(data.anyEventValue);
        break;
    }
  }

  _flipCard(anyEventValue)async{
    HissCardBean value = anyEventValue;
    if(!value.front&&value.value==widget.cardBean.value&&value.cardType==widget.cardBean.cardType){
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}