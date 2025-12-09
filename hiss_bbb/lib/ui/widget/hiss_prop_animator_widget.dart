import 'package:flutter/material.dart';
import 'package:hiss_bbb/utils/hiss_enum/hiss_prop_type.dart';
import 'package:hiss_root/hiss_ui/hiss_root_stateful.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_images_widget.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_code.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_data.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';

class HissPropAnimatorWidget extends HissRootStateful{
  @override
  State<StatefulWidget> createState() => _HissPropAnimatorWidgetState();
}
class _HissPropAnimatorWidgetState extends HissRootStatefulState<HissPropAnimatorWidget> with TickerProviderStateMixin{
  HissPropType hissPropType=HissPropType.tips;
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
          child: HissImagesWidget(name: hissPropType==HissPropType.back?"play7":"play9", width: 56.w, height: 56.w),
        );
      },
    );
  }

  @override
  bool canReceivedEventData() => true;

  @override
  handleEventBusData(HissEventData data) {
    switch(data.eventCode){
      case HissEventCode.aShowPropAnimator:
        _showPropAnimator(data.anyEventValue);
        break;
    }
  }

  _showPropAnimator(anyEventValue)async{
    hissPropType=anyEventValue["hissPropType"];
    GlobalKey endGlobalKey=anyEventValue["endGlobalKey"];
    var endRenderBox = endGlobalKey.currentContext?.findRenderObject() as RenderBox;
    var endOffset = endRenderBox.localToGlobal(Offset.zero);
    var size = MediaQuery.of(buildContext).size;
    var startOffset=Offset(size.width/2, size.height/2);
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