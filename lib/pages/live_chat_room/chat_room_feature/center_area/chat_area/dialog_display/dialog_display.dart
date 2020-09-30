//套件
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
  bool _isOnBottom = true;
  bool _showScrollButton = false;

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

//   滾動監聽,決定是否需要顯示滾動至底部的按鈕
  _setUpScrollListener() {
    _scrollController.addListener(() {
      // 向上滾就顯示滾到底部按鈕 , 並且一定不是在底部
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (_isOnBottom != false && _showScrollButton != true) {
          _isOnBottom = false;
          _showScrollButton = true;
          setState(() {});
        }
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
            () => NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                switch (notification.runtimeType) {
                  case ScrollStartNotification:
                  // 開始滾動
                    break;
                  case ScrollUpdateNotification:
                  // 滾動中
                    break;
                  case ScrollEndNotification:
                  // 停止滾動時,再去算位置,看是否在底部
                    if (notification.metrics.maxScrollExtent -
                            notification.metrics.pixels <
                        10) {
                      if(_isOnBottom != true && _showScrollButton!= false){
                        _isOnBottom = true;
                        _showScrollButton = false;
                      }
                      setState(() {});
                    }
                    break;
                  case OverscrollNotification:
                    //在邊界
                    break;
                }
                return false;
              },
              child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  controller: _scrollController,
                  itemCount: ctr.listItems.length,
                  itemBuilder: (context, index) {
                    return MessageItem(
                        level: 5, name: 'null', message: ctr.listItems[index]);
                  }),
            ),
          ),
        ),
        Positioned(
          // 滾動至底部按鈕
          bottom: 10,
          child: _showScrollButton
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

  final backgroundColor = Colors.black38;
  final messageFontSize = 12.0;
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
            decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(4.0)),
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
            margin: EdgeInsets.symmetric(vertical: 2),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                ConstrainedBox(
                    constraints: BoxConstraints(minHeight: 16.0), // 給個最小高度
                    child: VipRank()),
                SizedBox(
                  width: 4.0,
                ),
                Text(
                  'HTTW01',
                  style: TextStyle(
                      fontSize: messageFontSize,
                      color: Color(0xffdbdbdb),
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  width: 2.0,
                ),
                RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                      style: TextStyle(
                          fontSize: messageFontSize,
                          fontWeight: FontWeight.w500),
                      children: [TextSpan(text: message)]),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

// 使用者內容 等級Icon,等級數字,名稱
class VipRank extends StatelessWidget {
  final Gradient vipBgGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xffbb4e75), Color(0xffff9d6c)],
  );

  @override
  Widget build(BuildContext context) {
    // 1.背景變形
    // 2.沒變形的內容相疊而成

    final boxWidth = 40.0;
    final boxHeight = 16.0;
    return Stack(
      children: [
        Transform(
          transform: Matrix4.skewX(-0.2),
          child: Container(
            width: boxWidth,
            height: boxHeight,
            decoration: BoxDecoration(
              gradient: vipBgGradient,
              borderRadius: BorderRadius.circular(3.0),
            ),
          ),
        ),
        Container(
          width: boxWidth,
          height: boxHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                // 給圖片Size
                height: 14,
                width: 14,
                child: SvgPicture.asset(
                  'assets/images/vip/vip-diamond.svg',
                  color: Colors.white,

                ),
              ),
              SizedBox(
                width: 3.0,
              ),
              Text(
                '17',
                style: TextStyle(color: Colors.white, fontSize: 10.0),
              )
            ],
          ),
        ),
      ],
    );
  }
}
