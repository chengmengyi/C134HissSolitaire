import 'package:flutter/material.dart';
import 'package:hiss_bbb/ui/page/input_address/bbb_input_address_controller.dart';
import 'package:hiss_root/hiss_ui/hiss_root_page.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_click_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_images_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_text_widget.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';
import 'package:hiss_root/hiss_utils/hiss_routers_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_utils.dart';

class BBBInputAddressPage extends HissRootPage<BBBInputAddressController>{
  @override
  BBBInputAddressController initGetController() => BBBInputAddressController();

  @override
  Widget initContent() =>Container(
    color: "#F0F0F0".toColor(),
    child: Column(
      children: [
        _titleWidget(),
        _tipsWidget(),
        _nameWidget(),
        _addressWidget(),
        Spacer(),
        _btnWidget(),
        SizedBox(height: 44.h,),
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
      margin: EdgeInsets.only(left: 20.w,right: 20.w),
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

  _addressWidget()=>Container(
    width: double.infinity,
    padding: EdgeInsets.all(10.w),
    margin: EdgeInsets.only(left: 12.w,right: 12.w,top: 8.h),
    decoration: BoxDecoration(
      color: "#FFFFFF".toColor(),
      borderRadius: BorderRadius.circular(12.w),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HissTextWidget(
          textContent: "Enter Address Manually",
          textSize: 14.sp,
          fontWeight: FontWeight.bold,
          textColor: "#000000".toColor(),
        ),
        SizedBox(height: 4.h,),
        Container(
          width: double.infinity,
          height: 48.h,
          padding: EdgeInsets.only(left: 12.w,right: 12.w),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: "#F0F0F0".toColor(),
            borderRadius: BorderRadius.circular(8.w),
          ),
          child: TextField(
            enabled: true,
            maxLength: 30,
            textAlign: TextAlign.left,
            controller: controller.addressTextEditingController,
            textInputAction: TextInputAction.done,
            style: TextStyle(
              fontSize: 14.sp,
              color: "#000000".toColor(),
              fontWeight: FontWeight.bold,
            ),
            decoration: InputDecoration(
              counterText: '',
              isCollapsed: true,
              hintText: "Enter",
              hintStyle: TextStyle(
                fontSize: 14.sp,
                color: "#999999".toColor(),
              ),
              border: InputBorder.none,
            ),
          ),
        ),
        SizedBox(height: 12.h,),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            HissTextWidget(
              textContent: "Phone Number",
              textSize: 16.sp,
              fontWeight: FontWeight.bold,
              textColor: "#000000".toColor(),
            ),
            HissTextWidget(
              textContent: "*",
              textSize: 16.sp,
              fontWeight: FontWeight.bold,
              textColor: "#FF4400".toColor(),
            ),
          ],
        ),
        SizedBox(height: 4.h,),
        Container(
          width: double.infinity,
          height: 48.h,
          padding: EdgeInsets.only(left: 12.w,right: 12.w),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: "#F0F0F0".toColor(),
            borderRadius: BorderRadius.circular(8.w),
          ),
          child: TextField(
            enabled: true,
            maxLength: 30,
            textAlign: TextAlign.left,
            controller: controller.phoneTextEditingController,
            textInputAction: TextInputAction.done,
            style: TextStyle(
              fontSize: 14.sp,
              color: "#000000".toColor(),
              fontWeight: FontWeight.bold,
            ),
            decoration: InputDecoration(
              counterText: '',
              isCollapsed: true,
              hintText: "E.G. 123 456 7890",
              hintStyle: TextStyle(
                fontSize: 14.sp,
                color: "#999999".toColor(),
              ),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    ),
  );

  _nameWidget()=>Container(
    width: double.infinity,
    padding: EdgeInsets.all(10.w),
    margin: EdgeInsets.only(left: 12.w,right: 12.w),
    decoration: BoxDecoration(
      color: "#FFFFFF".toColor(),
      borderRadius: BorderRadius.circular(12.w),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HissTextWidget(
          textContent: "Country / Region: United States >",
          textSize: 14.sp,
          fontWeight: FontWeight.bold,
          textColor: "#000000".toColor(),
        ),
        Container(
          width: double.infinity,
          height: 0.5.h,
          color: "#F0F0F0".toColor(),
          margin: EdgeInsets.only(top: 10.h,bottom: 10.h),
        ),
        Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      HissTextWidget(
                        textContent: "First Name",
                        textSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        textColor: "#000000".toColor(),
                      ),
                      HissTextWidget(
                        textContent: "*",
                        textSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        textColor: "#FF4400".toColor(),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h,),
                  Container(
                    width: double.infinity,
                    height: 48.h,
                    padding: EdgeInsets.only(left: 12.w,right: 12.w),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: "#F0F0F0".toColor(),
                      borderRadius: BorderRadius.circular(8.w),
                    ),
                    child: TextField(
                      enabled: true,
                      maxLength: 30,
                      textAlign: TextAlign.left,
                      controller: controller.firstNameTextEditingController,
                      textInputAction: TextInputAction.done,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: "#000000".toColor(),
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        counterText: '',
                        isCollapsed: true,
                        hintText: "",
                        hintStyle: TextStyle(
                          fontSize: 14.sp,
                          color: "#999999".toColor(),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 7.w,),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      HissTextWidget(
                        textContent: "Last Name",
                        textSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        textColor: "#000000".toColor(),
                      ),
                      HissTextWidget(
                        textContent: "*",
                        textSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        textColor: "#FF4400".toColor(),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h,),
                  Container(
                    width: double.infinity,
                    height: 48.h,
                    padding: EdgeInsets.only(left: 12.w,right: 12.w),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: "#F0F0F0".toColor(),
                      borderRadius: BorderRadius.circular(8.w),
                    ),
                    child: TextField(
                      enabled: true,
                      maxLength: 30,
                      textAlign: TextAlign.left,
                      controller: controller.lastNameTextEditingController,
                      textInputAction: TextInputAction.done,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: "#000000".toColor(),
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        counterText: '',
                        isCollapsed: true,
                        hintText: "",
                        hintStyle: TextStyle(
                          fontSize: 14.sp,
                          color: "#999999".toColor(),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        GetBuilder<BBBInputAddressController>(
          id: "input_tips",
          builder: (_)=>Visibility(
            visible: controller.inputTips.isNotEmpty,
            child: Container(
              margin: EdgeInsets.only(top: 8.h),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  HissImagesWidget(name: "icon_tips", width: 12.w, height: 12.w),
                  SizedBox(width: 2.w,),
                  HissTextWidget(
                    textContent: controller.inputTips,
                    textSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    textColor: "#EA3A3A".toColor(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
  
  _tipsWidget()=>Container(
    width: double.infinity,
    height: 44.h,
    padding: EdgeInsets.only(left: 12.w,right: 12.w),
    child: Row(
      children: [
        HissImagesWidget(name: "icon_lock", width: 16.w, height: 16.w,),
        SizedBox(width: 2.w,),
        HissTextWidget(textContent: "All data is safeguarded", textSize: 16.sp, textColor: "#259B01".toColor(),),
        Spacer(),
        HissImagesWidget(name: "icon_gou", width: 16.w, height: 16.w,),
        SizedBox(width: 2.w,),
        HissTextWidget(textContent: "Free shipping", textSize: 16.sp, textColor: "#259B01".toColor(),),
      ],
    ),
  );

  _titleWidget()=>Container(
    color: "#FFFFFF".toColor(),
    child: SafeArea(
      child: SizedBox(
        width: double.infinity,
        height: 44.h,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: HissClickWidget(
                onTap: (){
                  HissRoutersUtils.instance.close();
                },
                child: Container(
                  width: 44.w,
                  height: 44.h,
                  alignment: Alignment.center,
                  child: HissImagesWidget(name: "icon_back", width: 24.w, height: 24.w,),
                ),
              ),
            ),
            Align(
              child: HissTextWidget(
                textContent: "Shipping Address",
                textSize: 18.sp,
                fontWeight: FontWeight.bold,
                textColor: "#000000".toColor(),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}