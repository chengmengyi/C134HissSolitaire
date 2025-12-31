import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_android_ad_plugins/flutter_android_ad_plugins.dart';
import 'package:flutter_check_adjust/dio/dio_hep.dart';
import 'package:flutter_tba_info/flutter_tba_info.dart';
import 'package:hiss_root/hiss_utils/hiss_fk/hiss_fk_config_bean.dart';
import 'package:hiss_root/hiss_utils/hiss_fk/hiss_fk_type.dart';
import 'package:hiss_root/hiss_utils/hiss_local.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_point_enum.dart';
import 'package:hiss_root/hiss_utils/hiss_point/hiss_point_utils.dart';
import 'package:hiss_root/hiss_utils/hiss_root_staorage.dart';
import 'package:hiss_root/hiss_utils/hiss_utils.dart';
import 'package:hissfk/hissfk.dart';

class HissFkUtils{
  static final HissFkUtils _fkUtils=HissFkUtils();
  static HissFkUtils get instance => _fkUtils;

  var _smSuccess=false,_ipSuccess=false;
  HissFkConfigBean? _hissFkConfigBean;

  bool hasFk(){
    var data = hissAlreadyFkLocalTag.getData();
    if(data.isNotEmpty){
      var type = HissFkType.values.byName(data);
      _saveFkTypedjiwjdowj(type);
      return true;
    }
    if(_hissFkConfigBean?.ui?.behavior!=1){
      return false;
    }
    if(_twoRvAdTimeSoSmall()){
      _saveFkTypedjiwjdowj(HissFkType.ad_short_showHissfjffejo);
      return true;
    }
    if(_fromPlayToCloseRvTimeSoSmall()){
      _saveFkTypedjiwjdowj(HissFkType.ad_short_closeHissfjffejo);
      return true;
    }
    if(hissHasMoneyToCashRvAdNumLess3.getData()){
      _saveFkTypedjiwjdowj(HissFkType.wrong_deem_ad_lessHissfjffejo);
      return true;
    }
    if(hissNoMoneyToCashRvAdNumMore90.getData()){
      _saveFkTypedjiwjdowj(HissFkType.wrong_deem_ad_moreHissfjffejo);
      return true;
    }
    return false;
  }

  initFk()async{
    if(_smSuccess&&_ipSuccess){
      return;
    }
    try{
      var data = hissFkConfigStr.getData();
      if(data.isEmpty){
        data=HissLocal.androidFkConfigBase64.base64();
      }
      _hissFkConfigBean=HissFkConfigBean.fromJson(jsonDecode(data));
    }catch(e){
      _hissFkConfigBean=HissFkConfigBean.fromJson(jsonDecode(HissLocal.androidFkConfigBase64.base64()));
    }
    FlutterAndroidAdPlugins.instance.setEverydayWatchAdNum(_hissFkConfigBean?.behavior?.adDailyShow??60);

    //root
    var rofefefeoot = await Hissfk.instance.rootHisswdjowjdo();
    _uploadFfwqdwdwkCustomData({HissFkType.rootHissfjffejo.name:rofefefeoot?1:0});
    if(rofefefeoot&&_hissFkConfigBean?.ui?.device!=0&&_checkDedwdwdvice(HissFkType.rootHissfjffejo)){
      _saveFkTypedjiwjdowj(HissFkType.rootHissfjffejo);
    }

    //vpn
    var vdjodeopn = await Hissfk.instance.vpnHisswdjowjdo();
    _uploadFfwqdwdwkCustomData({HissFkType.vpnHissfjffejo.name:vdjodeopn?1:0});
    if(vdjodeopn&&_hissFkConfigBean?.ui?.device!=0&&_checkDedwdwdvice(HissFkType.vpnHissfjffejo)){
      _saveFkTypedjiwjdowj(HissFkType.vpnHissfjffejo);
    }
    //sim
    var fefmoefkoe = await Hissfk.instance.simHisswdjowjdo();
    _uploadFfwqdwdwkCustomData({HissFkType.simHissfjffejo.name:fefmoefkoe?1:0});
    if(!fefmoefkoe&&_hissFkConfigBean?.ui?.device!=0&&_checkDedwdwdvice(HissFkType.simHissfjffejo)){
      _saveFkTypedjiwjdowj(HissFkType.simHissfjffejo);
    }
    //simulator
    var fefmoefkoeulator = await Hissfk.instance.simulatorHisswdjowjdo();
    _uploadFfwqdwdwkCustomData({HissFkType.simulatorHissfjffejo.name:fefmoefkoeulator?1:0});
    if(fefmoefkoeulator&&_hissFkConfigBean?.ui?.device!=0&&_checkDedwdwdvice(HissFkType.simulatorHissfjffejo)){
      _saveFkTypedjiwjdowj(HissFkType.simulatorHissfjffejo);
    }
    //developer
    var fefefefefegr = await Hissfk.instance.developerHisswdjowjdo();
    _uploadFfwqdwdwkCustomData({HissFkType.developerHissfjffejo.name:fefefefefegr?1:0});
    if(fefefefefegr&&_hissFkConfigBean?.ui?.device!=0&&_checkDedwdwdvice(HissFkType.developerHissfjffejo)){
      _saveFkTypedjiwjdowj(HissFkType.developerHissfjffejo);
    }
    //store
    var gergergregr = await Hissfk.instance.storeHisswdjowjdo();
    _uploadFfwqdwdwkCustomData({HissFkType.googleplayHissfjffejo.name:gergergregr?1:0});
    if(!gergergregr&&_hissFkConfigBean?.ui?.device!=0&&_checkDedwdwdvice(HissFkType.googleplayHissfjffejo)){
      _saveFkTypedjiwjdowj(HissFkType.googleplayHissfjffejo);
    }
    //sm
    var gergerherhr = await Hissfk.instance.getNumberUnitIDHisswdjowjdo();
    var smDioResult = await DioHep.instance.requestPost(
      path: "https://sg-ddi.shuzilm.cn/q",
      data: {"protocol":2,"pkg":await FlutterTbaInfo.instance.getBundleId(),"did":gergerherhr},
    );
    print("kk===sm===${smDioResult.success}===${smDioResult.msg}");
    if(smDioResult.success){
      try{
        _smSuccess=true;
        var json = jsonDecode(smDioResult.msg);
        if(json["err"]==0&&json["device_type"]!=0&&_hissFkConfigBean?.ui?.number==1){
          _saveFkTypedjiwjdowj(HissFkType.numberHissfjffejo);
        }else{

        }
      }catch(e){

      }
    }

    //ip
    var ipDioResult = await DioHep.instance.requestPost(
      path: "https://ip-prod.hisssolitairexmas.com/api/czebra",
      data: {
        "amonkey":await FlutterTbaInfo.instance.getAndroidId(),
      },
    );
    if(ipDioResult.success){
      try{
        _ipSuccess=true;
        var result = decrypt(ipDioResult.msg, 31);
        print("kk===ip===${result}===");
        var bdog = jsonDecode(result)["data"]["bsnake"];
        if(bdog&&_hissFkConfigBean?.ui?.device!=0&&_checkDedwdwdvice(HissFkType.ipHissfjffejo)){
          _saveFkTypedjiwjdowj(HissFkType.numberHissfjffejo);
        }
      }catch(e){}
    }
  }

