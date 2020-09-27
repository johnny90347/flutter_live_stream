import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './live_stream/live_stream.dart';
import './chat_room_feature/chat_room_feature.dart';

class LiveChatRoom extends StatefulWidget {
  @override
  _LiveChatRoomState createState() => _LiveChatRoomState();
}

class _LiveChatRoomState extends State<LiveChatRoom> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding:false,
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              bottom: 0,
              left: 0,
              child: LiveStream(), //直播畫面
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
