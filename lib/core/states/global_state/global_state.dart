import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_live_stream/core/services/service_module.dart';
import 'package:flutter_live_stream/models/index.dart';

class GlobalState {
  int _myNumber = 0;

  int get getNumber => _myNumber;

  void addNumber() {
    _myNumber++;
    print(_myNumber);
  }

  // 注入服務
  final httpService = locator<HttpService>();


  /// 取得直播所需資訊
  getLiveStreamInitInfo() async {
    // 依序處理
  final LoginInfoModel loginInfoResp =  await getLoginInfo();
  await getFishLiveGameInfo(loginInfo: loginInfoResp);
  print('結束');
  }

  /// 取得玩家登入資訊(第一步)
  Future getLoginInfo() async{
    return httpService.httpGet(url: 'api/games/fish/demo/$USER_NAME').then((resp){
      print(resp);
      final LoginInfoModel serializationResp = LoginInfoModel.fromJson(resp);
      if (serializationResp.Code == 0) {
        return serializationResp;
      }
    });
  }

  
  /// 取得直播初始資訊(第二步)
  Future getFishLiveGameInfo({@required LoginInfoModel loginInfo}) async {
    final canUseRoutePath = ROUTE_PATH.replaceAll('/', '%2F');
    final query = '?token=${loginInfo.Token}'+
        '&username=$USER_NAME'+ // 在httpService
        '&pid=' + loginInfo.Pid +
        '&lobbyUrl=$canUseRoutePath'+ // 在httpService
        '&currency=${loginInfo.Currency}'+
        '&lang=${loginInfo.Lang}'+
        '&anchorId=${loginInfo.AnchorId}'+
        '&userFlag=${loginInfo.UserFlag}'+
        '&level=${loginInfo.Level}';
    print('api/games/fish$query');
    return httpService.httpGet(url: 'api/games/fish$query').then((resp){
      print(resp);
    });

  }
}
