import 'package:flutter/material.dart';
import 'package:hiss_bbb/utils/hiss_enum/hiss_prop_type.dart';
import 'package:hiss_root/hiss_ui/hiss_root_stateful.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_images_widget.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_code.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_data.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';

class HissGiftPuzzleAnimatorWidget extends HissRootStateful{
  @override
  State<StatefulWidget> createState() => _HissDiamondPigAnimatorWidgetState();
}
class _HissDiamondPigAnimatorWidgetState extends HissRootStatefulState<HissGiftPuzzleAnimatorWidget> with TickerProviderStateMixin{
  AnimationController? animationController;
  Animation<Offset>? animation;

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
          child: HissImagesWidget(name: "icon_gift", width: 36.w, height: 36.w),
        );
      },
    );
  }

  @override
  bool canReceivedEventData() => true;

  @override
  handleEventBusData(HissEventData data) {
    switch(data.eventCode){
      case HissEventCode.showGiftPuzzleAnimator:
        _showAnimator(data.anyEventValue);
        break;
    }
  }

  _showAnimator(anyEventValue)async{
    var cardWidth=anyEventValue["cardWidth"];
    var cardHeight=anyEventValue["cardHeight"];
    GlobalKey startGlobalKey=anyEventValue["startGlobalKey"];
    var startRenderBox = startGlobalKey.currentContext?.findRenderObject() as RenderBox;
    var offset1 = startRenderBox.localToGlobal(Offset.zero);
    var startOffset=Offset(offset1.dx+(cardWidth-36.w)/2, offset1.dy+(cardHeight-36.w)/2);

    GlobalKey endGlobalKey=anyEventValue["endGlobalKey"];
    var endRenderBox = endGlobalKey.currentContext?.findRenderObject() as RenderBox;
    var offset2 = endRenderBox.localToGlobal(Offset.zero);
    var endOffset=Offset(offset2.dx+20.w, offset2.dy+20.w);

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
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