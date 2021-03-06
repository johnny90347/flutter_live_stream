import 'package:flutter/material.dart';
import 'package:flutter_live_stream/core/controllers/live_chat_room_controller.dart';

class ChatInput extends StatefulWidget {
  @override
  _ChatInputState createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final liveChatRoomController = Get.find<LiveChatRoomController>();

  @override
  void initState() {
    // _listenOpenChatInput();
    liveChatRoomController.inputFocusNode = FocusNode(); // node初始化
    liveChatRoomController.inputController = TextEditingController(); // 控制器初始化
    super.initState();
  }

  @override
  void dispose() {
    liveChatRoomController.inputFocusNode.dispose();
    liveChatRoomController.inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.white),
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: IconButton(
                icon: Icon(
                  Icons.record_voice_over,
                  color: Colors.black87,
                ),
                onPressed: () {
                  print('彈幕');
                }),
          ),
          SizedBox(
            width: 2.0,
          ),
          Expanded(
            flex: 8,
            child: TextField(
              focusNode: liveChatRoomController.inputFocusNode,
              textInputAction: TextInputAction.send,
              onSubmitted: (value) {
                final msg = liveChatRoomController.inputController.text;
                if (msg != '') {
                  liveChatRoomController.sendChatMessage(msg: msg);
                  liveChatRoomController.inputController.clear();
                }
              },
              textAlign: TextAlign.left,
              controller: liveChatRoomController.inputController,
              decoration: InputDecoration(
                hintText: '开始聊天吧！',
                fillColor: Colors.white,
                filled: true,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.grey.shade300, width: 1.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.grey.shade300, width: 2.5),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 2.0,
          ),
          Expanded(
            flex: 1,
            child: IconButton(
                icon: Icon(
                  Icons.mic_none,
                  color: Colors.black87,
                ),
                onPressed: () {
                  print('彈幕');
                }),
          ),
        ],
      ),
    );
  }
}
