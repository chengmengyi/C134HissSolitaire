import 'package:hiss_root/hiss_utils/hiss_export.dart';

class HissStorageKey{
  static const String bMoney="bMoney";
  static const String bBackPropNum="bBackPropNum";
  static const String bTipsPropNum="bTipsPropNum";
  static const String bLevel="bLevel";
  static const String bDiamondNum="bDiamondNum";
  static const String bMyName="bMyName";
  static const String bMyHead="bMyHead";
  static const String bReceivedRankRewardTime="bReceivedRankRewardTime";
}

StorageData<double> bMoneyNum=StorageData<double>(key: HissStorageKey.bMoney, defaultValue: 0.0);

StorageData<int> bDiamondNum=StorageData<int>(key: HissStorageKey.bDiamondNum, defaultValue: 0);
StorageData<int> bBackPropNum=StorageData<int>(key: HissStorageKey.bBackPropNum, defaultValue: 0);
StorageData<int> bTipsPropNum=StorageData<int>(key: HissStorageKey.bTipsPropNum, defaultValue: 0);
StorageData<int> bLevel=StorageData<int>(key: HissStorageKey.bLevel, defaultValue: 1);

StorageData<String> bMyName=StorageData<String>(key: HissStorageKey.bMyName, defaultValue: "");
StorageData<String> bMyHead=StorageData<String>(key: HissStorageKey.bMyHead, defaultValue: "");
StorageData<String> bReceivedRankRewardTime=StorageData<String>(key: HissStorageKey.bReceivedRankRewardTime, defaultValue: "");
