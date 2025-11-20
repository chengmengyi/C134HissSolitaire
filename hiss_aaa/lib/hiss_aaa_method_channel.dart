import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'hiss_aaa_platform_interface.dart';

/// An implementation of [HissAaaPlatform] that uses method channels.
class MethodChannelHissAaa extends HissAaaPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('hiss_aaa');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
