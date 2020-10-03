import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_live_stream/core/services/system_info_service/system_info_service.dart';
import 'package:flutter_live_stream/pages/live_chat_room/chat_room_feature/center_area/chat_area/chat_input/chat_input.dart';
import 'package:flutter_live_stream/core/controllers/global_controller.dart';
import 'package:flutter_live_stream/core/controllers/live_chat_room_controller.dart';
import 'package:flutter_live_stream/pages/live_chat_room/chat_room_feature/center_area/chat_area/dialog_display/dialog_display.dart';
import 'package:flutter_live_stream/pages/live_chat_room/chat_room_feature/center_area/chat_area/quick_message/quick_message.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

// 沒有動畫的版本 => 好像比較好
class ChatArea extends StatefulWidget {
  @override
  _ChatAreaState createState() => _ChatAreaState();
}

class _ChatAreaState extends State<ChatArea>
    with SingleTickerProviderStateMixin {
  final ctr = Get.find<LiveChatRoomController>();
  final systemInfoService = Get.find<SystemInfoService>();
  // 監聽鍵盤的實體
  KeyboardVisibilityNotification _keyboardVisibility =
      new KeyboardVisibilityNotification();
  int _keyboardVisibilitySubscriberId;
  double _keyboardHeight = 0; // 鍵盤高度
  double _chatInputHeight = 40; // 聊天輸入的高,這是死的
  double _opacity = 1; // 切換高度時的透明度
  int _opacityDuration = 0; // 透明度的動畫時間 (點擊下去馬上消失)
  bool _canStartListen = false; // 監聽第一次會先傳預設值過來,但我不要


  @override
  void initState() {
    _setKeyboardListener();
    _setupOpacityWithChane();
    super.initState();
  }

  // 設置鍵盤彈出監聽
  _setKeyboardListener() {
    _keyboardVisibilitySubscriberId =
        _keyboardVisibility.addNewListener(onChange: (bool visible) {
      //　鍵盤彈出
      if (visible) {
        Timer(Duration(milliseconds: 500), () {
          // 取的鍵盤高度
          final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
          _keyboardHeight = keyboardHeight - systemInfoService.bottomPanelHeight;
          setState(() {});
        });
        //　鍵盤消失
      } else {
        // 取消焦點
        FocusScope.of(context).requestFocus(FocusNode());
        // 關閉chatInput
        ctr.openChatInput.value = false;
      }
    });
  }

  // 設定切換高度時,有透明動畫
  _setupOpacityWithChane() {
    ctr.openChatInput.listen((value) {
      // 第一筆資料忽略
      if(!_canStartListen){
        _canStartListen =true;
        return;
      }

      // 馬上先變透明
      _opacityDuration = 0;
      setState(() {
        _opacity = 0;
      });
      // 300毫秒後 漸變還原
      Timer(Duration(milliseconds: 200), () {
        _opacityDuration = 200;
        setState(() {
          _opacity = 1;
        });
      });
    });
  }

  @override
  void dispose() {
    _keyboardVisibility.removeListener(_keyboardVisibilitySubscriberId);
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
            // chatInput 隱藏
            ctr.openChatInput.value = false;
          },
          child: Container(
            height: maxHeight,
            width: maxWidth,
            child: Stack(
              children: [
                // 照著鍵盤高度 改變位置
                Obx(
                  () => Positioned(
                    bottom: ctr.openChatInput.value
                        ? _keyboardHeight
                        : -_chatInputHeight,
//                    bottom: liveChatRoomController.openChatInput.value
//                        ? _keyboardHeight
//                        : 0,
                    right: 0,
                    left: 0,
                    top: ctr.openChatInput.value
                        ? -_keyboardHeight
                        : _chatInputHeight,
//                    top: liveChatRoomController.openChatInput.value
//                        ? -_keyboardHeight
//                        : 0,
                    child: AnimatedOpacity(
                      duration: Duration(milliseconds: _opacityDuration),
                      opacity: _opacity,
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
                  ),
                )
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
