import 'package:flutter/material.dart';
import 'package:hiss_bbb/ui/dialog/set_dialog/set_dialog.dart';
import 'package:hiss_bbb/ui/widget/hiss_diamond_widget.dart';
import 'package:hiss_bbb/ui/widget/hiss_money_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_click_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_images_widget.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';
import 'package:hiss_root/hiss_utils/hiss_routers_utils.dart';

class HissTopWidget extends StatelessWidget{
  GlobalKey? moneyGlobalKey;
  Function()? clickSetCallback;
  HissTopWidget({
    this.moneyGlobalKey,
    this.clickSetCallback,
});

  @override
  Widget build(BuildContext context) => SizedBox(
    width: double.infinity,
    height: 90.h,
    child: Stack(
      alignment: Alignment.bottomCenter,
      children: [
        HissImagesWidget(name: "home1", width: double.infinity, height: double.infinity,),
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(left: 12.w,right: 12.w,bottom: 12.h),
          child: Row(
            children: [
              HissMoneyWidget(moneyGlobalKey: moneyGlobalKey,),
              SizedBox(width: 10.w,),
              HissDiamondWidget(),
              Spacer(),
              HissClickWidget(
                onTap: (){
                  if(null==clickSetCallback){
                    HissRoutersUtils.instance.showDialog(child: SetDialog());
                  }else{
                    clickSetCallback?.call();
                  }
                },
                child: HissImagesWidget(name: "icon_set", width: 28.w, height: 28.w,),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}