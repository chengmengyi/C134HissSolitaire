import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'hiss_bbb_platform_interface.dart';

/// An implementation of [HissBbbPlatform] that uses method channels.
class MethodChannelHissBbb extends HissBbbPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('hiss_bbb');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
