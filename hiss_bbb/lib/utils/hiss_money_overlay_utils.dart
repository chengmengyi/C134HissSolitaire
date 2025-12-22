import 'package:flutter/material.dart';
import 'package:hiss_bbb/ui/widget/hiss_money_lottie_widget.dart';

class HissMoneyOverlayUtils{
  static final HissMoneyOverlayUtils _hissMoneyOverlayUtils=HissMoneyOverlayUtils();
  static HissMoneyOverlayUtils get instance => _hissMoneyOverlayUtils;

  late BuildContext _buildContext;
  OverlayEntry? _overlayEntry;

  setContext(BuildContext context){
    _buildContext=context;
  }

  showOverlay(){
    _overlayEntry=OverlayEntry(builder: (_)=>HissMoneyLottieWidget(
      callback: (){
        hideOverlay();
      },
    ),);
    Overlay.of(_buildContext).insert(_overlayEntry!);
  }

  hideOverlay(){
    _overlayEntry?.remove();
    _overlayEntry=null;
  }
}