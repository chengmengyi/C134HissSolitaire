import 'package:hiss_root/hiss_ui/hiss_root_controller.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';
import 'package:hiss_root/hiss_utils/hiss_routers_utils.dart';

class HissWebController extends HissRootController{
  var title="";
  late WebViewController controller;

  @override
  void onInit() {
    super.onInit();
    var map = HissRoutersUtils.instance.getParams();
    title=map["title"];
    _loadCommonUrl(map["url"]);
  }

  _loadCommonUrl(url){
    controller=WebViewController()..setJavaScriptMode(JavaScriptMode.unrestricted)..loadRequest(Uri.parse(url));
  }
}