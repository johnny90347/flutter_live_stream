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
  double _scrollCurrentPosition = 0; // 向上滑時,記下位置(為了解決無法滑到最底的問題workaround)

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
    ctr.chatList.listen((value) {
      Timer(Duration(milliseconds: 100), () {
        // 如果在底部才允許字幕自動滾動
        if (_isOnBottom) {
          _scrollToBottom(useAnimate: true);
        } else {
          // 如果不在底部要微微的滾動,他才會更新到最新的maxScrollExtent ,原因不明
          _scrollCurrentPosition += 0.01;
          _scrollController.animateTo(_scrollCurrentPosition,
              duration: const Duration(milliseconds: 10), curve: Curves.linear);

          // 顯示滾動到最下面的按鈕
          if (_showScrollButton != true) {
            _showScrollButton = true;
            setState(() {});
          }
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
        //如果往上滾,存下位置
        _scrollCurrentPosition = _scrollController.position.pixels;

        if (_isOnBottom != false) {
          _isOnBottom = false;
          setState(() {});
        }
      }
    });
  }

  // 滾動通知處理
  _scrollNotifyHandel(ScrollNotification notification) {
    switch (notification.runtimeType) {
      case ScrollStartNotification:
        // 開始滾動
        break;
      case ScrollUpdateNotification:
        // 滾動中
        break;
      case ScrollEndNotification:
        // 停止滾動時,再去算位置,看是否在底部
        if (notification.metrics.maxScrollExtent - notification.metrics.pixels <
            10) {
          if (_isOnBottom != true && _showScrollButton != false) {
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
  }

  //切割tag 與一般訊息
  List<TextSpan> _splitMessage({@required String message}) {
    //刪除開頭和結尾空白
    final okMessage = message.trim();

    // 回傳出去textSpanList
    List<TextSpan> textSpanList = [];

    // 篩選@XXX+(空白);
    RegExp exp = new RegExp(r"(^[@]\S+,)");
    // 如果有符合tag檢查

    if (exp.hasMatch(okMessage)) {
      final idx = okMessage.indexOf(","); //找出逗號的位置,並切割
      final firstPart = (okMessage.substring(0, idx) + ' ')
          .replaceFirst('@', ''); // 第一段文字的@拿掉
      final secondPart = okMessage.substring(idx + 1);
      final List msgList = [firstPart, secondPart];
      textSpanList.add(TextSpan(
          text: msgList[0], style: TextStyle(color: Color(0xfffdac33))));
      textSpanList.add(TextSpan(text: msgList[1]));
    } else {
      textSpanList.add(TextSpan(text: okMessage));
    }

    return textSpanList;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          child: Obx(
            () => NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification notification) {
                _scrollNotifyHandel(notification);
                return false;
              },
              child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  controller: _scrollController,
                  itemCount: ctr.chatList.length,
                  itemBuilder: (context, index) {
                    return MessageItem(
                        isAnchor: ctr.chatList[index].IsAnchor,
                        level: ctr.chatList[index].Level,
                        name: ctr.chatList[index].NickName,
                        textSpanList:
                            _splitMessage(message: ctr.chatList[index].Body));
                  }),
            ),
          ),
        ),
        Positioned(
          // 滾動至底部按鈕
          bottom: 10,
          child: _showScrollButton
              ? InkWell(
                  onTap: () {
                    _scrollToBottom(useAnimate: true);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                        vertical: 6.0, horizontal: 10.0),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: Offset(1, 1), // changes position of shadow
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4.0)),
                    child: Text(
                      '有新的讯息',
                      style: TextStyle(color: Colors.black, fontSize: 12.0),
                    ),
                  ),
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
  final List<TextSpan> textSpanList;
  final bool isAnchor;

  MessageItem(
      {@required this.level,
      @required this.isAnchor,
      @required this.name,
      @required this.textSpanList});

  final ctr = Get.find<LiveChatRoomController>();
  final backgroundColor = Colors.black38;
  final messageFontSize = 12.0;
  // 由於 listView 直向,寬度會被強制擴展,為了讓對話有彈性的背景顏色,所以我嘗試後選擇
  // 1.row開頭
  // 2.包一層Flexible,讓大量文字不會超出邊界
  // 3.Warp 是仿照17的顯示,若文字太多,玩家名稱與內容文字,是分開兩排,不黏在一起
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: InkWell(
            onTap: () {
              print('tag功能');
              // 目前測試內部含有@的文字有些會被阻擋
              final tagStr = '@$name, ';
              ctr.inputFocusNode.requestFocus();
              ctr.inputController.text = tagStr;
              ctr.inputController.selection = TextSelection.fromPosition(
                  TextPosition(offset: tagStr.length));
              // 加入tag到input,移動光標到最後一個字
            },
            child: Container(
              decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(4.0)),
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
              margin: const EdgeInsets.symmetric(vertical: 2),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.end,
                children: [
                  ConstrainedBox(
                      constraints: BoxConstraints(minHeight: 16.0), // 給個最小高度
                      child: VipRank(
                        rank: level,
                        isAnchor: isAnchor,
                      )),
                  SizedBox(
                    width: 4.0,
                  ),
                  Text(
                    name,
                    style: TextStyle(
                        fontSize: messageFontSize,
                        color: Color(0xffdbdbdb),
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                        style: TextStyle(
                            fontSize: messageFontSize,
                            fontWeight: FontWeight.w500),
                        children: textSpanList),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

// 使用者內容 等級Icon,等級數字,名稱
class VipRank extends StatefulWidget {
  final int rank;
  final bool isAnchor;

  VipRank({@required this.rank, @required this.isAnchor});

  @override
  _VipRankState createState() => _VipRankState();
}

class _VipRankState extends State<VipRank> {
  final backgroundColors = [
    [Color(0xff686868), Color(0xffb1aeae)],
    [Color(0xff07a15d), Color(0xff4ecfa6)],
    [Color(0xff0396ff), Color(0xff96d3ff)],
    [Color(0xff4a92a6), Color(0xff30cfd0)],
    [Color(0xff6590cb), Color(0xffb4cbf6)],
    [Color(0xfff74747), Color(0xfff68f8f)],
    [Color(0xff2bb9be), Color(0xff18f576)],
    [Color(0xff736efe), Color(0xff5efce8)],
    [Color(0xff7683d9), Color(0xffd8a0fe)],
    [Color(0xff78178e), Color(0xffd942fa)],
    [Color(0xff623aa2), Color(0xfff97794)],
    [Color(0xffdb8ade), Color(0xfff6bf9f)],
    [Color(0xffff7a95), Color(0xffffb696)],
    [Color(0xfff5576c), Color(0xfff093fb)],
    [Color(0xffbb4e75), Color(0xffff9d6c)],
    [Color(0xfff37987), Color(0xff75fbf0)],
    [Color(0xffb490ca), Color(0xff5ee7df)],
    [Color(0xffffd015), Color(0xff8be8f9)],
    [Color(0xfffa813f), Color(0xffffe159)],
    [Color(0xfff75867), Color(0xffffa043)],
  ];

  Gradient vipBgGradient; // 被景色漸層
  final Gradient anchorGradient = LinearGradient(
      // 主播背景漸層色
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xffbf820d), Color(0xffe6b760), Color(0xffb88c3b)],
      stops: [0.1, 0.4, 1.0]);

  @override
  void initState() {
    _setBackgroundColor();
    super.initState();
  }

  // 設定vip背景顏色
  _setBackgroundColor() {
    vipBgGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: backgroundColors[widget.rank],
    );
  }

  @override
  Widget build(BuildContext context) {
    // 1.背景變形
    // 2.沒變形的內容相疊而成
    final boxWidth = 45.0;
    final boxHeight = 16.0;
    return Stack(
      children: [
        Transform(
          transform: Matrix4.skewX(-0.1),
          child: Container(
            width: boxWidth,
            height: boxHeight,
            decoration: BoxDecoration(
                gradient: widget.isAnchor ? anchorGradient : vipBgGradient,
                borderRadius: BorderRadius.circular(2.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade700,
                    spreadRadius: 0.5,
                    offset: Offset(0.5, 0.5),
                  ),
                ]),
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
                alignment: Alignment.bottomCenter,
                // 給圖片Size
                height: 14,
                width: 14,
                child: widget.isAnchor
                    ? Icon(
                        Icons.headset,
                        size: 12,
                        color: Colors.white,
                      )
                    : Container(
                        padding: const EdgeInsets.symmetric(horizontal: 1.5),
                        child: SvgPicture.asset(
                          'assets/images/vip/vip-diamond.svg',
                          color: Colors.white,
                        ),
                      ),
              ),
              SizedBox(
                width: widget.isAnchor ? 1 : 3,
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  widget.isAnchor ? '主播' : '${widget.rank}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(
                width: 2.0,
              )
            ],
          ),
        ),
      ],
    );
  }
}
