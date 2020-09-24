import 'package:flutter/cupertino.dart';
import 'package:flutter_live_stream/core/services/service_module.dart';
import 'package:flutter_live_stream/models/fishLiveGameInfoModel.dart';
import 'package:flutter_live_stream/models/index.dart';

class ConfigService {

  FishLiveGameInfoModel _fishLiveInfo; // 直播的初始資訊

  FishLiveGameInfoModel get getFishLiveInfo => _fishLiveInfo;

  // 取得登入token (singular用)
  Future<String> getAuthTokenForAsync() async {
    return _fishLiveInfo.Token;
  }

  /// 注入服務
  final httpService = locator<HttpService>();
  final routeService = locator<RouterService>();

  // 初始化連線前該有的資料
    Future initConfig()async{
      final LoginInfoModel loginInfoResp = await _getLoginInfo();
      await _getFishLiveGameInfo(loginInfo: loginInfoResp);
      print('CinfigInit 完成');
      return 'success';
  }

  // 取得玩家登入資訊(第一步)
  Future _getLoginInfo() async {
    return httpService
        .httpGet(url: 'api/games/fish/demo/$USER_NAME')
        .then((resp) {

      // code != 0 導向錯誤頁
      if(resp["code"] != 0 ){
        routeService.goToPage(path: errorPath,argument: resp["Message"]);
      }

      print('getLoginInfo: $resp');

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
      _fishLiveInfo = FishLiveGameInfoModel.fromJson(resp);
    });
  }

}



