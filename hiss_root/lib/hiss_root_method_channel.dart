import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'hiss_root_platform_interface.dart';

/// An implementation of [HissRootPlatform] that uses method channels.
class MethodChannelHissRoot extends HissRootPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('hiss_root');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
