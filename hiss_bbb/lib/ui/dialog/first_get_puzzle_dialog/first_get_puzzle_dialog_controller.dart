import 'package:hiss_bbb/bean/hiss_home_gift_progress_bean.dart';
import 'package:hiss_bbb/utils/hiss_home_gift_utils.dart';
import 'package:hiss_root/hiss_ui/hiss_root_controller.dart';
import 'package:hiss_root/hiss_utils/hiss_routers_utils.dart';

class FirstGetPuzzleDialogController extends HissRootController{
  List<HissHomeGiftProgressBean> topGiftList=[];

  @override
  void onReady() {
    super.onReady();
    _queryTopGiftList();
  }

  clickToGift(Function() toPuzzlePageCallback){
    HissRoutersUtils.instance.close();
    toPuzzlePageCallback.call();
  }

  clickClose(){
    HissRoutersUtils.instance.close();
  }

  _queryTopGiftList()async{
    var list = await HissHomeGiftUtils.instance.queryGiftList();
    topGiftList.clear();
    topGiftList.addAll(list);
    topGiftList.addAll(list);
    topGiftList.addAll(list);
    topGiftList.addAll(list);
    topGiftList.addAll(list);
    topGiftList.addAll(list);
    update(["top_list"]);
  }

}