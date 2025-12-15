import 'package:flutter/material.dart';
import 'package:hiss_bbb/ui/dialog/input_account_dialog/input_account_dialog_controller.dart';
import 'package:hiss_bbb/utils/hiss_enum/hiss_cash_type.dart';
import 'package:hiss_root/hiss_ui/hiss_root_dialog.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_click_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_images_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_text_widget.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';
import 'package:hiss_root/hiss_utils/hiss_utils.dart';

class InputAccountDialog extends HissRootDialog<InputAccountDialogController>{
  @override
  InputAccountDialogController initGetController() => InputAccountDialogController();

  @override
  Widget initContent() => Container(
    width: double.infinity,
    padding: EdgeInsets.all(12.w),
    margin: EdgeInsets.only(left: 48.w,right: 48.w,),
    decoration: BoxDecoration(
      color: "#FFFFFF".toColor(),
      borderRadius: BorderRadius.circular(12.w),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _titleWidget(),
        SizedBox(height: 24.h,),
        _chooseTypeWidget(),
        SizedBox(height: 12.h,),
        _inputWidget(),
        SizedBox(height: 24.h,),
        _btnWidget(),
      ],
    ),
  );

  _titleWidget()=>HissTextWidget(
    textContent: "Payment Information",
    textSize: 18.sp,
    fontWeight: FontWeight.bold,
    textColor: "#000000".toColor(),
  );

  _chooseTypeWidget()=>GetBuilder<InputAccountDialogController>(
    id: "cash_type",
    builder: (_)=>Row(
      children: [
        Expanded(
          child: HissClickWidget(
            onTap: (){
              controller.clickCashType(HissCashType.paypal);
            },
            child: HissImagesWidget(name: controller.chooseCashType==HissCashType.paypal?"icon_paypal_sel":"icon_paypal_uns", width: double.infinity, height: 36.h,),
          ),
        ),
        SizedBox(width: 8.w,),
        Expanded(
          child: HissClickWidget(
            onTap: (){
              controller.clickCashType(HissCashType.cashapp);
            },
            child: HissImagesWidget(name: controller.chooseCashType==HissCashType.paypal?"icon_cashapp_uns":"icon_cashapp_sel", width: double.infinity, height: 36.h,),
          ),
        ),
      ],
    ),
  );

  _inputWidget()=>Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      HissTextWidget(
        textContent: "Account/Phone",
        textSize: 14.sp,
        textColor: "#000000".toColor(),
      ),
      SizedBox(height: 8.h,),
      Container(
        width: double.infinity,
        height: 48.h,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 12.w,right: 12.w),
        decoration: BoxDecoration(
          color: "#F0F0F0".toColor(),
          borderRadius: BorderRadius.circular(8.w),
        ),
        child: GetBuilder<InputAccountDialogController>(
          id: "input",
          builder: (_)=>TextField(
            enabled: true,
            maxLength: 30,
            textAlign: TextAlign.left,
            controller: controller.textEditingController,
            textInputAction: TextInputAction.done,
            style: TextStyle(
              fontSize: 14.sp,
              color: "#000000".toColor(),
              fontWeight: FontWeight.bold,
            ),
            decoration: InputDecoration(
              counterText: '',
              isCollapsed: true,
              hintText: controller.chooseCashType==HissCashType.paypal?"e.g. 123456789@abc.com":"e.g.5551234567",
              hintStyle: TextStyle(
                fontSize: 14.sp,
                color: "#999999".toColor(),
              ),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
      SizedBox(height: 12.h,),
      GetBuilder<InputAccountDialogController>(
        id: "cash_type_tips",
        builder: (_)=>HissTextWidget(
          textContent: controller.chooseCashType==HissCashType.paypal?"Direct to Your paypal Instant Payment":"Direct to Your cash app Instant Payment",
          textSize: 12.sp,
          textColor: "#666666".toColor(),
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );

  _btnWidget()=>HissClickWidget(
    onTap: (){
      controller.clickSubmit();
    },
    child: Container(
      width: double.infinity,
      height: 44.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: "#009CDE".toColor(),
        borderRadius: BorderRadius.circular(22.w),
      ),
      child: HissTextWidget(
        textContent: "Submit",
        textSize: 16.sp,
        fontWeight: FontWeight.bold,
        textColor: "#FFFFFF".toColor(),
      ),
    ),
  );
}