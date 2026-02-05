import 'package:flutter/material.dart';
import 'package:hiss_bbb/bean/hiss_card_bean.dart';
import 'package:hiss_root/hiss_ui/hiss_root_stateful.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_images_widget.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_code.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_data.dart';


class HissWheelCardAnimatorWidget extends HissRootStateful{

  @override
  State<StatefulWidget> createState() => _HissWheelCardAnimatorWidgetState();
}

class _HissWheelCardAnimatorWidgetState extends HissRootStatefulState<HissWheelCardAnimatorWidget> with TickerProviderStateMixin{
  var cardWidth=0.0,cardHeight=0.0;
  AnimationController? animationController;
  late Animation<Offset>? positionAnim;
  late Animation<double>? scaleAnim;


  @override
  initContent() {
    if(null==animationController||null==positionAnim){
      return Container();
    }
    return AnimatedBuilder(
      animation: animationController!,
      builder: (_, child) {
        return Positioned(
          left: positionAnim!.value.dx,
          top: positionAnim!.value.dy,
          child: Transform.scale(
            scale: scaleAnim!.value,
            child: child,
          ),
        );
      },
      child: HissImagesWidget(name: "icon_card_wheel", width: cardWidth, height: cardHeight),
    );
  }

  @override
  bool canReceivedEventData() => true;

  @override
  handleEventBusData(HissEventData data) {
    switch(data.eventCode){
      case HissEventCode.showWheelAnimator:
        _showWheelAnimator(data.anyEventValue);
        break;
    }
  }

  _showWheelAnimator(anyEventValue)async{
    cardWidth = anyEventValue["cardWidth"];
    cardHeight = anyEventValue["cardHeight"];
    HissCardBean cardBean=anyEventValue["card"];
    var startRenderBox = cardBean.globalKey?.currentContext?.findRenderObject() as RenderBox;
    var offset = startRenderBox.localToGlobal(Offset.zero);
    var startOffset=Offset(offset.dx-cardWidth/2, offset.dy);
    final size = MediaQuery.of(context).size;
    final centerOffset = size.center(Offset.zero);
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    positionAnim = Tween<Offset>(
      begin: startOffset,
      end: centerOffset,
    ).animate(CurvedAnimation(
      parent: animationController!,
      curve: Curves.easeOut,
    ));

    scaleAnim = Tween<double>(
      begin: 1.0,
      end: 2.0,
    ).animate(CurvedAnimation(
      parent: animationController!,
      curve: Curves.easeOut,
    ));
    setState(() {});
    await animationController?.forward();
    await Future.delayed(Duration(milliseconds: 500));
    animationController=null;
    setState(() {});
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }
}