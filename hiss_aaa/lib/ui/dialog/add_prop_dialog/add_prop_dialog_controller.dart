import 'package:hiss_aaa/utils/hiss_enum/hiss_prop_type.dart';
import 'package:hiss_aaa/utils/hiss_storage.dart';
import 'package:hiss_aaa/utils/hiss_user_info_utils.dart';
import 'package:hiss_aaa/utils/hiss_value_utils.dart';
import 'package:hiss_root/hiss_ui/hiss_root_controller.dart';
import 'package:hiss_root/hiss_utils/hiss_ad_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_routers_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_utils.dart';

class AddPropDialogController extends HissRootController{

  clickFree(HissPropType hissPropType){
    HissAdUtils.instance.showAAAAd(
      closeAdCallback: (){
        HissUserInfoUtils.instance.updatePropNum(hissPropType: hissPropType, addNum: HissValueUtils.instance.propAddNum());
        HissRoutersUtils.instance.close();
      },
    );
  }

  clickMoney(HissPropType hissPropType){
    if(aMoney.getData()<HissValueUtils.instance.propCostMoney()){
      "Not enough gold coins".showToast();
      return;
    }
    HissUserInfoUtils.instance.updateMoney(-HissValueUtils.instance.propCostMoney());
    HissUserInfoUtils.instance.updatePropNum(hissPropType: hissPropType, addNum: HissValueUtils.instance.propAddNum());
    HissRoutersUtils.instance.close();
  }

  clickClose(){
    HissRoutersUtils.instance.close();
  }
}