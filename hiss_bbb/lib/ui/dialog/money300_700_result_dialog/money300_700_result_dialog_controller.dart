import 'package:hiss_bbb/utils/hiss_storage.dart';
import 'package:hiss_root/hiss_ui/hiss_root_controller.dart';
import 'package:hiss_root/hiss_utils/hiss_routers_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_utils.dart';

class Money300700ResultDialogController extends HissRootController{

  clickPlayGame(){
    HissRoutersUtils.instance.close();
  }

  String getProText(int index,int maxMoney){
    switch(index){
      case 0: return "Submit payment information";
      case 1: return "Just \$${doubleSub(maxMoney, bMoneyNum.getData())} away from payout!";
      case 2: return "Revenue received";
      default: return "";
    }
  }
}