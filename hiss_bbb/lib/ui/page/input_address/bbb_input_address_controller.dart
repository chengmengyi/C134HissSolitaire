import 'package:flutter/material.dart';
import 'package:hiss_root/hiss_ui/hiss_root_controller.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_point_enum.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_point_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_routers_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_utils.dart';

class BBBInputAddressController extends HissRootController{
  var inputTips="";
  TextEditingController firstNameTextEditingController=TextEditingController();
  TextEditingController lastNameTextEditingController=TextEditingController();
  TextEditingController addressTextEditingController=TextEditingController();
  TextEditingController phoneTextEditingController=TextEditingController();

  @override
  void onInit() {
    super.onInit();
    HissPointUtils.instance.pointEvent(hissPointEnum: HissPointEnum.gift_address);
  }

  clickConfirm(){
    var firstName = firstNameTextEditingController.text.trim();
    if(firstName.isEmpty){
      inputTips="Please Enter A First Name. ";
      update(["input_tips"]);
      return;
    }
    var lastName = lastNameTextEditingController.text.trim();
    if(lastName.isEmpty){
      inputTips="Please Enter A Last Name. ";
      update(["input_tips"]);
      return;
    }
    var address = addressTextEditingController.text.trim();
    if(address.isEmpty){
      showToast("Please enter the address");
      return;
    }
    var phone = phoneTextEditingController.text.trim();
    if(phone.isEmpty){
      showToast("Please enter the phone");
      return;
    }
    HissRoutersUtils.instance.close();
  }

  @override
  void onClose() {
    firstNameTextEditingController.dispose();
    lastNameTextEditingController.dispose();
    addressTextEditingController.dispose();
    phoneTextEditingController.dispose();
    super.onClose();
  }
}