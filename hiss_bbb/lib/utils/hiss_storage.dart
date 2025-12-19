import 'package:hiss_bbb/utils/hiss_enum/hiss_cash_type.dart';
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
  static const String cashType="cashType";
  static const String show300AnimatorTips="show300AnimatorTips";
  static const String show700AnimatorTips="show700AnimatorTips";
  static const String show1000MoneyDialog="show1000MoneyDialog";
  static const String wheelNum="wheelNum";
  static const String allMoneyNum="allMoneyNum";
}

StorageData<double> bMoneyNum=StorageData<double>(key: HissStorageKey.bMoney, defaultValue: 0.0);
StorageData<double> allMoneyNum=StorageData<double>(key: HissStorageKey.allMoneyNum, defaultValue: 0.0);

StorageData<int> bDiamondNum=StorageData<int>(key: HissStorageKey.bDiamondNum, defaultValue: 0);
StorageData<int> bBackPropNum=StorageData<int>(key: HissStorageKey.bBackPropNum, defaultValue: 0);
StorageData<int> bTipsPropNum=StorageData<int>(key: HissStorageKey.bTipsPropNum, defaultValue: 0);
StorageData<int> bLevel=StorageData<int>(key: HissStorageKey.bLevel, defaultValue: 1);
StorageData<int> wheelNum=StorageData<int>(key: HissStorageKey.wheelNum, defaultValue: 0);

StorageData<String> bMyName=StorageData<String>(key: HissStorageKey.bMyName, defaultValue: "");
StorageData<String> bMyHead=StorageData<String>(key: HissStorageKey.bMyHead, defaultValue: "");
StorageData<String> bReceivedRankRewardTime=StorageData<String>(key: HissStorageKey.bReceivedRankRewardTime, defaultValue: "");
StorageData<String> cashTypeStorage=StorageData<String>(key: HissStorageKey.cashType, defaultValue: HissCashType.paypal);

StorageData<bool> show300AnimatorTips=StorageData<bool>(key: HissStorageKey.show300AnimatorTips, defaultValue: true);
StorageData<bool> show700AnimatorTips=StorageData<bool>(key: HissStorageKey.show700AnimatorTips, defaultValue: true);
StorageData<bool> show1000MoneyDialog=StorageData<bool>(key: HissStorageKey.show1000MoneyDialog, defaultValue: true);
