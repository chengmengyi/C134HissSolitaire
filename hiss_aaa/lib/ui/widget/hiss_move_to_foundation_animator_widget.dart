import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hiss_aaa/bean/hiss_card_bean.dart';
import 'package:hiss_aaa/utils/utils.dart';
import 'package:hiss_root/hiss_ui/hiss_root_stateful.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_click_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_images_widget.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_code.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_data.dart';

class HissMoveToFoundationAnimatorWidget extends HissRootStateful{
  @override
  State<StatefulWidget> createState() => _HissMoveToFoundationAnimatorWidgetState();
}

class _HissMoveToFoundationAnimatorWidgetState extends HissRootStatefulState<HissMoveToFoundationAnimatorWidget> with TickerProviderStateMixin{
  var cardWidth=0.0,cardHeight=0.0;
  AnimationController? animationController;
  Animation<Offset>? animation;
  HissCardBean? cardBean;

  @override
  initContent() {
    if(null==animationController||null==animation){
      return Container();
    }
    return AnimatedBuilder(
      animation: animationController!,
      builder: (_, __) {
        return Positioned(
          left: animation!.value.dx,
          top: animation!.value.dy,
          child: HissImagesWidget(name: getCardImages(cardBean), width: cardWidth, height: cardHeight,),
        );
      },
    );
  }

  @override
  bool canReceivedEventData() => true;

  @override
  handleEventBusData(HissEventData data) {
    switch(data.eventCode){
      case HissEventCode.aMoveCardToFoundation:
        _moveCardToFoundation(data.anyEventValue);
        break;
    }
  }

  _moveCardToFoundation(anyEventValue)async{
    cardWidth = anyEventValue["cardWidth"];
    cardHeight = anyEventValue["cardHeight"];
    GlobalKey startGlobalKey=anyEventValue["startGlobalKey"];
    GlobalKey endGlobalKey=anyEventValue["endGlobalKey"];
    cardBean=anyEventValue["card"];
    var startRenderBox = startGlobalKey.currentContext?.findRenderObject() as RenderBox;
    var startOffset = startRenderBox.localToGlobal(Offset.zero);
    var endRenderBox = endGlobalKey.currentContext?.findRenderObject() as RenderBox;
    var endOffset = endRenderBox.localToGlobal(Offset.zero);
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    animation = Tween<Offset>(
      begin: startOffset,
      end: endOffset,
    ).animate(CurvedAnimation(
      parent: animationController!,
      curve: Curves.easeOut,
    ));
    setState(() {});
    await animationController?.forward();
    animationController=null;
    setState(() {});
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }
}