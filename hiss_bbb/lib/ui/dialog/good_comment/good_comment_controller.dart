import 'package:hiss_root/hiss_ui/hiss_root_controller.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';
import 'package:hiss_root/hiss_utils/hiss_routers_utils.dart';

class GoodCommentController extends HissRootController{
  var index=-1;

  clickItem(int index){
    this.index=index;
    update(["list"]);
  }

  clickFeed(Function() callback)async{
    if(index<3){
      HissRoutersUtils.instance.close();
      callback.call();
      return;
    }
    var instance = InAppReview.instance;
    if (await instance.isAvailable()) {
      instance.requestReview();
    }
    HissRoutersUtils.instance.close();
    callback.call();
  }
}