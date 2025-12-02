import 'dart:io';

import 'package:flutter/foundation.dart';

class HissLocal{
  static const String maxAdKeyBase64="TVdKemhuRVB0S3F4TEtSTEFsVnJUeVFmTzJWeFdaV3RWeF9TelRXQ19NZ29aTDdrVEtOdDl0M01fT2dJWjI0bkJYUlh4VmQ5b2dRRXA3NjE2VFdmM0M=";

  static const _debugIntAdId="489dde1c1bbc42f0";
  static const _releaseIntAdId="a9af74c92e3925ae";
  static String intAdId=Platform.isAndroid&&kDebugMode?_debugIntAdId:_releaseIntAdId;

  static const _debugRvAdId="40e34dd7e0600c84";
  static const _releaseRvAdId="01613654bd67b3e4";
  static String rvAdId=Platform.isAndroid&&kDebugMode?_debugRvAdId:_releaseRvAdId;

  static const _debugPrivacy="https://www.baidu.com";
  static const _releasePrivacy="";
  static String privacyUrl=Platform.isAndroid&&kDebugMode?_debugPrivacy:_releasePrivacy;
}