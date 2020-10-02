import 'package:flutter/cupertino.dart';
import 'package:flutter_live_stream/core/controllers/global_controller.dart';
import 'package:flutter_live_stream/core/services/service_module.dart';

class LiveStreamService extends GetxService{

  // 注入服務
  final signalRService = Get.find<SignalRService>();
  final configService = Get.find<ConfigService>();

  // 建立liveStream連線
  Future initLiveStreamConnection() async {
    print('開始initLiveStreamConnection');

    //liveStream連線區
   return signalRService.liveStreamConnectHub(
      callback: (() {
        print('liveStream連線成功');
        return 'success';
      }),
    );
  }

  // 建立初始化資料監聽
  setupPlayerLobbyConnectListener({@required callback}) async{
    return signalRService.addListener(url: 'livestreamapi', id: 'PlayerLobbyConnect', callback: callback);
  }

  // 送出主播資訊 取得遊戲資訊
  void getAnchorInfo() {
    signalRService.send(url: 'livestreamapi', id: 'PlayerLobbyConnect', msg: {"AnchorId":configService.getFishLiveInfo.AnchorId});
  }

  /// service 初始化
  Future<LiveStreamService> init() async {
    return this;
  }
}
