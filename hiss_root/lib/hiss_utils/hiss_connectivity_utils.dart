import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hiss_root/hiss_utils/hiss_ad_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_check_user_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_firebase_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_point_utils.dart';

class HissConnectivityUtils{
  static final HissConnectivityUtils _connectivityUtils=HissConnectivityUtils();
  static HissConnectivityUtils get instance=>_connectivityUtils;

  StreamSubscription<List<ConnectivityResult>>? _subscription;

  initConnectivity(){
    _subscription = Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result) {
      if(result.contains(ConnectivityResult.wifi)||result.contains(ConnectivityResult.mobile)){
        _subscription?.cancel();
        _subscription=null;
        HissPointUtils.instance.installEvent();
        HissPointUtils.instance.sessionEvent();
        HissCheckUserUtils.instance.initCheck();
        HissFirebaseUtils.instance.initFirebase();
        HissAdUtils.instance.initAd();
      }
    });
  }
}