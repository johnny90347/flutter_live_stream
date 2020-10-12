import 'package:flutter/material.dart';
import 'package:flutter_live_stream/pages/live_chat_room/chat_room_feature/center_area/animation_layer/animation_layer.dart';
import 'package:flutter_live_stream/pages/live_chat_room/chat_room_feature/center_area/chat_area/chat_area.dart';

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
            child: AnimationLayer() //動畫區
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
