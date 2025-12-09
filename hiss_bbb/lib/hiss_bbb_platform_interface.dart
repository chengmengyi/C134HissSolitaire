import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'hiss_bbb_method_channel.dart';

abstract class HissBbbPlatform extends PlatformInterface {
  /// Constructs a HissBbbPlatform.
  HissBbbPlatform() : super(token: _token);

  static final Object _token = Object();

  static HissBbbPlatform _instance = MethodChannelHissBbb();

  /// The default instance of [HissBbbPlatform] to use.
  ///
  /// Defaults to [MethodChannelHissBbb].
  static HissBbbPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [HissBbbPlatform] when
  /// they register themselves.
  static set instance(HissBbbPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
