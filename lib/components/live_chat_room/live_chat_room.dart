import 'package:flutter/material.dart';
import './live_stream/live_stream.dart';
import './chat_room_feature/chat_room_feature.dart';

class LiveChatRoom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
        Positioned(
          top: 0,
          right: 0,
          bottom: 0,
          left: 0,
          child: LiveStream() ,//直播畫面
        ),
          Positioned(
            top: 0,
            right: 0,
            bottom: 0,
            left: 0,
            child: ChatRoomFeature() ,//直播畫面
          )
        ],
      ),
    );
  }
}




