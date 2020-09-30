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
  bool _isOnBottom = false;

  @override
  void initState() {
    _scrollController = ScrollController();
    _setUpChatListListener();
    _setUpScrollListener();
    _firstScrollToBottom();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // 列表滾動至底部
  _scrollToBottom({@required bool useAnimate}) {
    //分動畫滾動 and 非動畫
    if (useAnimate) {
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200), curve: Curves.linear);
    } else {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }

  // 第一次一定先滾到底部
  _firstScrollToBottom() {
    Timer(Duration(milliseconds: 1000), () {
      _scrollToBottom(useAnimate: false);
    });
  }

  // 聊天列表監聽
  _setUpChatListListener() {
    ctr.listItems.listen((value) {
      Timer(Duration(milliseconds: 100), () {
        // 如果在底部才允許字幕自動滾動
        if (_isOnBottom) {
          _scrollToBottom(useAnimate: true);
        }
      });
    });
  }

  // 滾動監聽
  _setUpScrollListener() {
    _scrollController.addListener(() {
      double distance = _scrollController.position.maxScrollExtent -
          _scrollController.position.pixels;
      // 與底部距離小於 10 ,代表已滾動到底 + 不讓他一直setState
      if (distance < 10 && _isOnBottom == false) {
        _isOnBottom = true;
        setState(() {});
      } else if (distance >= 10 && _isOnBottom == true) {
        _isOnBottom = false;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          child: Obx(
            () => ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                controller: _scrollController,
                itemCount: ctr.listItems.length,
                itemBuilder: (context, index) {
                  return MessageItem(
                      level: 5, name: 'null', message: ctr.listItems[index]);
                }),
          ),
        ),
        Positioned(
          bottom: 10,
          child: !_isOnBottom
              ? Container(
                  width: 40.0,
                  height: 20.0,
                  decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(4.0)),
                  child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        size: 20.0,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        _scrollToBottom(useAnimate: true);
                      }),
                )
              : SizedBox(),
        )
      ],
    );
  }
}

// 聊天內容的樣式
class MessageItem extends StatelessWidget {
  final int level;
  final String name;
  final String message;

  MessageItem(
      {@required this.level, @required this.name, @required this.message});

  final backgroundColor = Colors.black26;

  // 由於 listView 直向,寬度會被強制擴展,為了讓對話有彈性的背景顏色,所以我嘗試多次選擇
  // 1.row開頭
  // 2.包一層Flexible,讓大量文字不會超出邊界
  // 3.Warp 是仿照17的顯示,若文字太多,玩家名稱與內容文字,是分開兩排,不黏再一起
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Container(
            decoration: BoxDecoration(color: backgroundColor,borderRadius: BorderRadius.circular(4.0)),
            padding: EdgeInsets.symmetric(horizontal: 2.0,vertical: 1.0),
            margin: EdgeInsets.symmetric(vertical: 2),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Icon(Icons.record_voice_over),
                RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(style: TextStyle(fontSize: 12.0), children: [
                    TextSpan(text: 'Nini'),
                    TextSpan(text: message)
                  ]),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
