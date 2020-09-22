import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_live_stream/core/services/network_service/signalr_service.dart';
import 'package:flutter_live_stream/core/services/network_service/http_service.dart';
import 'package:flutter_live_stream/core/services/service_module.dart';
import 'package:flutter_live_stream/models/fishLiveGameInfoModel.dart';
import 'package:flutter_live_stream/models/index.dart';

class GlobalState {
  // 測試用資料
  int _myNumber = 0;

  int get getNumber => _myNumber;

  void addNumber() {
    _myNumber++;
    print(_myNumber);
  }
  // 測試用資料





  /// 注入服務
  final httpService = locator<HttpService>();
  final signalRService = locator<SignalRService>();
  final configService = locator<ConfigService>();

  /// 屬性



  /// 方法

  // 取得直播所需資訊
  getLiveStreamInitInfo() async {
    // 依序處理
    final LoginInfoModel loginInfoResp = await _getLoginInfo();
    await _getFishLiveGameInfo(loginInfo: loginInfoResp);
    _initSignalRConnection();
    print('結束');
  }

  // 取得玩家登入資訊(第一步)
  Future _getLoginInfo() async {
    return httpService
        .httpGet(url: 'api/games/fish/demo/$USER_NAME')
        .then((resp) {
      print('getLoginInfo:$resp');
      final LoginInfoModel serializationResp = LoginInfoModel.fromJson(resp);
      if (serializationResp.Code == 0) {
        return serializationResp;
      }
    });
  }

  // 取得直播初始資訊(第二步)- 用此token去建立連線
  Future _getFishLiveGameInfo({@required LoginInfoModel loginInfo}) async {
    final canUseRoutePath = ROUTE_PATH.replaceAll('/', '%2F');
    final query = '?token=${loginInfo.Token}' +
        '&username=$USER_NAME' + // 在httpService
        '&pid=' +
        loginInfo.Pid +
        '&lobbyUrl=$canUseRoutePath' + // 在httpService
        '&currency=${loginInfo.Currency}' +
        '&lang=${loginInfo.Lang}' +
        '&anchorId=${loginInfo.AnchorId}' +
        '&userFlag=${loginInfo.UserFlag}' +
        '&level=${loginInfo.Level}';
    return httpService.httpGet(url: 'api/games/fish$query').then((resp) {
      print('getFishLiveGameInfo$resp');
      configService.setFishLiveInfo = FishLiveGameInfoModel.fromJson(resp);
    });
  }

  //建立SignalR連線
  _initSignalRConnection(){
    signalRService.liveStreamConnectHub(callback: (() => {print('liveStream連線成功')}));
    signalRService.chatConnectHub(callback: (() => {print('chat連線成功')}));
  }


}
