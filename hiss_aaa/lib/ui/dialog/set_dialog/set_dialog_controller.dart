import 'package:hiss_root/hiss_ui/hiss_root_controller.dart';
import 'package:hiss_root/hiss_utils/hiss_local.dart';
import 'package:hiss_root/hiss_utils/hiss_mp3_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_routers_utils.dart';

class SetDialogController extends HissRootController{

  clickBgm(){
    HissMp3Utils.instance.setPlayBgm();
    update(["bgm"]);
  }

  clickOther(){
    HissMp3Utils.instance.setPlayOtherMp3();
    update(["other"]);
  }

  clickPrivacy(){
    HissRoutersUtils.instance.toWeb(title: "Privacy Policy", url: HissLocal.privacyUrl,);
  }
}