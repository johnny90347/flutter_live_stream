import 'package:flutter/cupertino.dart';
import 'package:flutter_live_stream/core/services/service_module.dart';

class ChatRoomService {

  /// 注入服務
  final signalRService = locator<SignalRService>();

  // 建立chatRoom連線
  Future initChatConnection()async{
    print('開始initChatConnection');
    return signalRService.chatConnectHub(callback: ((){
      print('chat連線成功');
      return 'success';
    }));
  }


  // 建立聊天監聽
  setupChatMessageListener({@required callBack}){
    signalRService.addListener(url: 'chat', id: 'ReceiveChatMessage',callback:callBack );
  }

}