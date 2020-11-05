import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_live_stream/core/controllers/live_chat_room_controller.dart';
import 'package:google_fonts/google_fonts.dart';

const boxWidth = 250.0;
const boxHeight = 50.0;
const centerBoxHeight = 50.0 -4.0; // 扣除掉上下白線的中間寬

class NormalGiftContainer extends StatelessWidget {
  final ctr = Get.find<LiveChatRoomController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: boxWidth,
      height: boxHeight * 2,
      child: Obx(
        () => ListView.builder(
          padding: EdgeInsets.all(0),
          reverse: true,
          itemCount: ctr.giftNoticeList.length,
          itemBuilder: (context, index) =>
              NormalGiftView(),
        ),
      ),
    );
  }
}

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
  Timer destroyTimer; // 計時器,用來倒數自己還剩多久可以活

  @override
  void initState() {
    super.initState();
    _setUpAnimation();

    //TODO: 再來個變數來監聽
  }

  @override
  void dispose() {
    _animationController.dispose();
    destroyTimer.cancel();
    super.dispose();
  }

  /// 設置動畫
  _setUpAnimation(){
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..addListener(() {})
      ..addStatusListener((status) {
        if(status == AnimationStatus.dismissed){
          //送禮畫面已經收回去了(畫面空)
          // 把送禮提示List 清空
          ctr.resetGiftNoticeList();
        }
      });
    _containerSlideAnimation =
        Tween(begin: Offset(-1.0, 0.0), end: Offset(0.0, 0.0))
            .animate(_animationController);

    // 0.5秒後開始動畫(怕畫面還在渲染,會卡一下)
    Timer(Duration(milliseconds: 500), () {
      _animationController.forward();
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
                          SizedBox(width: 10,),
                          SizedBox(
                            height: centerBoxHeight,
                            width: boxWidth/2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                StrokeText(
                                  text: '大麥克',
                                ),
                                StrokeText(
                                  text: '送出 棒棒糖',
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
              bottom:4,
              left: 75,
              child: SizedBox(
                height: boxHeight * 1.5,
                width: boxHeight * 1.5,
                child: Image.asset(
                    'assets/images/gift/icon/gift_1.png'),
              ),
            ),
            Positioned(
              bottom:0,
              left: 140,
              child: StrokeSymbol(
                text: '×',
              ),
            ),
            Positioned(
              bottom:-8,
              left: 160,
              child: Obx(()=> StrokeNumber(
                text: '${ctr.giftNoticeCombo.value}',
              ),)
            ),
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

class _StrokeNumberState extends State<StrokeNumber>  with TickerProviderStateMixin {

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