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
  static const String adProbabilityConfig="adProbabilityConfig";
  static const String valueConfig="valueConfig";
  static const String taskQueueConfig="taskQueueConfig";
  static const String bLastUploadMoneyLevel="bLastUploadMoneyLevel";
  static const String notificationGiveReward="notificationGiveReward";
  static const String showGoodComment="showGoodComment";
  static const String showPuzzleGuide="showPuzzleGuide";
  static const String newUser="newUser";
  static const String firstMoveCardToFoundations="firstMoveCardToFoundations";
  static const String firstGetPuzzle="firstGetPuzzle";
}

StorageData<double> bMoneyNum=StorageData<double>(key: HissStorageKey.bMoney, defaultValue: 0.0);
StorageData<double> allMoneyNum=StorageData<double>(key: HissStorageKey.allMoneyNum, defaultValue: 0.0);

StorageData<int> bDiamondNum=StorageData<int>(key: HissStorageKey.bDiamondNum, defaultValue: 0);
StorageData<int> bBackPropNum=StorageData<int>(key: HissStorageKey.bBackPropNum, defaultValue: 0);
StorageData<int> bTipsPropNum=StorageData<int>(key: HissStorageKey.bTipsPropNum, defaultValue: 0);
StorageData<int> bLevel=StorageData<int>(key: HissStorageKey.bLevel, defaultValue: 1);
StorageData<int> wheelNum=StorageData<int>(key: HissStorageKey.wheelNum, defaultValue: 0);
StorageData<int> bLastUploadMoneyLevel=StorageData<int>(key: HissStorageKey.bLastUploadMoneyLevel, defaultValue: 0);

StorageData<String> bMyName=StorageData<String>(key: HissStorageKey.bMyName, defaultValue: "");
StorageData<String> bMyHead=StorageData<String>(key: HissStorageKey.bMyHead, defaultValue: "");
StorageData<String> bReceivedRankRewardTime=StorageData<String>(key: HissStorageKey.bReceivedRankRewardTime, defaultValue: "");
StorageData<String> cashTypeStorage=StorageData<String>(key: HissStorageKey.cashType, defaultValue: HissCashType.paypal);
StorageData<String> adProbabilityConfig=StorageData<String>(key: HissStorageKey.adProbabilityConfig, defaultValue: "");
StorageData<String> valueConfig=StorageData<String>(key: HissStorageKey.valueConfig, defaultValue: "");
StorageData<String> taskQueueConfig=StorageData<String>(key: HissStorageKey.taskQueueConfig, defaultValue: "");

StorageData<bool> show300AnimatorTips=StorageData<bool>(key: HissStorageKey.show300AnimatorTips, defaultValue: true);
StorageData<bool> show700AnimatorTips=StorageData<bool>(key: HissStorageKey.show700AnimatorTips, defaultValue: true);
StorageData<bool> show1000MoneyDialog=StorageData<bool>(key: HissStorageKey.show1000MoneyDialog, defaultValue: true);
StorageData<bool> notificationGiveReward=StorageData<bool>(key: HissStorageKey.notificationGiveReward, defaultValue: true);
StorageData<bool> showGoodComment=StorageData<bool>(key: HissStorageKey.showGoodComment, defaultValue: true);
StorageData<bool> showPuzzleGuide=StorageData<bool>(key: HissStorageKey.showPuzzleGuide, defaultValue: true);
StorageData<bool> newUser=StorageData<bool>(key: HissStorageKey.newUser, defaultValue: true);
StorageData<bool> firstMoveCardToFoundations=StorageData<bool>(key: HissStorageKey.firstMoveCardToFoundations, defaultValue: true);
StorageData<bool> firstGetPuzzle=StorageData<bool>(key: HissStorageKey.firstGetPuzzle, defaultValue: true);
