import 'package:flutter/material.dart';
import 'package:flutter_live_stream/core/controllers/live_chat_room_controller.dart';

class ChatInput extends StatefulWidget {
  @override
  _ChatInputState createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final liveChatRoomController = Get.find<LiveChatRoomController>();

  FocusNode _inputFocusNode; // 輸入框的聚焦

  @override
  void initState() {
    _listenOpenChatInput();
    _inputFocusNode = FocusNode(); // node初始化
    super.initState();
  }

  @override
  void dispose() {
    _inputFocusNode.dispose();
    super.dispose();
  }

  //監聽是否有人改變開啟聊天的數值
  _listenOpenChatInput(){
    liveChatRoomController.openChatInput.listen((isOpen) {
      if (isOpen) {
        // 請求焦點
        _inputFocusNode.requestFocus();
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: TextField(
            focusNode: _inputFocusNode,
            // controller: textController,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 4.0),
                fillColor: Colors.white,
                filled: true,
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.grey.shade300, width: 1.0)),
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.grey.shade300, width: 2.5))),
          ),
        )
      ],
    );
  }
}
