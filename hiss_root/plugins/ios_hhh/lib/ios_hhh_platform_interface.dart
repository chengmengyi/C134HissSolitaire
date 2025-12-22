import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'ios_hhh_method_channel.dart';

abstract class IosHhhPlatform extends PlatformInterface {
  /// Constructs a IosHhhPlatform.
  IosHhhPlatform() : super(token: _token);

  static final Object _token = Object();

  static IosHhhPlatform _instance = MethodChannelIosHhh();

  /// The default instance of [IosHhhPlatform] to use.
  ///
  /// Defaults to [MethodChannelIosHhh].
  static IosHhhPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [IosHhhPlatform] when
  /// they register themselves.
  static set instance(IosHhhPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> hiss1() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
  Future<void> hiss2() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
  Future<void> hiss3() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
  Future<void> hiss4() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
