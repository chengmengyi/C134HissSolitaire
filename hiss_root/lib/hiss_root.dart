
import 'hiss_root_platform_interface.dart';

class HissRoot {
  Future<String?> getPlatformVersion() {
    return HissRootPlatform.instance.getPlatformVersion();
  }
}
