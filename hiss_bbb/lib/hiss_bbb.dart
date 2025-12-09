
import 'hiss_bbb_platform_interface.dart';

class HissBbb {
  Future<String?> getPlatformVersion() {
    return HissBbbPlatform.instance.getPlatformVersion();
  }
}
