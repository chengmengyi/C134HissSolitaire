import 'package:flutter/material.dart';
import 'package:hiss_bbb/bean/hiss_cash_barrage_bean.dart';
import 'package:hiss_bbb/utils/hiss_value_config_utils.dart';
import 'package:hiss_bbb/utils/utils.dart';
import 'package:hiss_root/hiss_ui/hiss_root_stateful.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_images_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_text_widget.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';
import 'package:hiss_root/hiss_utils/hiss_utils.dart';

class HissCashBarrageWidget extends HissRootStateful{
  @override
  State<StatefulWidget> createState() => _HissCashBarrageWidgetState();
}

class _HissCashBarrageWidgetState extends HissRootStatefulState<HissCashBarrageWidget>{
  List<HissCashBarrageBean> list=[];
  @override
  void initState() {
    super.initState();
    _initList();
  }

  @override
  initContent() => HorizontalScroller<HissCashBarrageBean>(
    items: list,
    height: 32.h,
    enableAutoScroll: true,
    scrollSpeed: 60,
    enableInfiniteScroll: false,
    backgroundColor: Colors.transparent,
    itemPadding: EdgeInsets.zero,
    margin: EdgeInsets.zero,
    enableClick: false,
    enableRipple: false,
    itemBuilder: (item, index) {
      return Container(
        height: 32.h,
        margin: EdgeInsets.only(left: 100.w,right: 100.w),
        padding: EdgeInsets.only(left: 4.w,right: 4.w),
        decoration: BoxDecoration(
          color: "#000000".toColor(),
          borderRadius: BorderRadius.circular(16.w),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            HissImagesWidget(name: item.icon, width: 24.w, height: 24.w,),
            SizedBox(width: 8.w,),
            //congrats, 1****869 withdraw $1500
            HissTextWidget(textContent: "Congrats, ${item.phone} withdraw ", textSize: 14.sp, textColor: "#FFFFFF".toColor(),),
            HissTextWidget(textContent: "\$${item.money}", textSize: 14.sp, textColor: "#FFD21D".toColor(),),
          ],
        ),
      );
    },
  );

  _initList(){
    var iconList = ["icon_pay_circle","icon_cashapp_circle"];
    while(list.length<100){
      list.add(HissCashBarrageBean(icon: iconList.random(), phone: strSetStr(randomString(9)), money: HissValueConfigUtils.instance.cashList().random()));
    }
  }
}