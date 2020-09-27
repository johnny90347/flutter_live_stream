import 'package:flutter/material.dart';
import 'package:flutter_live_stream/components/live_chat_room/chat_room_feature/center_area/chat_area/chat_area.dart';

//  中央區域
class CenterArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            top: 0,
            right: 0,
            bottom: 0,
            left: 0,
            child: Container( // 動畫區
              decoration: BoxDecoration(color: Colors.greenAccent),
            )
        ),
        Positioned(
            top: 0,
            right: 0,
            bottom: 0,
            left: 0,
            child: ChatArea() // 聊天區
        )
      ],
    );
  }
}