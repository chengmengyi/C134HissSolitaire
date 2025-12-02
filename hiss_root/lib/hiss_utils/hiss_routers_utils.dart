import 'package:flutter/material.dart';

import 'hiss_export.dart';

class HissCommonRouters{
  static const String hissMain="/common/hissMain";
  static const String hissUrl="/common/hissUrl";
}


class HissRoutersUtils{
  static final HissRoutersUtils _aaaRouters=HissRoutersUtils();
  static HissRoutersUtils get instance => _aaaRouters;

  toNextPageByNamed({
    required String routerName,
    Map<String, dynamic>? params,
  }){
    Get.toNamed(routerName,arguments: params);
  }

  toNextPageCloseCurrentPage({
    required String routerName,
    Map<String, dynamic>? params,
  }){
    Get.offNamed(routerName,arguments: params);
  }

  toNextPageCloseAllPage({
    required String routerName,
    Map<String, dynamic>? params,
  }){
    Get.offAllNamed(routerName,arguments: params);
  }

  close(){
    Get.back();
  }

  closeAllPageUntilNamed({required String str}){
    Get.until((route)=>route.settings.name==str);
  }

  Map<String, dynamic> getParams(){
    try {
      return Get.arguments as Map<String, dynamic>;
    } catch (e) {
      return {};
    }
  }

  showDialog({
    required Widget child,
  }){
    Get.dialog(
      child,
      barrierColor: Colors.black.withOpacity(0.8),
      barrierDismissible: false,
    );
  }

  toWeb({
    required String title,
    required String url,
  }){
    toNextPageByNamed(routerName: HissCommonRouters.hissUrl,params: {"title":title,"url":url});
  }
}