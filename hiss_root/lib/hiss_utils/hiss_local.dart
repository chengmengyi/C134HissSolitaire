import 'dart:io';

import 'package:flutter/foundation.dart';

class HissLocal{
  static const String maxAdKeyBase64="TVdKemhuRVB0S3F4TEtSTEFsVnJUeVFmTzJWeFdaV3RWeF9TelRXQ19NZ29aTDdrVEtOdDl0M01fT2dJWjI0bkJYUlh4VmQ5b2dRRXA3NjE2VFdmM0M=";

  static const _androidIntAdId="a9af74c92e3925ae";
  static const _iosIntAdId="11436a365bfa5635";
  static String intAdId=Platform.isAndroid?_androidIntAdId:_iosIntAdId;

  static const _androidRvAdId="01613654bd67b3e4";
  static const _iosRvAdId="f2b4c129d2be6181";
  static String rvAdId=Platform.isAndroid?_androidRvAdId:_iosRvAdId;

  static const _androidPrivacy="https://sites.google.com/view/privacypolicy134/home";
  static const _iosPrivacy="https://hisssolitairexmaspro.com/privacy/";
  static String privacyUrl=Platform.isAndroid?_androidPrivacy:_iosPrivacy;
}