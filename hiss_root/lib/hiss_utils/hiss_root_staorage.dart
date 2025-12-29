import 'package:flutter_android_ad_plugins/hep/ad_num_hep.dart';

StorageData<bool> playBgmKey=StorageData<bool>(key: "playBgmKey", defaultValue: true);
StorageData<bool> playOtherMp3Key=StorageData<bool>(key: "playOtherMp3Key", defaultValue: true);
StorageData<bool> alreadyUploadInstallEvent=StorageData<bool>(key: "alreadyUploadInstallEvent", defaultValue: false);

StorageData<String> hissAdJsonConfig=StorageData<String>(key: "hissAdJsonConfig", defaultValue: "");
StorageData<String> hissFkConfigStr=StorageData<String>(key: "hissFkConfigStr", defaultValue: "");
StorageData<String> hissAlreadyFkLocalTag=StorageData<String>(key: "hissAlreadyFkLocalTag", defaultValue: "");

StorageData<int> lookAdNum=StorageData<int>(key: "lookAdNum", defaultValue: 0);
StorageData<int> localAdLevelLast=StorageData<int>(key: "localAdLevelLast", defaultValue: 0);


//上次显示激励广告时间
StorageData<int> hissLastTimeShowRvTime=StorageData<int>(key: "hissLastTimeShowRvTime", defaultValue: 0);
//两次激励广告的时间很小的次数统计
StorageData<int> hissTwoRvAdTimeSoSmallNumCount=StorageData<int>(key: "hissTwoRvAdTimeSoSmallNumCount", defaultValue: 0);

//开始显示激励广告的时间
StorageData<int> hissStartShowRvAdTimer=StorageData<int>(key: "hissStartShowRvAdTimer", defaultValue: 0);
//播放到关闭激励广告的时间小的次数统计
StorageData<int> hissFromPlayToCloseRvTimeSoSmallNumCount=StorageData<int>(key: "hissFromPlayToCloseRvTimeSoSmallNumCount", defaultValue: 0);

//获取激励广告奖励次数
StorageData<int> hissGetTwoRvAdRewardNumCount=StorageData<int>(key: "hissGetTwoRvAdRewardNumCount", defaultValue: 0);

//达到提现门槛，视频次数小于3次，被风控
StorageData<bool> hissHasMoneyToCashRvAdNumLess3=StorageData<bool>(key: "hissHasMoneyToCashRvAdNumLess3", defaultValue: false);
//视频次数大于90次，没有达到提现门槛，被风控
StorageData<bool> hissNoMoneyToCashRvAdNumMore90=StorageData<bool>(key: "hissNoMoneyToCashRvAdNumMore90", defaultValue: false);
