import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_live_stream/core/controllers/live_chat_room_controller.dart';
import 'package:flutter_live_stream/core/enum/response.dart';
import 'package:google_fonts/google_fonts.dart';

const boxWidth = 250.0;
const boxHeight = 50.0;
const centerBoxHeight = 50.0 - 4.0; // 扣除掉上下白線的中間寬

class NormalGiftView extends StatefulWidget {
  @override
  _NormalGiftViewState createState() => _NormalGiftViewState();
}

class _NormalGiftViewState extends State<NormalGiftView>
    with TickerProviderStateMixin {
  final ctr = Get.find<LiveChatRoomController>();
  //滑動動畫控制
  AnimationController _animationController;
  Animation _containerSlideAnimation; //容器移動動畫

  @override
  void initState() {
    super.initState();
    _setUpAnimation();
    _listenCommend();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  /// 設置動畫
  _setUpAnimation() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..addStatusListener((status) {
        if (status == AnimationStatus.forward) {
          // 動畫正在前進中
          ctr.giftViewState = GiftViewState.onProcess;
        }

        if (status == AnimationStatus.completed) {
          // 畫面為顯示狀態
          ctr.giftViewState = GiftViewState.show;
        }
        if (status == AnimationStatus.reverse) {
          // 動畫返回中
          ctr.giftViewState = GiftViewState.onProcess;
        } //
        if (status == AnimationStatus.dismissed) {
          // 畫面為隱藏狀態
          ctr.giftViewState = GiftViewState.hidden;
        }
      });
    _containerSlideAnimation =
        Tween(begin: Offset(-1.0, 0.0), end: Offset(0.0, 0.0)).animate(
            CurvedAnimation(
                parent: _animationController, curve: Curves.easeIn));
//    _animationController.forward();
  }

  /// 監聽指令,要開啟或者收起來送禮提示
  _listenCommend() {
    ctr.giftAnimateCommand.listen((command) {
      print(command);
      if (command == GiftCommand.toShow) {
        _animationController.forward();
      }
      if (command == GiftCommand.toHidden) {
        ctr.giftViewState = GiftViewState.onProcess;
        //2秒後才收回畫面
        Timer(Duration(milliseconds: 2000), () {
          _animationController.reverse();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _containerSlideAnimation,
      child: SizedBox(
        height: boxHeight * 2,
        width: boxWidth,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              bottom: 0,
              child: SizedBox(
                width: boxWidth,
                height: boxHeight,
                child: Column(
                  children: [
                    WhiteBorderLine(),
                    Container(
                      width: boxWidth,
                      height: boxHeight - 4,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            // 主播背景漸層色
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color.fromRGBO(254, 148, 189, 1),
                              Color.fromRGBO(94, 231, 223, .9),
                              Colors.transparent
                            ],
                            stops: [
                              0.0,
                              0.4,
                              0.8
                            ]),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            height: centerBoxHeight,
                            width: boxWidth / 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Obx(
                                  () => StrokeText(
                                    text: '${ctr.giftNoticeList[0].NickName}',
                                  ),
                                ),
                                Obx(
                                  () => StrokeText(
                                    text:
                                        '送出 ${ctr.giftNoticeList[0].GiftName}',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    WhiteBorderLine(),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 4,
              left: 75,
              child: SizedBox(
                height: boxHeight * 1.5,
                width: boxHeight * 1.5,
                child: Obx(
                  () => Image.asset(
                      'assets/images/${ctr.giftNoticeList[0].GiftUrl}'),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 150,
              child: StrokeSymbol(
                text: '×',
              ),
            ),
            Positioned(
                bottom: -8,
                left: 170,
                child: Obx(
                  () => StrokeNumber(
                    text: '${ctr.giftNoticeCombo.value}',
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

// 白色漸層邊線
class WhiteBorderLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 2.0,
      width: boxWidth,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            // 主播背景漸層色
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Colors.white, Colors.white10, Colors.transparent],
            stops: [0.3, 0.6, 0.8]),
      ),
    );
  }
}

// 有外框的文字
class StrokeText extends StatelessWidget {
  final String text;

  StrokeText({@required this.text});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // 文字加入邊框
        Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 12,
            letterSpacing: 1.2,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 2
              ..color = Colors.white,
          ),
        ),
        // Solid text as fill.
        Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style:
              TextStyle(fontSize: 12, color: Colors.black, letterSpacing: 1.2),
        ),
      ],
    );
  }
}

// 有外框的數字
class StrokeNumber extends StatefulWidget {
  final String text;
  StrokeNumber({@required this.text});

  @override
  _StrokeNumberState createState() => _StrokeNumberState();
}

class _StrokeNumberState extends State<StrokeNumber>
    with TickerProviderStateMixin {
  //滑動動畫控制
  AnimationController _animationController;
  Animation _containerSlideAnimation; //容器移動動畫
  final ctr = Get.find<LiveChatRoomController>();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    )..addListener(() {});
    _containerSlideAnimation =
        Tween(begin: Offset(0.0, -0.3), end: Offset(0.0, 0.0))
            .animate(_animationController);
    _animationController.forward();

    //如果combo數字有變動,就再做一次動畫
    ctr.giftNoticeCombo.listen((value) {
      _animationController.reset();
      _animationController.forward();
    });
  }

  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _containerSlideAnimation,
      child: Stack(
        children: <Widget>[
          // 文字加入邊框
          Text(widget.text,
              style: GoogleFonts.pacifico(
                textStyle: TextStyle(
                  fontSize: 40,
                  letterSpacing: 1.2,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 3
                    ..color = Colors.white,
                ),
              )),
          // Solid text as fill.
          Text(widget.text,
              style: GoogleFonts.pacifico(
                textStyle: TextStyle(
                    fontSize: 40, color: Colors.black, letterSpacing: 1.2),
              )),
        ],
      ),
    );
  }
}

// 有外框的符號(乘號)
class StrokeSymbol extends StatelessWidget {
  final String text;

  StrokeSymbol({@required this.text});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // 文字加入邊框
        Text(text,
            style: GoogleFonts.pacifico(
              textStyle: TextStyle(
                fontSize: 20,
                letterSpacing: 1.2,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 2
                  ..color = Colors.white,
              ),
            )),
        // Solid text as fill.
        Text(text,
            style: GoogleFonts.pacifico(
              textStyle: TextStyle(
                  fontSize: 20, color: Colors.black, letterSpacing: 1.2),
            )),
      ],
    );
  }
}
