import 'package:hiss_root/hiss_utils/hiss_export.dart';

class HissStorageKey{
  static const String aMoney="aMoney";
}

StorageData<int> aMoney=StorageData<int>(key: HissStorageKey.aMoney, defaultValue: 0);
