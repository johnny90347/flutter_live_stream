import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_live_stream/core/services/system_info_service/system_info_service.dart';
import 'package:flutter_live_stream/pages/live_chat_room/chat_room_feature/center_area/chat_area/chat_input/chat_input.dart';
import 'package:flutter_live_stream/core/controllers/global_controller.dart';
import 'package:flutter_live_stream/core/controllers/live_chat_room_controller.dart';
import 'package:flutter_live_stream/pages/live_chat_room/chat_room_feature/center_area/chat_area/dialog_display/dialog_display.dart';
import 'package:flutter_live_stream/pages/live_chat_room/chat_room_feature/center_area/chat_area/quick_message/quick_message.dart';
import 'package:keyboard_utils/keyboard_listener.dart';
import 'package:keyboard_utils/keyboard_utils.dart';

// 沒有動畫的版本 => 好像比較好
class ChatArea extends StatefulWidget {
  @override
  _ChatAreaState createState() => _ChatAreaState();
}

class _ChatAreaState extends State<ChatArea> {
  final ctr = Get.find<LiveChatRoomController>();
  final systemInfoService = Get.find<SystemInfoService>();
  // 鍵盤監聽實體
  KeyboardUtils _keyboardUtils = KeyboardUtils();
  int _idKeyboardListener;
  double _keyboardPadding; // 鍵盤滑上來的高度高度
  double _chatInputHeight = 40; // 聊天輸入的高,這是死的
  double _shiftDistance = 0;

  @override
  void initState() {
    //起初,輸入框要躲下去畫面
    _shiftDistance = -_chatInputHeight;
    _setUpKeyBoardListener();
    super.initState();
  }

  //監聽鍵盤高度
  _setUpKeyBoardListener() {
    _idKeyboardListener = _keyboardUtils.add(
        listener: KeyboardListener(willHideKeyboard: () {
      _shiftDistance = -_chatInputHeight;
      setState(() {});
    }, willShowKeyboard: (double keyboardHeight) {
      if (_keyboardPadding == null) {
        _keyboardPadding = keyboardHeight - systemInfoService.bottomPanelHeight;
      }
      _shiftDistance = _keyboardPadding;
      setState(() {});
    }));
  }

  @override
  void dispose() {
    // 取消鍵盤監聽
    _keyboardUtils.unsubscribeListener(subscribingId: _idKeyboardListener);
    if (_keyboardUtils.canCallDispose()) {
      _keyboardUtils.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth; // 父層寬
        final maxHeight = constraints.maxHeight; // 父層高
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            // 取消所有焦點
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Container(
            height: maxHeight,
            width: maxWidth,
            child: Stack(
              children: [
                // 照著鍵盤高度 改變位置
                Positioned(
                  bottom: _shiftDistance,
                  // bottom: 0,
                  right: 0,
                  left: 0,
                  top: -_shiftDistance,
                  // top: 0,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 10,
                        child: Container(),
                      ),
                      Expanded(
                        flex: 4,
                        child: DialogDisplay(),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      QuickMessage(), // 快速訊息
                      ChatInput(), // 聊天輸入
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// 有動畫的版本(感覺怪怪的)

//class ChatArea extends StatefulWidget {
//  @override
//  _ChatAreaState createState() => _ChatAreaState();
//}
//
//class _ChatAreaState extends State<ChatArea> {
//  final liveChatRoomController = Get.find<LiveChatRoomController>();
//  // 監聽鍵盤的實體
//  KeyboardVisibilityNotification _keyboardVisibility = new KeyboardVisibilityNotification();
//  int _keyboardVisibilitySubscriberId;
//  double _keyboardHeight = 0; // 鍵盤高度
//
//  @override
//  void initState() {
//    _setKeyboardListener();
//    super.initState();
//  }
//
//  // 設置鍵盤彈出監聽
//  _setKeyboardListener(){
//    _keyboardVisibilitySubscriberId = _keyboardVisibility.addNewListener(
//        onChange: (bool visible){
//          //　鍵盤彈出
//          if(visible){
//            Timer(Duration(milliseconds: 100), () {
//              // 取的鍵盤高度
//              final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
//              // -4 是一開始寫在最外面的padding,不扣了畫,會多一條線(空白)
//              _keyboardHeight = keyboardHeight - liveChatRoomController.bottomPanelHeight - 4;
//              setState(() {
//                // 跑出chatInput
//                liveChatRoomController.openChatInput.value = true;
//              });
//            });
//            //　鍵盤消失
//          }else{
//            // 取消焦點
//            FocusScope.of(context).requestFocus(FocusNode());
//            // 關閉chatInput
//            liveChatRoomController.openChatInput.value = false;
//          }
//        }
//    );
//  }
//
//  @override
//  void dispose() {
//    _keyboardVisibility.removeListener(_keyboardVisibilitySubscriberId);
//    super.dispose();
//  }
//  @override
//  Widget build(BuildContext context) {
//    return LayoutBuilder(builder: (context,constraints){
//      final maxWidth = constraints.maxWidth; // 父層寬
//      final maxHeight = constraints.maxHeight; // 父層高
//      return GestureDetector(
//            behavior: HitTestBehavior.translucent,
//            onTap: (){
//              // 取消所有焦點
//              FocusScope.of(context).requestFocus(FocusNode());
//              // chatInput 隱藏
//              liveChatRoomController.openChatInput.value = false;
//            },
//            child: Container(
//              height: maxHeight,
//              width: maxWidth,
//              child: Stack(
//                children: [
//                  Obx(() =>  AnimatedPositioned(
//                    duration: Duration(milliseconds: 400),
//                    bottom: liveChatRoomController.openChatInput.value ? _keyboardHeight : -maxHeight * 1/16,
//                    // bottom: liveChatRoomController.openChatInput.value ? _keyboardHeight : 0,
//                    right: 0,
//                    left: 0,
//                    top: liveChatRoomController.openChatInput.value ? -_keyboardHeight : maxHeight * 1/16,
//                    // top: liveChatRoomController.openChatInput.value ? -_keyboardHeight : 0,
//                    child: Column(
//                      children: [
//                        Expanded(
//                          flex: 10,
//                          child: Container(
//                            height: 80,
//                            width: 150,
//                            decoration: BoxDecoration(
//                                color: Colors.grey
//                            ),
//                            child: RaisedButton(
//                              onPressed: (){
//
//                              },
//                              child: Text('測試鍵盤'),
//                            ),
//                          ),
//                        ),
//                        Expanded(
//                          flex: 4,
//                          child: Container(
//                            decoration: BoxDecoration(
//                                color: Colors.tealAccent
//                            ),
//                            child: Text('${liveChatRoomController.openChatInput.value}'),
//                          ),
//                        ),
//                        Expanded(
//                          flex: 1,
//                          child: Container(
//                            decoration: BoxDecoration(
//                                color: Colors.blue
//                            ),
//                          ),
//                        ),
//                        Expanded(
//                          flex: 1,
//                          child: ChatInput(),
//                        )],
//                    ),
//                  )
//                  )],
//              ),
//            ),
//          );
//        },
//      );
//  }
//}
