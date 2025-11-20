import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'hiss_aaa_method_channel.dart';

abstract class HissAaaPlatform extends PlatformInterface {
  /// Constructs a HissAaaPlatform.
  HissAaaPlatform() : super(token: _token);

  static final Object _token = Object();

  static HissAaaPlatform _instance = MethodChannelHissAaa();

  /// The default instance of [HissAaaPlatform] to use.
  ///
  /// Defaults to [MethodChannelHissAaa].
  static HissAaaPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [HissAaaPlatform] when
  /// they register themselves.
  static set instance(HissAaaPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
