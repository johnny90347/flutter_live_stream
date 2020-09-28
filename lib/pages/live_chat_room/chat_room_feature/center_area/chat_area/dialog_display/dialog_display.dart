import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_live_stream/core/controllers/live_chat_room_controller.dart';

class DialogDisplay extends StatefulWidget {
  @override
  _DialogDisplayState createState() => _DialogDisplayState();
}

class _DialogDisplayState extends State<DialogDisplay> {
  final ctr = Get.find<LiveChatRoomController>();

  ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();

    ctr.listItems.listen((value) {
      Timer(Duration(milliseconds: 100), () {
        _scrollToBottom(useAnimate: true);
      });
    });

    Timer(Duration(milliseconds: 1000), () {
      _scrollToBottom(useAnimate: false);
    });

    _scrollController.addListener(() {
     print(_scrollController.position.pixels);
     print(_scrollController.position.maxScrollExtent);
    });

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // 列表滾動至底部
  _scrollToBottom({@required bool useAnimate}){
    //分動畫滾動 and 非動畫
    if(useAnimate){
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200), curve: Curves.linear);
    }else{
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Obx(
        () => ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            controller: _scrollController,
            itemCount: ctr.listItems.length,
            itemBuilder: (context, index) {
              return Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.record_voice_over),
                    Expanded(child: Text('${ctr.listItems[index]}')),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
