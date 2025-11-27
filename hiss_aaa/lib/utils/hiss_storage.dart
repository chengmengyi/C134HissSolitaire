import 'package:hiss_root/hiss_utils/hiss_export.dart';

class HissStorageKey{
  static const String aMoney="aMoney";
  static const String aBackPropNum="aBackPropNum";
  static const String aTipsPropNum="aTipsPropNum";
  static const String aLevel="aLevel";
  static const String aDiamondNum="aDiamondNum";
  static const String aMyName="aMyName";
  static const String aMyHead="aMyHead";
  static const String aReceivedRankRewardTime="aReceivedRankRewardTime";
}

StorageData<int> aMoneyNum=StorageData<int>(key: HissStorageKey.aMoney, defaultValue: 0);
StorageData<int> aDiamondNum=StorageData<int>(key: HissStorageKey.aDiamondNum, defaultValue: 0);
StorageData<int> aBackPropNum=StorageData<int>(key: HissStorageKey.aBackPropNum, defaultValue: 0);
StorageData<int> aTipsPropNum=StorageData<int>(key: HissStorageKey.aTipsPropNum, defaultValue: 0);
StorageData<int> aLevel=StorageData<int>(key: HissStorageKey.aLevel, defaultValue: 1);

StorageData<String> aMyName=StorageData<String>(key: HissStorageKey.aMyName, defaultValue: "");
StorageData<String> aMyHead=StorageData<String>(key: HissStorageKey.aMyHead, defaultValue: "");
StorageData<String> aReceivedRankRewardTime=StorageData<String>(key: HissStorageKey.aReceivedRankRewardTime, defaultValue: "");
