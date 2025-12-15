import 'package:flutter/material.dart';
import 'package:hiss_bbb/utils/hiss_storage.dart';
import 'package:hiss_bbb/utils/utils.dart';
import 'package:hiss_root/hiss_ui/hiss_root_controller.dart';
import 'package:hiss_root/hiss_utils/hiss_routers_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_utils.dart';

class InputAccountDialogController extends HissRootController{
  var chooseCashType=cashTypeStorage.getData();
  TextEditingController textEditingController=TextEditingController();

  clickCashType(String type){
    textEditingController.text="";
    chooseCashType=type;
    cashTypeStorage.saveData(type);
    update(["cash_type","cash_type_tips","input"]);
  }

  clickSubmit(){
    var content = textEditingController.text.trim();
    if(!isEmail(content)&&!isTenDigitNumber(content)){
      "The format you entered is incorrect.".showToast();
      return;
    }
    HissRoutersUtils.instance.close();
  }

  @override
  void onClose() {
    textEditingController.dispose();
    super.onClose();
  }
}