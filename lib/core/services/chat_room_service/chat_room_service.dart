import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_live_stream/core/controllers/global_controller.dart';
import 'package:flutter_live_stream/core/services/service_module.dart';

class ChatRoomService extends GetxService {
  /// 注入服務
  final signalRService = Get.find<SignalRService>();

  /// 建立chatRoom連線
  void initChatConnection({@required callBack}){
     signalRService.chatConnectHub(callback: callBack);
  }

  /// 建立聊天監聽
  setupChatMessageListener({@required callBack}){
    signalRService.addListener(url: 'chat', id: 'ReceiveChatMessage',callback:callBack );
  }


  /// 第一次載入時取得最新幾筆歷史紀錄
  setUpChatHistoryListener({@required callBack}){
    signalRService.addListener(url: 'chat', id: 'ChatHistory',callback:callBack );
  }

  /// 發送聊天訊息
  sendMessage(msg) {
    final message = {
    "Body": msg
    };
    signalRService.send(url: 'chat',id: 'SendMessage',msg: message);
  }

  /// service 初始化
  Future<ChatRoomService> init() async {
    return this;
  }

}