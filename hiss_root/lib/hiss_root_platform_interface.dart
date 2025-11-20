import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'hiss_root_method_channel.dart';

abstract class HissRootPlatform extends PlatformInterface {
  /// Constructs a HissRootPlatform.
  HissRootPlatform() : super(token: _token);

  static final Object _token = Object();

  static HissRootPlatform _instance = MethodChannelHissRoot();

  /// The default instance of [HissRootPlatform] to use.
  ///
  /// Defaults to [MethodChannelHissRoot].
  static HissRootPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [HissRootPlatform] when
  /// they register themselves.
  static set instance(HissRootPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
