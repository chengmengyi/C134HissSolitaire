import 'package:flutter/material.dart';
import 'package:hiss_bbb/bean/hiss_card_bean.dart';
import 'package:hiss_bbb/utils/utils.dart';
import 'package:hiss_root/hiss_ui/hiss_root_stateful.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_click_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_images_widget.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_code.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_data.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';

class HissWasteMoveAnimatorWidget extends HissRootStateful{
  @override
  State<StatefulWidget> createState() => _HissWasteMoveAnimatorWidgetState();
}

class _HissWasteMoveAnimatorWidgetState extends HissRootStatefulState<HissWasteMoveAnimatorWidget> with TickerProviderStateMixin{
  var cardWidth=0.0,cardHeight=0.0;
  AnimationController? animationController;
  Animation<Offset>? animation;
  List<HissCardBean> cardList=[];

  @override
  initContent() {
    if(null==animationController||null==animation){
      return Container();
    }
    var marginLeft = (cardWidth+(6.w))/2;
    return AnimatedBuilder(
      animation: animationController!,
      builder: (_, __) {
        return Positioned(
          left: animation!.value.dx,
          top: animation!.value.dy,
          child: Stack(
            children: List.generate(cardList.length, (index){
              var bean = cardList[index];
              double left = marginLeft * (index + (3 - cardList.length));
              return Container(
                margin: EdgeInsets.only(left: left),
                child: HissImagesWidget(
                  name: getCardImages(bean),
                  width: cardWidth,
                  height: cardHeight,
                ),
              );
            }),
          ),
        );
      },
    );
  }

  @override
  bool canReceivedEventData() => true;

  @override
  handleEventBusData(HissEventData data) {
    switch(data.eventCode){
      case HissEventCode.aMoveOtherWasteAnimator:
        _moveOtherWasteAnimator(data.anyEventValue);
        break;
    }
  }

  _moveOtherWasteAnimator(anyEventValue)async{
    cardWidth = anyEventValue["cardWidth"];
    cardHeight = anyEventValue["cardHeight"];
    List<HissCardBean> cardList=anyEventValue["cardList"];
    this.cardList.clear();
    this.cardList.addAll(cardList);
    var startRenderBox = cardList.first.globalKey?.currentContext?.findRenderObject() as RenderBox;
    var startOffset = startRenderBox.localToGlobal(Offset.zero);
    var marginLeft = (cardWidth+(6.w))/2;
    var endOffset=Offset(startOffset.dx-marginLeft,startOffset.dy);

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