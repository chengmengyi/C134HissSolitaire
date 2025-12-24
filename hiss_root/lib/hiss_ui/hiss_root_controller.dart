import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_data.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_send_event_utils.dart';

abstract class HissRootController extends GetxController{
  late BuildContext buildContext;
  StreamSubscription<HissEventData>? _subscription;

  @override
  void onInit() {
    super.onInit();
    if(canReceivedEventData()){
      _subscription=HissSendEventUtils.instance.getEventBus().on<HissEventData>().listen((data) {
        handleEventBusData(data);
      });
    }
  }


  bool canReceivedEventData()=>true;

  handleEventBusData(HissEventData data){}

  @override
  void onClose() {
    if(canReceivedEventData()){
      _subscription?.cancel();
      _subscription=null;
    }
    super.onClose();
  }
}