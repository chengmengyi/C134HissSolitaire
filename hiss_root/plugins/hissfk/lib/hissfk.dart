import 'package:flutter/services.dart';

final class Hissfk {
  static final Hissfk instance = Hissfk._internal();

  Hissfk._internal();

  final _methodChannel = const MethodChannel('hissfk');

  //设备是否被Root
  Future<bool> rootHisswdjowjdo() async {
    return (await _methodChannel.invokeMethod("rootHisswdjowjdo")) == true;
  }

  //是否连接VPN网络
  Future<bool> vpnHisswdjowjdo() async {
    return (await _methodChannel.invokeMethod("vpnHisswdjowjdo")) == true;
  }

  //设备是否有可用的sim卡
  Future<bool> simHisswdjowjdo() async {
    return (await _methodChannel.invokeMethod("simHisswdjowjdo")) == true;
  }

  //设备是否为模拟器
  Future<bool> simulatorHisswdjowjdo() async {
    return (await _methodChannel.invokeMethod("simulatorHisswdjowjdo")) == true;
  }

  //应用是否安装自Google play store
  Future<bool> storeHisswdjowjdo() async {
    return (await _methodChannel.invokeMethod("storeHisswdjowjdo")) == true;
  }

  //设备是否启用开发者模式
  Future<bool> developerHisswdjowjdo() async {
    return (await _methodChannel.invokeMethod("developerHisswdjowjdo")) == true;
  }

  //安装应用的安装器程序的包名
  Future<String> installerHisswdjowjdo() async {
    return await _methodChannel.invokeMethod("installerHisswdjowjdo");
  }

  //初始化数盟平台
  Future<void> initNumberUnitHisswdjowjdo({required String apiKey}) async {
    await _methodChannel.invokeMethod("initNumberUnitHisswdjowjdo", apiKey);
  }

  //从数盟平台读取数盟可信ID，对应文档请求参数：did
  Future<String> getNumberUnitIDHisswdjowjdo({String channel = "", String message = ""}) async {
    return (await _methodChannel.invokeMethod("getNumberUnitIDHisswdjowjdo", {
          "channel": channel,
          "message": message,
        })) ??
        "";
  }
}