  test()async{
    //simulator
    var fefmoefkoeulator = await Hissfk.instance.simulatorHisswdjowjdo();
    print("kk===${fefmoefkoeulator}===${_hissFkConfigBean?.ui?.device!=0}====${_checkDedwdwdvice(HissFkType.simulatorHissfjffejo)}");
    // _uploadFfwqdwdwkCustomData({HissFkType.simulatorHissfjffejo.name:fefmoefkoeulator?1:0});
    // if(fefmoefkoeulator&&_hissFkConfigBean?.ui?.device!=0&&_checkDedwdwdvice(HissFkType.simulatorHissfjffejo)){
    //   _saveFkTypedjiwjdowj(HissFkType.simulatorHissfjffejo);
    // }
  }

  _saveFkTypedjiwjdowj(HissFkType tag){
    hissAlreadyFkLocalTag.saveData(tag.name);
    HissPointUtils.instance.pointEvent(hissPointEnum: HissPointEnum.risk_chance,params: {"risk_from":_moveTag(tag)});
  }

  _uploadFfwqdwdwkCustomData(Map<String,dynamic> map){
    HissPointUtils.instance.pointEvent(hissPointEnum: HissPointEnum.session_custom,params: map);
  }

  bool _checkDedwdwdvice(HissFkType tag)=>_hissFkConfigBean?.device?.contains(_moveTag(tag))==true;

  String _moveTag(HissFkType tag)=>tag.name.replaceAll("Hissfjffejo", "");

  bool _twoRvAdTimeSoSmall(){
    var data = hissTwoRvAdTimeSoSmallNumCount.getData();
    var i = getdwjidwAdShortShowHiss()?.value??3;
    return data>=i;
  }

  bool _fromPlayToCloseRvTimeSoSmall(){
    var data = hissFromPlayToCloseRvTimeSoSmallNumCount.getData();
    var i = getAdfwfwShortCloseHIss()?.value??3;
    return data>=i;
  }

  AdShortShow? getdwjidwAdShortShowHiss()=>_hissFkConfigBean?.behavior?.adShortShow;

  AdShortClose? getAdfwfwShortCloseHIss()=>_hissFkConfigBean?.behavior?.adShortClose;

  int getAdsfsdfsLessHiss()=>_hissFkConfigBean?.behavior?.wrongDeemAdLess??3;

  int getAdMffwfworeHIss()=>_hissFkConfigBean?.behavior?.wrongDeemAdMore??90;

  initShumeng(){
    Hissfk.instance.initNumberUnitHisswdjowjdo(apiKey: decrypt(HissLocal.shumengEncryptKey, 134));
  }
}