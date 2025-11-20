import 'package:hiss_root/hiss_utils/hiss_export.dart';

class HissStorageKey{
  static const String aMoney="aMoney";
  static const String aBackPropNum="aBackPropNum";
  static const String aTipsPropNum="aTipsPropNum";
}

StorageData<int> aMoney=StorageData<int>(key: HissStorageKey.aMoney, defaultValue: 0);
StorageData<int> aBackPropNum=StorageData<int>(key: HissStorageKey.aBackPropNum, defaultValue: 0);
StorageData<int> aTipsPropNum=StorageData<int>(key: HissStorageKey.aTipsPropNum, defaultValue: 0);
