import 'package:flutter/material.dart';
import './live_stream/live_stream.dart';
import './chat_room_feature/chat_room_feature.dart';
import 'package:flutter_live_stream/core/controllers/live_chat_room_controller.dart';

import 'live_stream/live_stream_fijk.dart';

class LiveChatRoom extends StatefulWidget {
  @override
  _LiveChatRoomState createState() => _LiveChatRoomState();
}

class _LiveChatRoomState extends State<LiveChatRoom> {
  final ctr = Get.find<LiveChatRoomController>();

  @override
  void initState() {
    ctr.liveChatRoomInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            bottom: 0,
            left: 0,
            child: LiveStreamFijk(),
          ),
          Positioned(
            top: 0,
            right: 0,
            bottom: 0,
            left: 0,
            child: ChatRoomFeature(), //聊天房功能
          )
        ],
      ),
    );
  }
}
