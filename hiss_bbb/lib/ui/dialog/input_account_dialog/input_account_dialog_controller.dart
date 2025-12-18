import 'package:flutter/material.dart';
import 'package:hiss_bbb/utils/hiss_cash_task_utils.dart';
import 'package:hiss_bbb/utils/hiss_storage.dart';
import 'package:hiss_bbb/utils/utils.dart';
import 'package:hiss_root/hiss_ui/hiss_root_controller.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_code.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_data.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_send_event_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_routers_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_utils.dart';

class InputAccountDialogController extends HissRootController{
  var chooseCashType=cashTypeStorage.getData();
  TextEditingController textEditingController=TextEditingController();

  clickCashType(String type){
    if(chooseCashType==type){
      return;
    }
    textEditingController.text="";
    chooseCashType=type;
    cashTypeStorage.saveData(type);
    update(["cash_type","cash_type_tips","input"]);
    HissSendEventUtils.instance.sendEvent(data: HissEventData(eventCode: HissEventCode.updateCashTypeTab,strEventValue: type));
  }

  clickSubmit(int cashMoney,Function() callback)async{
    var content = textEditingController.text.trim();
    if(!isEmail(content)&&!isTenDigitNumber(content)){
      "The format you entered is incorrect.".showToast();
      return;
    }
    await HissCashTaskUtils.instance.saveAccount(chooseCashType, content);
    HissRoutersUtils.instance.close();
    callback.call();
  }

  clickClose(){
    HissRoutersUtils.instance.close();
  }

  @override
  void onClose() {
    textEditingController.dispose();
    super.onClose();
  }
}