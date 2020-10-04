//套件
import 'dart:async';

import 'package:get/get.dart';
export 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_live_stream/core/services/service_module.dart';

import 'package:flutter_live_stream/models/index.dart';

class LiveChatRoomController extends GetxController {
  final liveStreamService = Get.find<LiveStreamService>();
  final chatRoomService = Get.find<ChatRoomService>();


  /// 屬性
  TextEditingController inputController; // 輸入框textField控制器
  FocusNode inputFocusNode; // 輸入框的聚焦
  List<GiftDetailPart> gifts; //禮物列表
  List<VideoDetailPart> videos; //直播影片
  AnchorLobbyInfoDetailPart anchorLobbyInfo; //主播資訊

  var chatList = RxList<CommonMessageModel>([]);

  ///測試資料
  RxList<String> listItems = [
    '這是開頭',
    '主播好',
    '主播棒',
    '安安安安',
    '早安',
    '晚安',
    '吃飯沒',
    '主播好主播好主播好主播好主播好主播好主播好主播好主播好主播好主播好主播好主播好主播好主播好主播好主播好主播好',
    '主播棒',
    '安安安安',
    '早安',
    '晚安',
    '吃飯沒',
    '這是結尾'
  ].obs;

  /// 初始化聊天房資訊
  void liveChatRoomInit() async {
    liveStreamService.initLiveStreamConnection(callback: (){
      print('LiveStream連線完成');
      setupPlayerLobbyConnectListener();
      getAnchorInfo();
    });
    chatRoomService.initChatConnection(callBack: (){
      print('chatRoom連線完成');
      setupChatMessageListener();
    });
    //TODO: 這裡很奇怪,放進去chatRoom連線完成在做,都會來不及拿到她傳過來的資訊
    setUpChatHistoryListener();
  }

  ///建立PlayerLobby 監聽 獲得主播資訊
  void setupPlayerLobbyConnectListener() {
    liveStreamService.setupPlayerLobbyConnectListener(callback: (msg) {
      print('主播資訊$msg');
      // 這裡回來的msg都是list包著
      final resultMsg = PlayerLobbyConnectModel.fromJson(msg[0]);
      gifts = resultMsg.Gifts;
      videos = resultMsg.Videos;
      anchorLobbyInfo = resultMsg.AnchorLobbyInfo;
    });
  }

  ///  第一次載入時取得最新幾筆歷史紀錄
  void setUpChatHistoryListener() {
    chatRoomService.setUpChatHistoryListener(callBack: (msg) {
      final historyList = msg[0] as List;
      print(msg);
      for (var history in historyList) {
        final resultMsg = CommonMessageModel.fromJson(history);
        chatList.add(resultMsg);
      }
    });
  }

  /// 建立聊天監聽
  void setupChatMessageListener() {
    chatRoomService.setupChatMessageListener(callBack: (msg) {
      final resultMsg = CommonMessageModel.fromJson(msg[0]);
      chatList.add(resultMsg);
    });
  }

  /// 發送聊天訊息
  void sendChatMessage({@required String msg}){
    chatRoomService.sendMessage(msg);
    
  }

  /// 取得主播資訊
  void getAnchorInfo() {
    // 讓他晚點才開始拿資料
    Timer(Duration(seconds: 1), (){
      liveStreamService.getAnchorInfo();
    });
  }
}
