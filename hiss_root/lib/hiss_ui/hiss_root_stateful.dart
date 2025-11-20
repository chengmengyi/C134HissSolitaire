import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_data.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_send_event_utils.dart';

abstract class HissRootStateful extends StatefulWidget{}

abstract class HissRootStatefulState<T extends HissRootStateful> extends State<T>{
  late BuildContext buildContext;
  StreamSubscription<HissEventData>? _subscription;

  @override
  void initState() {
    super.initState();
    if(canReceivedEventData()){
      _subscription=HissSendEventUtils.instance.getEventBus().on<HissEventData>().listen((data) {
        handleEventBusData(data);
      });
    }
  }

  @override
  Widget build(BuildContext context){
    buildContext=context;
    return initContent();
  }

  initContent();

  bool canReceivedEventData()=>true;

  handleEventBusData(HissEventData data){}
}