import 'package:flutter/material.dart';
import 'package:flutter_live_stream/core/controllers/live_chat_room_controller.dart';
import 'package:google_fonts/google_fonts.dart';

const boxWidth = 200.0;
const boxHeight = 50.0;

/// 目前沒在用
/// 送禮動畫的畫面+動畫
class NormalGiftAnimation extends StatefulWidget {
  @override
  _NormalGiftAnimationState createState() => _NormalGiftAnimationState();
}

class _NormalGiftAnimationState extends State<NormalGiftAnimation>
    with TickerProviderStateMixin {
  final ctr = Get.find<LiveChatRoomController>();

  //滑動動畫控制
  AnimationController _animationController;
  Animation _containerSlideAnimation; //容器移動動畫

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..addListener(() {});
    _containerSlideAnimation =
        Tween(begin: Offset(-1.0, 0.0), end: Offset(0.0, 0.0))
            .animate(_animationController);
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _containerSlideAnimation,
      child: SizedBox(
        width: boxWidth,
        height: boxHeight * 2,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              child: Container(
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
                width: boxWidth,
                height: boxHeight,
                child: Stack(
                  children: [
                    Positioned(
                        //上方白色漸層Border
                        top: 0,
                        left: 0,
                        right: 0,
                        child: WhiteBorderLine()),
                    Positioned(
                        //下方白色漸層Border
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: WhiteBorderLine()),
                    Positioned(
                      top: 0,
                      right: 0,
                      bottom: 0,
                      left: 0,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10.0,
                          ),
                          SizedBox(
                            height: boxHeight * 0.7,
                            width: boxHeight * 0.7,
                            child: Image.asset(
                                'assets/images/gift/icon/gift_1.png'),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                padding: const EdgeInsets.only(left: 10.0),
                                height: boxHeight / 2,
                                width: boxWidth - boxHeight, // 剪掉圖片的寬度
                                child: StrokeSymbol(
                                  text: '×',
                                ),
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                height: boxHeight / 2,
                                child: StrokeText(
                                  text: '大麥克',
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
                // 送禮次數 * 幾次
                left: 70,
                bottom: 16,
                child: StrokeNumber(
                  text: '1',
                )),
          ],
        ),
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

class _StrokeNumberState extends State<StrokeNumber> {
  @override
  void initState() {
    super.initState();
  }

  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 80,
      child: Stack(
        children: <Widget>[
          // 文字加入邊框
          Positioned(
            bottom: 0,
            child: Text(widget.text,
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
          ),
          // Solid text as fill.
          Positioned(
            bottom: 0,
            child: Text(widget.text,
                style: GoogleFonts.pacifico(
                  textStyle: TextStyle(
                      fontSize: 40, color: Colors.black, letterSpacing: 1.2),
                )),
          ),
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
                fontSize: 12,
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
                  fontSize: 12, color: Colors.black, letterSpacing: 1.2),
            )),
      ],
    );
  }
}

// 白色漸層邊線
class WhiteBorderLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 2.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            // 主播背景漸層色
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Colors.white, Colors.white10, Colors.transparent],
            stops: [0.3, 0.6, 1.0]),
      ),
    );
  }
}
