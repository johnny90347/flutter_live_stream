import 'package:flutter/cupertino.dart';
import 'package:flutter_live_stream/core/controllers/global_controller.dart';
import 'package:signalr_core/signalr_core.dart';
import 'package:flutter_live_stream/core/services/service_module.dart';

class SignalRService extends GetxService {
  /// 注入
  final configService = Get.find<ConfigService>();

  /// 屬性
  HubConnection liveStreamApiConnect; // liveStream連線
  HubConnection chatConnect; // chat連線

  /// 方法
  // 設置liveStream連線
  void liveStreamConnectHub({@required dynamic callback}) async {
    liveStreamApiConnect = HubConnectionBuilder()
        .withUrl(
            '${ROUTE_PATH}livestreamapi',
            HttpConnectionOptions(
              accessTokenFactory: configService.getAuthTokenForAsync,
              logging: (level, message) => print(message),
            ))
        .build();
    return liveStreamApiConnect.start().then((value) {
      callback();
    });
  }

  // 設置chat連線
  void chatConnectHub({@required dynamic callback}) async {
    chatConnect = HubConnectionBuilder()
        .withUrl(
            '${ROUTE_PATH}chat',
            HttpConnectionOptions(
              accessTokenFactory: configService.getAuthTokenForAsync,
              logging: (level, message) => print(message),
            ))
        .build();
    return chatConnect.start().then((value) {
      callback();
    });
  }

  // 建立監聽
  void addListener(
      {@required String url, @required String id, @required dynamic callback}) {
    final HubConnection connection = _getListenConnection(url: url);
    connection.on(id, callback);
  }

  //送出訊息
  void send(
      {@required String url, @required String id, @required dynamic msg}) {
    final HubConnection connection = _getListenConnection(url: url);
    if (msg == null) {
      connection.invoke(id);
    } else {
      connection.invoke(id, args: [msg]);
    }
  }

  // 取得監聽類型
  HubConnection _getListenConnection({@required String url}) {
    switch (url) {
      case 'livestreamapi':
        return liveStreamApiConnect;
      case 'chat':
        return chatConnect;
      default:
        return null;
    }
  }

  /// service 初始化
  Future<SignalRService> init() async {
    return this;
  }
}
