import 'package:flutter/cupertino.dart';
import 'package:flutter_live_stream/core/controllers/global_controller.dart';
import 'package:flutter_live_stream/core/services/service_module.dart';

class LiveStreamService extends GetxService{

  /// 注入服務
  final signalRService = Get.find<SignalRService>();
  final configService = Get.find<ConfigService>();

  /// 建立liveStream連線
  void initLiveStreamConnection({@required callback}){
    print('開始initLiveStreamConnection');
    //liveStream連線區
    signalRService.liveStreamConnectHub(
      callback: callback,
    );
  }

  /// 建立初始化資料監聽
  setupPlayerLobbyConnectListener({@required callback}){
    return signalRService.addListener(url: 'livestreamapi', id: 'PlayerLobbyConnect', callback: callback);
  }

  /// 送出主播資訊 取得遊戲資訊
  void getAnchorInfo() {
    signalRService.send(url: 'livestreamapi', id: 'PlayerLobbyConnect', msg: {"AnchorId":configService.getFishLiveInfo.AnchorId});
  }

  /// 關注主播監聽
  void likeAnchorListener({@required callback}){
    return signalRService.addListener(url: 'livestreamapi', id: 'PlayerLike', callback: callback);
  }

  /// 取消關注主播監聽
  void unLikeAnchorListener({@required callback}){
    return signalRService.addListener(url: 'livestreamapi', id: 'PlayerUnlike', callback: callback);
  }

  /// 送禮是否成功監聽
  void playerSendGiftListener({@required callback}){
    return signalRService.addListener(url: 'livestreamapi', id: 'PlayerSendGift', callback: callback);
  }

  /// 送出關注主播
  void likeAnchor(){
    signalRService.send(url: 'livestreamapi', id: 'PlayerLike', msg:null);
  }

  /// 送出取消關注主播
  void unLikeAnchor(){
    signalRService.send(url: 'livestreamapi', id: 'PlayerUnlike', msg:null);
  }

  /// 送出禮物(參數:禮物id,禮物value)
  void sendGift({@required int giftId,@required int giftValue}){
    final paramObj = {
      "GiftId":giftId,
      "GiftValue":giftValue
    };
    signalRService.send(url: 'livestreamapi', id: 'PlayerSendGift', msg:paramObj);
  }

  /// service 初始化
  Future<LiveStreamService> init() async {
    return this;
  }
}
