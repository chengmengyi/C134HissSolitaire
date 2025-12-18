import 'package:flutter/material.dart';
import 'package:hiss_root/hiss_ui/hiss_root_controller.dart';

class InputAddressController extends HissRootController{
  var inputTips="";
  TextEditingController firstNameTextEditingController=TextEditingController();
  TextEditingController lastNameTextEditingController=TextEditingController();
  TextEditingController addressTextEditingController=TextEditingController();
  TextEditingController phoneTextEditingController=TextEditingController();

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

    var phone = phoneTextEditingController.text.trim();
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