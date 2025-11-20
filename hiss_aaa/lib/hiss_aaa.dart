
import 'hiss_aaa_platform_interface.dart';

class HissAaa {
  Future<String?> getPlatformVersion() {
    return HissAaaPlatform.instance.getPlatformVersion();
  }
}
