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
  var anchorLobbyInfo = Rx<AnchorLobbyInfoDetailPart>( //主播資訊
    AnchorLobbyInfoDetailPart.fromJson({
      "CanLike": true,
      "FollowCount": 0,
      "LikeCount": 0,
      "Name": '请稍等',
      "NickName": '请稍等',
      "StarValue": 0
    }),
  );
  var chatList = RxList<CommonMessageModel>([]); // 聊天內容

  /// 初始化聊天房資訊
  void liveChatRoomInit() async {
    liveStreamService.initLiveStreamConnection(callback: () {
      print('LiveStream連線完成');
      setupPlayerLobbyConnectListener();
      getAnchorInfo();
    });
    chatRoomService.initChatConnection(callBack: () {
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
      // 禮物只留下簡體名稱
      gifts = resultMsg.Gifts.map((item) {
        item.Name = _giftNameFilter(originName: item.Name);
        return item;
      }).toList();
      videos = resultMsg.Videos;
      anchorLobbyInfo.value = resultMsg.AnchorLobbyInfo;
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
  void sendChatMessage({@required String msg}) {
    chatRoomService.sendMessage(msg);
  }

  /// 取得主播資訊
  void getAnchorInfo() {
    // 讓他晚點才開始拿資料
    Timer(Duration(seconds: 1), () {
      liveStreamService.getAnchorInfo();
    });
  }

  /// 禮物名稱過濾
  String _giftNameFilter({@required String originName}) {
    final strArray = originName.split('#');
    return strArray[0]; // 簡體
  }
}
