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
  var chatList = RxList<CommonMessageModel>([]); // 聊天內容

  // --主播資訊--
  var anchorCanLike = true.obs;  // 可不可以訂閱
  var anchorFollowCount = 0.obs; // 在線人數
  var anchorLikeCount = 0.obs;
  var anchorName = ''.obs; // 主播英文名字
  var anchorNickName = '载入中'.obs;//主播中文名字
  var anchorStarValue = 0.obs;// 主播人氣值
  // --主播資訊--

  var specialNoticeContent = ''.obs; // 特殊通知的內容(放進來就會出現提示動畫)

  /// 初始化聊天房資訊
  void liveChatRoomInit() async {
    liveStreamService.initLiveStreamConnection(callback: () {
      print('LiveStream連線完成');
      setupPlayerLobbyConnectListener();
      getAnchorInfo();
      setUpLikeAnchorListener();
      setUpUnlikeAnchorListener();
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
      // 這裡,因為一直會持續更新線上人數or人氣值..等,發現如果是更新 anchorLobbyInfo 內的屬性,他的obs不會響應有發生改變,所以只好每個都拿出來
      final anchorInfo = resultMsg.AnchorLobbyInfo;
       anchorCanLike.value = anchorInfo.CanLike;
       anchorFollowCount.value = anchorInfo.FollowCount;
       anchorLikeCount.value = anchorInfo.LikeCount;
       anchorName.value = anchorInfo.Name;
       anchorNickName.value = anchorInfo.NickName;
      anchorStarValue.value = anchorInfo.StarValue;
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

  /// 建立關注主播監聽
  void setUpLikeAnchorListener(){
    liveStreamService.likeAnchorListener(callback: (msg){
      final resultMsg = PlayerLikeModel.fromJson(msg[0]);
      // 更新 人氣值,可關注
      anchorStarValue.value = resultMsg.StarValue;
      anchorLikeCount.value = resultMsg.LikeCount;
      anchorCanLike.value = false;
    });
  }

  /// 建立取消關注主播監聽
  void setUpUnlikeAnchorListener(){
    liveStreamService.unLikeAnchorListener(callback: (msg){
      print('取消關注監聽, $msg');
      final resultMsg = PlayerLikeModel.fromJson(msg[0]);
      // 更新 人氣值,可關注
      anchorStarValue.value = resultMsg.StarValue;
      anchorLikeCount.value = resultMsg.LikeCount;
      anchorCanLike.value = true;
      update();
    });
  }

  /// 送出關注主播
  void sendLikeAnchor(){
    liveStreamService.likeAnchor();
  }

  /// 送出取消關注主播
  void sendUnlikeAnchor(){
    liveStreamService.unLikeAnchor();
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
