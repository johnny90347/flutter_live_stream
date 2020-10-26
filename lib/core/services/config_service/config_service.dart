import 'package:flutter/cupertino.dart';
import 'package:flutter_live_stream/core/controllers/global_controller.dart';
import 'package:flutter_live_stream/core/services/service_module.dart';
import 'package:flutter_live_stream/models/fishLiveGameInfoModel.dart';
import 'package:flutter_live_stream/models/index.dart';

class ConfigService extends GetxService {
  FishLiveGameInfoModel _fishLiveInfo; // 直播的初始資訊
  FishLiveGameInfoModel get getFishLiveInfo => _fishLiveInfo; // 取得直播的初始資訊
  String cdnUrl; // cdn的url

  /// 取得登入token (singular用)
  Future<String> getAuthTokenForAsync() async {
    return _fishLiveInfo.Token;
  }

  /// 注入服務
  final httpService = Get.find<HttpService>();
  final routeService = Get.find<RouterService>();

  /// 初始化連線前該有的資料
  Future initConfig() async {
    final LoginInfoModel loginInfoResp = await _getLoginInfo();
    await _getFishLiveGameInfo(loginInfo: loginInfoResp);
    await _getCdnUrl();
    return 'success';
  }

  /// 取得玩家登入資訊(第一步)
  Future _getLoginInfo() async {
    return httpService
        .httpGet(url: 'api/games/fish/demo/$USER_NAME')
        .then((resp) {
      // code != 0 導向錯誤頁
      if (resp["Code"] != 0) {
        routeService.goToPage(path: errorPath, argument: resp["Message"]);
      }

      print('getLoginInfo: $resp');

      final LoginInfoModel serializationResp = LoginInfoModel.fromJson(resp);
      if (serializationResp.Code == 0) {
        return serializationResp;
      }
    });
  }

  /// 取得直播初始資訊(第二步)- 用此token去建立連線
  Future _getFishLiveGameInfo({@required LoginInfoModel loginInfo}) async {
    const loginToken = ''; // 在UAT區,有個input但不用輸入的那個東西
    final lobbyEnCodeUrl = Uri.encodeComponent('${ROUTE_PATH}demo');
    final originEenCodeUrl = Uri.encodeComponent(loginInfo.Origin);

    final query = '?token=${loginInfo.Token}' +
        '&username=$USER_NAME' + // 在httpService
        '&pid=${loginInfo.Pid}' +
        '&lobbyUrl=$lobbyEnCodeUrl' + // 在httpService
        '&currency=${loginInfo.Currency}' +
        '&lang=${loginInfo.Lang}' +
        '&anchorId=${loginInfo.AnchorId}' +
        '&userFlag=${loginInfo.UserFlag}' +
        '&level=${loginInfo.Level}' +
        '&src_platform=${loginInfo.SrcPlatform}' +
        '&tss=$loginToken' +
        '&origin=$originEenCodeUrl';
    print(query);
    return httpService.httpGet(url: 'api/games/fish$query').then((resp) {
      print('getFishLiveGameInfo$resp');
      _fishLiveInfo = FishLiveGameInfoModel.fromJson(resp);
    });
  }

  /// 取得CDN url
  Future _getCdnUrl() {
    return httpService.httpGet(url: '/api/config').then((resp) {
      print('CDN: $resp');
      cdnUrl = resp["CdnPath"];
    });
  }

  /// service 初始化
  Future<ConfigService> init() async {
    return this;
  }
}
