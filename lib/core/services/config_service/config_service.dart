import 'package:flutter_live_stream/models/index.dart';

class ConfigService {

  FishLiveGameInfoModel _fishLiveInfo; // 直播的初始資訊

  set setFishLiveInfo(FishLiveGameInfoModel data) {
    _fishLiveInfo = data;
  }

  // 取得登入token (singular用)
  Future<String> getAuthTokenForAsync() async {
    return _fishLiveInfo.Token;
  }
}
