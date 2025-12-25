import 'package:flutter/material.dart';
import 'package:hiss_bbb/ui/page/cash_page/cash_page_controller.dart';
import 'package:hiss_bbb/ui/widget/hiss_cash_widget/hiss_cash_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_root_page.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_click_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_images_widget.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';

class CashPage extends HissRootPage<CashPageController>{

  @override
  CashPageController initGetController() => CashPageController();

  @override
  Widget initContent() => Stack(
    children: [
      HissCashWidget(tag: "cash_page"),
      Positioned(
        top: 52.h,
        right: 12.w,
        child: HissClickWidget(
          onTap: (){
            controller.clickClose();
          },
          child: HissImagesWidget(name: "icon_close", width: 28.w, height: 28.w),
        ),
      ),
    ],
  );
}