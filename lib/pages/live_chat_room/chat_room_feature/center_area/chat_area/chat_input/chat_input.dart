import 'package:flutter/material.dart';
import 'package:flutter_live_stream/core/controllers/live_chat_room_controller.dart';

class ChatInput extends StatefulWidget {
  @override
  _ChatInputState createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final liveChatRoomController = Get.find<LiveChatRoomController>();

  FocusNode _inputFocusNode; // 輸入框的聚焦
  TextEditingController _inputController; // textField控制器

  @override
  void initState() {
    _listenOpenChatInput();
    _inputFocusNode = FocusNode(); // node初始化
    _inputController = TextEditingController(); // 控制器初始化
    super.initState();
  }

  @override
  void dispose() {
    _inputFocusNode.dispose();
    _inputController.dispose();
    super.dispose();
  }

  //監聽是否有人改變開啟聊天的數值
  _listenOpenChatInput() {
    liveChatRoomController.openChatInput.listen((isOpen) {
      if (isOpen) {
        // 請求焦點
        _inputFocusNode.requestFocus();
      }
      //TODO : 如果input收起來,要把textFiled內的內容清掉
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.white),
      padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: IconButton(icon: Icon(Icons.record_voice_over,color: Colors.black87,), onPressed: (){
              print('彈幕');
            }),
          ),
          SizedBox(
            width: 2.0,
          ),
          Expanded(
            flex: 8,
            child: TextField(
              focusNode: _inputFocusNode,
              textInputAction: TextInputAction.send,
              onSubmitted: (value) {
                print("發送訊息");
              },
              textAlign: TextAlign.center,
               controller: _inputController,
              decoration: InputDecoration(
                hintText: '开始聊天吧！',
                fillColor: Colors.white,
                filled: true,
                contentPadding: EdgeInsets.all(1.0),
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
            child: IconButton(icon: Icon(Icons.mic_none,color: Colors.black87,), onPressed: (){
              print('彈幕');
            }),
          ),
        ],
      ),
    );
  }
}
