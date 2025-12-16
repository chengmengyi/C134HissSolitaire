import 'package:hiss_root/hiss_utils/hiss_export.dart';

class HissShowAdUtils{
  static final HissShowAdUtils _adUtils=HissShowAdUtils();
  static HissShowAdUtils get instance => _adUtils;

  bool showAd(AdType adType){
    return true;
  }
}