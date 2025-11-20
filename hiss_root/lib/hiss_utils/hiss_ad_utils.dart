class HissAdUtils{
  static final HissAdUtils _adUtils=HissAdUtils();
  static HissAdUtils get instance => _adUtils;

  showAAAAd({
    required Function() closeAdCallback,
  }){
    closeAdCallback.call();
  }
}