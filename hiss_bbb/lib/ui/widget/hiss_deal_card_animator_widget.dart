import 'package:flutter/material.dart';
import 'package:hiss_bbb/bean/hiss_card_bean.dart';
import 'package:hiss_root/hiss_ui/hiss_root_stateful.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_images_widget.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_code.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_data.dart';
import 'package:hiss_root/hiss_utils/hiss_mp3_utils.dart';

class HissDealCardAnimatorWidget extends HissRootStateful{
  Function() allAnimatorCompletedCallback;
  HissDealCardAnimatorWidget({
    required this.allAnimatorCompletedCallback,
  });
  @override
  State<StatefulWidget> createState() => _HissDealCardAnimatorWidgetState();
}

class _HissDealCardAnimatorWidgetState extends HissRootStatefulState<HissDealCardAnimatorWidget> with TickerProviderStateMixin{
  var cardWidth=0.0,cardHeight=0.0;
  final List<Offset> positions = [];
  final List<AnimationController> controllers = [];
  final List<Animation<Offset>> animations = [];

  @override
  initContent() {
    if(positions.isEmpty){
      return Container();
    }
    return Stack(
      children: List.generate(animations.length, (i){
        return AnimatedBuilder(
          animation: controllers[i],
          builder: (_, __) {
            return Positioned(
              left: animations[i].value.dx,
              top: animations[i].value.dy,
              child: HissImagesWidget(name: "card_bg", width: cardWidth, height: cardHeight),
            );
          },
        );
      }),
    );
  }

  @override
  bool canReceivedEventData() => true;

  @override
  handleEventBusData(HissEventData data) {
    switch(data.eventCode){
      case HissEventCode.aStartDealCardsAnimator:
        _startDealCardsAnimator(data.anyEventValue);
        break;
    }
  }

  _startDealCardsAnimator(anyEventValue){
    cardWidth = anyEventValue["cardWidth"];
    cardHeight = anyEventValue["cardHeight"];
    GlobalKey stockPileGlobalKey = anyEventValue["stockPileGlobalKey"];
    List<List<HissCardBean>> cardList = anyEventValue["cardList"];

    var stockPileRenderBox = stockPileGlobalKey.currentContext?.findRenderObject() as RenderBox?;
    if (stockPileRenderBox == null || !mounted) return;

    var startOffset = stockPileRenderBox.localToGlobal(Offset.zero);
    positions.clear();
    for (var value in cardList) {
      for (var value1 in value) {
        var renderBox = value1.globalKey?.currentContext?.findRenderObject() as RenderBox?;
        if (renderBox == null) continue;
        var endOffset = renderBox.localToGlobal(Offset.zero);
        positions.add(endOffset);
      }
    }

    int completedCount = 0;
    int total = positions.length;
    for (int i = 0; i < positions.length; i++) {
      Future.delayed(Duration(milliseconds: i * 50), () {
        if (!mounted) return;

        final controller = AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 300),
        );

        final anim = Tween<Offset>(
          begin: startOffset,
          end: positions[i],
        ).animate(CurvedAnimation(
          parent: controller,
          curve: Curves.easeOut,
        ));

        controller.addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            completedCount++;
            if (completedCount == total) {
              setState(() {
                positions.clear();
                controllers.clear();
                animations.clear();
              });
              widget.allAnimatorCompletedCallback.call();
            }
          }
        });

        controllers.add(controller);
        animations.add(anim);

        controller.forward();
        setState(() {});
      });
    }
  }

  @override
  void dispose() {
    for (var c in controllers) {
      c.dispose();
    }
    super.dispose();
  }
}