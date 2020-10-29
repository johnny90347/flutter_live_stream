import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NormalGiftAnimation extends StatefulWidget {
  @override
  _NormalGiftAnimationState createState() => _NormalGiftAnimationState();
}

class _NormalGiftAnimationState extends State<NormalGiftAnimation> {
  final boxWidth = 200.0;
  final boxHeight = 50.0;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                          width: 2.0,
                        ),
                        SizedBox(
                          height: boxHeight * 0.7,
                          width: boxHeight * 0.7,
                          child:
                              Image.asset('assets/images/gift/icon/gift_1.png'),
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
            left: 60,
            top: 20,
            child: Container(
              alignment: Alignment.bottomLeft,
              width: 50,
              height: 50,
              child: StrokeNumber(text: '59'),
            ),
          ),
        ],
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
class StrokeNumber extends StatelessWidget {
  final String text;

  StrokeNumber({@required this.text});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // 文字加入邊框
        Text(text,
            style: GoogleFonts.pacifico(
              textStyle: TextStyle(
                fontSize: 35,
                letterSpacing: 1.2,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 3
                  ..color = Colors.white,
              ),
            )),
        // Solid text as fill.
        Text(text,
            style: GoogleFonts.pacifico(
              textStyle: TextStyle(
                  fontSize: 35, color: Colors.black, letterSpacing: 1.2),
            )),
      ],
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
