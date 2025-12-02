import 'package:flutter/material.dart';
import 'package:hiss_aaa/ui/dialog/add_prop_dialog/add_prop_dialog_controller.dart';
import 'package:hiss_aaa/utils/hiss_enum/hiss_prop_type.dart';
import 'package:hiss_aaa/utils/hiss_value_utils.dart';
import 'package:hiss_root/hiss_ui/hiss_root_dialog.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_click_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_images_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_text_widget.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';
import 'package:hiss_root/hiss_utils/hiss_utils.dart';

class AddPropDialog extends HissRootDialog<AddPropDialogController>{
  HissPropType hissPropType;
  Function() dismissCallback;
  AddPropDialog({
    required this.hissPropType,
    required this.dismissCallback,
});
  @override
  AddPropDialogController initGetController() => AddPropDialogController();

  @override
  Widget initContent() => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: double.infinity,
        height: 320.h,
        margin: EdgeInsets.only(left: 20.w,right: 20.w),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            HissImagesWidget(name: "prop1", width: double.infinity, height: double.infinity),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                HissImagesWidget(name: hissPropType==HissPropType.back?"play7":"play9", width: 84.w, height: 84.w,),
                SizedBox(height: 4.h,),
                HissTextWidget(
                  textContent: "+${HissValueUtils.instance.propAddNum()}",
                  textSize: 24.sp,
                  textColor: "#FFD21D".toColor(),
                  outlineColor: "#6E2F15".toColor(),
                  fontWeight: FontWeight.w900,
                ),
                SizedBox(height: 32.h,),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    HissClickWidget(
                      onTap: (){
                        controller.clickMoney(hissPropType,dismissCallback);
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          HissImagesWidget(name: "btn1", width: 120.w, height: 48.h),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              HissImagesWidget(name: "icon_money", width: 24.w, height: 24.w,),
                              SizedBox(width: 4.w,),
                              HissTextWidget(
                                textContent: "100",
                                textSize: 20.sp,
                                textColor: "#FFFFFF".toColor(),
                                fontWeight: FontWeight.w900,
                                outlineColor: "#133D03".toColor(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 6.w,),
                    HissClickWidget(
                      onTap: (){
                        controller.clickFree(hissPropType,dismissCallback);
                      },
                      child: SizedBox(
                        width: 120.w,
                        height: 48.h,
                        child: Stack(
                          children: [
                            HissImagesWidget(name: "btn2", width: 120.w, height: 48.h),
                            Align(
                              alignment: Alignment.center,
                              child: HissTextWidget(
                                textContent: "Free",
                                textSize: 20.sp,
                                textColor: "#FFFFFF".toColor(),
                                fontWeight: FontWeight.w900,
                                outlineColor: "#133D03".toColor(),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: HissImagesWidget(name: "icon_video", width: 20.w, height: 20.w),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h,),
              ],
            ),
          ],
        ),
      ),
      SizedBox(height: 20.h,),
      HissClickWidget(
        onTap: (){
          controller.clickClose();
        },
        child: HissImagesWidget(name: "icon_close", width: 28.w, height: 28.w,),
      ),
    ],
  );
}