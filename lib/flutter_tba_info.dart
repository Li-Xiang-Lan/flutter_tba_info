import 'package:flutter_tba_info/referrer_observer.dart';

import 'flutter_tba_info_platform_interface.dart';

class FlutterTbaInfo {

  static final FlutterTbaInfo _instance = FlutterTbaInfo();

  static FlutterTbaInfo get instance => _instance;

  Future<String> getDistinctId(){
    return FlutterTbaInfoPlatform.instance.getDistinctId();
  }
  Future<String> getScreenRes(){
    return FlutterTbaInfoPlatform.instance.getScreenRes();
  }
  Future<String> getNetworkType(){
    return FlutterTbaInfoPlatform.instance.getNetworkType();
  }
  Future<String> getZoneOffset(){
    return FlutterTbaInfoPlatform.instance.getZoneOffset();
  }
  Future<String> getGaid(){
    return FlutterTbaInfoPlatform.instance.getGaid();
  }
  Future<String> getAppVersion(){
    return FlutterTbaInfoPlatform.instance.getAppVersion();
  }
  Future<String> getOsVersion(){
    return FlutterTbaInfoPlatform.instance.getOsVersion();
  }
  Future<String> getLogId(){
    return FlutterTbaInfoPlatform.instance.getLogId();
  }
  Future<String> getBrand(){
    return FlutterTbaInfoPlatform.instance.getBrand();
  }
  Future<String> getBundleId(){
    return FlutterTbaInfoPlatform.instance.getBundleId();
  }
  Future<String> getManufacturer(){
    return FlutterTbaInfoPlatform.instance.getManufacturer();
  }
  Future<String> getDeviceModel(){
    return FlutterTbaInfoPlatform.instance.getDeviceModel();
  }
  Future<String> getAndroidId(){
    return FlutterTbaInfoPlatform.instance.getAndroidId();
  }
  Future<String> getSystemLanguage(){
    return FlutterTbaInfoPlatform.instance.getSystemLanguage();
  }
  Future<String> getOsCountry(){
    return FlutterTbaInfoPlatform.instance.getOsCountry();
  }
  Future<String> getOperator(){
    return FlutterTbaInfoPlatform.instance.getOperator();
  }
  Future<String> getDefaultUserAgent(){
    return FlutterTbaInfoPlatform.instance.getDefaultUserAgent();
  }
  Future<String> getIdfa(){
    return FlutterTbaInfoPlatform.instance.getIdfa();
  }
  Future<String> getIdfv(){
    return FlutterTbaInfoPlatform.instance.getIdfv();
  }
  Future<void> jumpToEmail(String email){
    return FlutterTbaInfoPlatform.instance.jumpToEmail(email);
  }
  Future<void> connectReferrer(){
    return FlutterTbaInfoPlatform.instance.connectReferrer();
  }
  Future<void> addReferrerObserver(ReferrerObserver observer) async {
    await FlutterTbaInfoPlatform.instance.addObserver(observer);
  }
}
