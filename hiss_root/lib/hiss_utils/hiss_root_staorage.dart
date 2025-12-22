import 'package:flutter_ios_ad_plugins/hep/ad_num_hep.dart';

StorageData<bool> playBgmKey=StorageData<bool>(key: "playBgmKey", defaultValue: true);
StorageData<bool> playOtherMp3Key=StorageData<bool>(key: "playOtherMp3Key", defaultValue: true);
StorageData<bool> alreadyUploadInstallEvent=StorageData<bool>(key: "alreadyUploadInstallEvent", defaultValue: false);

StorageData<String> hissAdJsonConfig=StorageData<String>(key: "hissAdJsonConfig", defaultValue: "");

StorageData<int> lookAdNum=StorageData<int>(key: "lookAdNum", defaultValue: 0);
StorageData<int> localAdLevelLast=StorageData<int>(key: "localAdLevelLast", defaultValue: 0);
