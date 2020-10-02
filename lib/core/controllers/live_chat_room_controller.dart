//套件
import 'package:get/get.dart';
export 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_live_stream/core/services/service_module.dart';

import 'package:flutter_live_stream/models/index.dart';

class LiveChatRoomController extends GetxController {
  final liveStreamService = Get.find<LiveStreamService>();
  final chatRoomService = Get.find<ChatRoomService>();

  /// 系統資料
  double bottomPanelHeight; // 底部按鈕的高
  RxBool openChatInput = false.obs; //開啟聊天輸入框
  /// 屬性
  TextEditingController inputController; // 輸入框textField控制器
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
    await liveStreamService.initLiveStreamConnection();
    await chatRoomService.initChatConnection();
    setUpChatHistoryListener();
    setupPlayerLobbyConnectListener();
    setupChatMessageListener();
    getAnchorInfo();
  }

  ///建立PlayerLobby 監聽 獲得主播資訊
  void setupPlayerLobbyConnectListener() {
    liveStreamService.setupPlayerLobbyConnectListener(callback: (msg) {
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

  /// 取得主播資訊
  void getAnchorInfo() {
    liveStreamService.getAnchorInfo();
  }
}
