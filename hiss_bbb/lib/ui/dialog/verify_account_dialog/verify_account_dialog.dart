import 'package:flutter/material.dart';
import 'package:hiss_bbb/ui/dialog/verify_account_dialog/verify_account_dialog_controller.dart';
import 'package:hiss_bbb/utils/hiss_enum/hiss_cash_type.dart';
import 'package:hiss_bbb/utils/hiss_storage.dart';
import 'package:hiss_root/hiss_ui/hiss_root_dialog.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_click_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_gradient_text_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_images_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_text_widget.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';
import 'package:hiss_root/hiss_utils/hiss_utils.dart';

class VerifyAccountDialog extends HissRootDialog<VerifyAccountDialogController>{

  @override
  VerifyAccountDialogController initGetController() => VerifyAccountDialogController();

  @override
  Widget initContent() =>  Container(
    width: double.infinity,
    padding: EdgeInsets.all(12.w),
    margin: EdgeInsets.only(left: 48.w,right: 48.w,),
    decoration: BoxDecoration(
      color: "#FFFFFF".toColor(),
      borderRadius: BorderRadius.circular(12.w),
    ),
    child: Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _titleWidget(),
            SizedBox(height: 12.h,),
            _moneyWidget(),
            SizedBox(height: 12.h,),
            _infoWidget(),
            SizedBox(height: 24.h,),
            _btnWidget(),
          ],
        ),
        Positioned(
          right: 0,
          child: HissClickWidget(
            onTap: (){
              controller.clickConfirm(); 
            },
            child: HissImagesWidget(name: "icon_close3", width: 24.w, height: 24.w,),
          ),
        )
      ],
    ),
  ); 

  _titleWidget()=>Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      //Please verify your
      // payout account!
      HissTextWidget(
        textContent: "Please verify your",
        textSize: 18.sp,
        textColor: "#000000".toColor(),
        fontWeight: FontWeight.w900,
      ),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          HissTextWidget(
            textContent: "payout account",
            textSize: 18.sp,
            textColor: "#EA3030".toColor(),
            fontWeight: FontWeight.w900,
          ),
          HissTextWidget(
            textContent: "!",
            textSize: 18.sp,
            textColor: "#000000".toColor(),
            fontWeight: FontWeight.w900,
          ),
        ],
      ),
    ],
  );
  
  _moneyWidget()=>Container(
    width: double.infinity,
    padding: EdgeInsets.all(10.w),
    decoration: BoxDecoration(
      color: "#043D7E".toColor(),
      borderRadius: BorderRadius.circular(8.w),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HissTextWidget(
          textContent: "Balance",
          textSize: 12.sp,
          fontWeight: FontWeight.bold,
          textColor: "#9BB1CB".toColor(),
        ),
        SizedBox(height: 10.h,),
        HissGradientTextWidget(
          textContent: "\$1000",
          textSize: 20.sp,
          fontWeight: FontWeight.w900,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: ["#FFFFFF".toColor(),"#FFEEA9".toColor(),],
          ),
        ),
      ],
    ),
  );
  
  _infoWidget()=>ClipRRect(
    borderRadius: BorderRadiusGeometry.circular(8.w),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _infoItemWidget("Payout Platform","HissSolitaire","#E3E3E3".toColor(),""),
        _infoItemWidget("Payout Instructions","Game rewards","#F4F4F4".toColor(),""),
        _infoItemWidget("Creation time",getTodayTime(),"#E3E3E3".toColor(),""),
        _infoItemWidget("Account information",controller.account,"#F4F4F4".toColor(),""),
        _infoItemWidget("Frequency","One Time","#E3E3E3".toColor(),""),
        _infoItemWidget("Payment method","","#F4F4F4".toColor(),cashTypeStorage.getData()),
      ],
    ),
  );

  _infoItemWidget(String title,String content,Color color,String cashType)=>Container(
    width: double.infinity,
    height: 28.h,
    color: color,
    padding: EdgeInsets.only(left: 12.w,right: 12.w),
    child: Row(
      children: [
        HissTextWidget(
          textContent: title,
          textSize: 11.sp,
          fontWeight: FontWeight.bold,
          textColor: "#444444".toColor(),
        ),
        Spacer(),
        cashType.isNotEmpty?
        HissImagesWidget(
          name: cashType==HissCashType.paypal?"icon_paypal_sel":"icon_cashapp_sel",
          width: 68.w,
          height: 20.h,
        ):
        HissTextWidget(
          textContent: content,
          textSize: 11.sp,
          fontWeight: FontWeight.bold,
          textColor: "#444444".toColor(),
        ),
      ],
    ),
  );

  _btnWidget()=>HissClickWidget(
    onTap: (){
      controller.clickConfirm();
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
        textContent: "Confirm",
        textSize: 16.sp,
        fontWeight: FontWeight.bold,
        textColor: "#FFFFFF".toColor(),
      ),
    ),
  );
}