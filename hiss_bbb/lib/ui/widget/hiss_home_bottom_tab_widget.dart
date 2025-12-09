import 'package:flutter/material.dart';
import 'package:hiss_bbb/bean/hiss_home_bottom_tab_bean.dart';
import 'package:hiss_root/hiss_ui/hiss_root_stateful.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_click_widget.dart';
import 'package:hiss_root/hiss_ui/hiss_widget/hiss_images_widget.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_code.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_data.dart';
import 'package:hiss_root/hiss_utils/hiss_export.dart';

class HissHomeBottomTabWidget extends HissRootStateful{
  int initIndex;
  Function(int index) clickCallback;
  HissHomeBottomTabWidget({
    required this.initIndex,
    required this.clickCallback,
});
  @override
  State<StatefulWidget> createState() => _HissHomeBottomTabWidgetState();
}

class _HissHomeBottomTabWidgetState extends HissRootStatefulState<HissHomeBottomTabWidget>{
  List<HissHomeBottomTabBean> tabList=[];

  @override
  void initState() {
    super.initState();
    tabList.add(HissHomeBottomTabBean(unsIcon: "home_task_uns", selIcon: "home_task_sel", selected: false,));
    tabList.add(HissHomeBottomTabBean(unsIcon: "home_home_uns", selIcon: "home_home_sel", selected: false,));
    tabList.add(HissHomeBottomTabBean(unsIcon: "home_gift_uns", selIcon: "home_gift_sel", selected: false,));
    tabList.add(HissHomeBottomTabBean(unsIcon: "home_cash_uns", selIcon: "home_cash_sel", selected: false,));
    tabList[widget.initIndex].selected=true;
  }

  @override
  initContent() => SizedBox(
    width: double.infinity,
    height: 76.h,
    child: Stack(
      children: [
        HissImagesWidget(name: "home7", width: double.infinity, height: double.infinity),
        MasonryGridView.count(
          padding: const EdgeInsets.all(0),
          itemCount: tabList.length,
          shrinkWrap: true,
          crossAxisCount: 4,
          mainAxisSpacing: 0,
          crossAxisSpacing: 0,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context,index){
            var bean = tabList[index];
            return HissClickWidget(
              onTap: (){
                _clickItem(index);
              },
              child: Container(
                height: 76.h,
                alignment: bean.selected?Alignment.topCenter:Alignment.center,
                child: HissImagesWidget(
                  name: bean.selected?bean.selIcon:bean.unsIcon,
                  width: bean.selected?68.w:56.w,
                  height: bean.selected?68.w:56.w,
                ),
              ),
            );
          },
        ),
      ],
    ),
  );

  _clickItem(int index){
    if(index==0){
      widget.clickCallback.call(index);
      return;
    }
    _resetTab(index);
    widget.clickCallback.call(index);
  }

  @override
  bool canReceivedEventData() => true;

  @override
  handleEventBusData(HissEventData data) {
    switch(data.eventCode){
      case HissEventCode.updateHomeBottomTab:
        if(null!=data.intEventValue){
          _resetTab(data.intEventValue);
        }
        break;
    }
  }

  _resetTab(index){
    for (var value in tabList) {
      value.selected=false;
    }
    setState(() {
      tabList[index].selected=true;
    });
  }
}