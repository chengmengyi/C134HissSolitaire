import 'package:flutter/material.dart';
import 'package:hiss_aaa/bean/hiss_card_bean.dart';
import 'package:hiss_aaa/bean/hiss_hint_bean.dart';
import 'package:hiss_aaa/utils/utils.dart';
import 'package:hiss_root/hiss_ui/hiss_root_stateful.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_images_widget.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_code.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_data.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';
import 'package:hiss_root/hiss_utils/hiss_utils.dart';

class HissHintAnimatorWidget extends HissRootStateful{
  @override
  State<StatefulWidget> createState() => _HissHintAnimatorWidgetState();
}

class _HissHintAnimatorWidgetState extends HissRootStatefulState<HissHintAnimatorWidget> with TickerProviderStateMixin{
  List<HissCardBean> fromCardList=[];
  var cardWidth=0.0,cardHeight=0.0;
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
          child: Stack(
            children: List.generate(fromCardList.length, (index){
              return Container(
                margin: EdgeInsets.only(top: index*(12.h)),
                child: Opacity(
                  opacity: 0.8,
                  child: HissImagesWidget(name: getCardImages(fromCardList[index]), width: cardWidth, height: cardHeight,),
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
      case HissEventCode.aHintAnimator:
        _hintAnimator(data.anyEventValue);
        break;
    }
  }

  _hintAnimator(anyEventValue)async{
    cardWidth = anyEventValue["cardWidth"];
    cardHeight = anyEventValue["cardHeight"];
    List<HissHintBean> hints=anyEventValue["hints"];
    List<List<HissCardBean>> cardList=anyEventValue["cardList"];
    // for (var h in hints) {
    //   if (h.toCol != null) {
    //     print("列 ${h.fromCol} 的 ${h.cards.length} 张牌 可移动到列 ${h.toCol}===${h.cards}");
    //   } else if (h.toFoundation != null) {
    //     print("列 ${h.fromCol} 顶牌可移动到 Foundation ${h.toFoundation}");
    //   }
    // }
    HissHintBean hintBean = hints.random();
    fromCardList.clear();
    fromCardList.addAll(hintBean.cards);
    Offset? startOffset;
    Offset? endOffset;
    //移动到其他列
    if(null!=hintBean.toCol){
      var length = hintBean.cards.length;
      var fromColLength = cardList[hintBean.fromCol].length;
      var fromCard = cardList[hintBean.fromCol][fromColLength-length];
      var fromRenderBox = fromCard.globalKey?.currentContext?.findRenderObject() as RenderBox;
      startOffset = fromRenderBox.localToGlobal(Offset.zero);
      var endCard = cardList[hintBean.toCol??0].last;
      var endRenderBox = endCard.globalKey?.currentContext?.findRenderObject() as RenderBox;
      var offset = endRenderBox.localToGlobal(Offset.zero);
      endOffset=Offset(offset.dx, offset.dy+(12.h));
    }else if(hintBean.toFoundation != null){ //移动到Foundation
      List<GlobalKey> foundationsGlobalKeyList = anyEventValue["foundationsGlobalKeyList"];
      var startRenderBox = cardList[hintBean.fromCol].last.globalKey?.currentContext?.findRenderObject() as RenderBox;
      startOffset = startRenderBox.localToGlobal(Offset.zero);
      var endRenderBox = foundationsGlobalKeyList[hintBean.toFoundation??0].currentContext?.findRenderObject() as RenderBox;
      endOffset = endRenderBox.localToGlobal(Offset.zero);
    }
    if(null==startOffset||null==endOffset){
      return;
    }
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
    await animationController?.repeat(
      reverse: true,
      period: const Duration(milliseconds: 500),
      count: 5,
    );
    animationController=null;
    setState(() {});
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }
}