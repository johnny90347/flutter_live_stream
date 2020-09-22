import 'package:flutter/cupertino.dart';
import 'package:signalr_core/signalr_core.dart';
import 'package:flutter_live_stream/core/services/service_module.dart';

class SignalRService {
  /// 注入
  final configService = locator<ConfigService>();

  /// 屬性
  HubConnection liveStreamApiConnect; // liveStream連線
  HubConnection chatConnect; // chat連線

  /// 方法
  // 設置liveStream連線
  Future liveStreamConnectHub({@required dynamic callback}) async {
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
  Future chatConnectHub({@required dynamic callback}) async {
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

//  connection.on('ReceiveMessage', (message) {
//  print(message.toString());
//  });

}
