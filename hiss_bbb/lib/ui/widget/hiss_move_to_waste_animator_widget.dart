import 'package:flutter/material.dart';
import 'package:hiss_bbb/bean/hiss_card_bean.dart';
import 'package:hiss_bbb/utils/utils.dart';
import 'package:hiss_root/hiss_ui/hiss_root_stateful.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_images_widget.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_code.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_data.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';

class HissMoveToWasteAnimatorWidget extends HissRootStateful{
  @override
  State<StatefulWidget> createState() => _HissMoveToWasteAnimatorWidgetState();
}

class _HissMoveToWasteAnimatorWidgetState extends HissRootStatefulState<HissMoveToWasteAnimatorWidget> with TickerProviderStateMixin{
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
      case HissEventCode.aMoveCardToWaste:
        _aMoveCardToWaste(data.anyEventValue);
        break;
    }
  }

  _aMoveCardToWaste(anyEventValue)async{
    cardWidth = anyEventValue["cardWidth"];
    cardHeight = anyEventValue["cardHeight"];
    GlobalKey startGlobalKey=anyEventValue["startGlobalKey"];
    cardBean=anyEventValue["card"];
    var startRenderBox = startGlobalKey.currentContext?.findRenderObject() as RenderBox;
    var startOffset = startRenderBox.localToGlobal(Offset.zero);
    var endOffset=Offset(startOffset.dx-(cardWidth+(6.w)), startOffset.dy);
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