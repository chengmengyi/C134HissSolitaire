import 'package:flutter/material.dart';

class HissOverlayUtils{
  static final HissOverlayUtils _hissOverlayUtils=HissOverlayUtils();
  static HissOverlayUtils get instance => _hissOverlayUtils;

  OverlayEntry? _overlayEntry;

  showOverlay({
    required BuildContext context,
    required Widget widget,
  }){
    _overlayEntry=OverlayEntry(builder: (_)=>widget);
    Overlay.of(context).insert(_overlayEntry!);
  }

  hideOverlay(){
    _overlayEntry?.remove();
    _overlayEntry=null;
  }

}