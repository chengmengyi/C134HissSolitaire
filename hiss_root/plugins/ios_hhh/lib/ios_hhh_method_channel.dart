import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'ios_hhh_platform_interface.dart';

/// An implementation of [IosHhhPlatform] that uses method channels.
class MethodChannelIosHhh extends IosHhhPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('ios_hhh');

  @override
  Future<void> hiss1() async {
    await methodChannel.invokeMethod<String>('hiss1');
  }
  @override
  Future<void> hiss2() async {
    await methodChannel.invokeMethod<String>('hiss2');
  }
  @override
  Future<void> hiss3() async {
    await methodChannel.invokeMethod<String>('hiss3');
  }
  @override
  Future<void> hiss4() async {
    await methodChannel.invokeMethod<String>('hiss4');
  }
}
