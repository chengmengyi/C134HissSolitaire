import 'package:hiss_aaa/bean/hiss_play_grade_bean.dart';
import 'package:hiss_aaa/bean/hiss_play_record_bean.dart';
import 'package:hiss_aaa/utils/hiss_play_record_utils.dart';
import 'package:hiss_aaa/utils/hiss_user_info_utils.dart';
import 'package:hiss_aaa/utils/hiss_value_utils.dart';
import 'package:hiss_root/hiss_ui/hiss_root_controller.dart';
import 'package:hiss_root/hiss_utils/hiss_routers_utils.dart';

class PlaySuccessController extends HissRootController{
  int score=0,time=0,step=0;
  List<HissPlayGradeBean> gradeList=[];

  PlaySuccessController({
    required this.score,
    required this.time,
    required this.step,
});

  @override
  void onInit() {
    super.onInit();
    _initRecord();
  }

  _initRecord()async{
    var currentRecordBean=HissPlayRecordBean(score: score,time: time,step: step,);
    var id = await HissPlayRecordUtils.instance.insertPlayRecord(score, time, step);
    var bestRecordBean = await HissPlayRecordUtils.instance.queryBestRecord(id);
    gradeList.add(HissPlayGradeBean(title: "Score", currentGrade: "${currentRecordBean.score}", bestGrade: "${bestRecordBean?.score??"--"}", currentIsBest: (currentRecordBean.score??0)>(bestRecordBean?.score??0)));
    gradeList.add(HissPlayGradeBean(title: "Time", currentGrade: "${currentRecordBean.time}", bestGrade: "${bestRecordBean?.time??"--"}", currentIsBest: (currentRecordBean.time??0)>(bestRecordBean?.time??0)));
    gradeList.add(HissPlayGradeBean(title: "Move", currentGrade: "${currentRecordBean.step}", bestGrade: "${bestRecordBean?.step??"--"}", currentIsBest: (currentRecordBean.step??0)>(bestRecordBean?.step??0)));
    update(["list"]);
  }

  clickClaim(Function() dismissCallback){
    HissUserInfoUtils.instance.updateMoney(HissValueUtils.instance.addMoneyNum());
    HissUserInfoUtils.instance.updateDiamondNum(HissValueUtils.instance.addDiamondNum());
    HissRoutersUtils.instance.close();
    dismissCallback.call();
  }
}