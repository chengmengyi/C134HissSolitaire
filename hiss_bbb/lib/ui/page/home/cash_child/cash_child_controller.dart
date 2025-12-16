import 'package:hiss_bbb/utils/hiss_storage.dart';
import 'package:hiss_root/hiss_ui/hiss_root_controller.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_code.dart';
import 'package:hiss_root/hiss_utils/hiss_event/hiss_event_data.dart';

class CashChildController extends HissRootController{
  var cashType=cashTypeStorage.getData();

  @override
  bool canReceivedEventData()  => true;

  @override
  handleEventBusData(HissEventData data) {
    switch(data.eventCode){
      case HissEventCode.aUpdateMoneyNum:
        update(["money"]);
        break;
    }
  }
}