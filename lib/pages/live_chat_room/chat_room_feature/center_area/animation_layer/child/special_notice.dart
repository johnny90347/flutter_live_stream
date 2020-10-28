import 'package:flutter/material.dart';
import 'package:flutter_live_stream/core/controllers/live_chat_room_controller.dart';


/// 特別提示(關注主播提示)
class SpecialNotice extends StatefulWidget {
  @override
  _SpecialNoticeState createState() => _SpecialNoticeState();
}

class _SpecialNoticeState extends State<SpecialNotice>
    with TickerProviderStateMixin {
  final ctr = Get.find<LiveChatRoomController>();
  //滑動動畫控制
  AnimationController _animationController;
  Animation _containerSlideAnimation; //容器文字移動動畫
  Animation _flashSlideAnimation; //閃光移動動畫
  Animation _widthAnimationOne; //閃光長度-1
  Animation _widthAnimationTwo; //閃光長度-2
  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..addListener(() {
//        setState(() {});
    });

    // 同一個controller 可以,同時控制很多個animation, Sequence 內的weight 代表權重,例如第一個他的動畫時間就是 總時間* 10/100;
    // 而更下面 Interval(0.6,1.0) 的意思是 “我這個動畫從 動畫總時間*0.6 開始動,動到動畫總時最的最後”,
    // 用這樣的方式來組合各種動畫,所以動畫可以併排,也可以依序展示
    _containerSlideAnimation = TweenSequence<Offset>([
      TweenSequenceItem(
          tween: Tween(begin: Offset(-1.1, 0.0), end: Offset(0.1, 0.0)),
          weight: 3), //提示滑出來-1
      TweenSequenceItem(
          tween: Tween(begin: Offset(0.1, 0.0), end: Offset(0, 0.0)),
          weight: 2), //提示滑出來-2
      TweenSequenceItem(
          tween: ConstantTween<Offset>(Offset(0, 0.0)),
          weight: 90), // 總動畫時間* 90/100; 做別的動畫
      TweenSequenceItem(
          tween: Tween(begin: Offset(0.0, 0.0), end: Offset(0.1, 0.0)),
          weight: 2), //提示收起來 -1
      TweenSequenceItem(
          tween: Tween(begin: Offset(0.1, 0.0), end: Offset(-1.1, 0.0)),
          weight: 3), //提示收起來 -2
    ]).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.linear,
    ));

    // Interval 可以依據controller來定義操作時間
    _flashSlideAnimation =
        Tween(begin: Offset(-1.0, 0.0), end: Offset(1.0, 0.0)).animate( // 平移動畫 左->右
            CurveTween(curve: Interval(0.4, 0.6, curve: Curves.linear))
                .animate(_animationController));
    _widthAnimationOne = Tween(begin: 10.0, end: 30.0).animate( // 寬度動畫 小->大
        CurveTween(curve: Interval(0.4, 0.6, curve: Curves.linear))
            .animate(_animationController));
    _widthAnimationTwo = Tween(begin: 30.0, end: 10.0).animate( // 寬度動畫 大->小
        CurveTween(curve: Interval(0.4, 0.6, curve: Curves.linear))
            .animate(_animationController));

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reset(); // 完成後就把動畫重置
      }
    });

    _specialNoticeListener();
    super.initState();
  }

  /// 監聽特殊訊息是否有更新
  _specialNoticeListener() {
    ctr.specialNoticeContent.listen((String notice) {
      if (notice == '') {
        return;
      }
      // 執行動畫
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  final containerHeight = 25.0;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _containerSlideAnimation,
      child: ClipRect(
        child: Container(
          width: 170,
          height: containerHeight,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xff8eb9e2),
                  Color(0xff6985fd),
                  Color(0xff7572fe)
                ],
              )),
          child: Stack(
            children: [
              Positioned(
                left: 0,
                bottom: 0,
                right: 0,
                child: SlideTransition(
                  position: _flashSlideAnimation,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Transform(
                        transform: Matrix4.skewX(-0.2), // 第一片反光
                        child: Container(
                          width: _widthAnimationOne.value,
                          height: containerHeight,
                          color: Colors.white70,
                        ),
                      ),
                      Transform(
                        transform: Matrix4.skewX(-0.2), // 第二片反光
                        child: Container(
                          width: _widthAnimationTwo.value,
                          height: containerHeight,
                          color: Colors.white70,
                        ),
                      ),
                      Transform(
                        transform: Matrix4.skewX(-0.2), // 第三片反光
                        child: Container(
                          width: _widthAnimationOne.value,
                          height: containerHeight,
                          color: Colors.white70,
                        ),
                      ),
                      Transform(
                        transform: Matrix4.skewX(-0.2), // 第四片反光
                        child: Container(
                          width: _widthAnimationTwo.value,
                          height: containerHeight,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned( // 內文
                top: 0,
                right: 0,
                bottom: 0,
                left: 0,
                child: Obx(
                      () => Container(
                    alignment: Alignment.center,
                    child: Text(
                      '${ctr.specialNoticeContent.value}',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 13.0),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
