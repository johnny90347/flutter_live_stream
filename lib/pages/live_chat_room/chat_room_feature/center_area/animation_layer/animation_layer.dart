import 'dart:async';

import 'package:flutter/material.dart';

class AnimationLayer extends StatefulWidget {
  @override
  _AnimationLayerState createState() => _AnimationLayerState();
}

class _AnimationLayerState extends State<AnimationLayer>
    with TickerProviderStateMixin {
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
        setState(() {});
      });

    // 同一個controller 可以,同時控制很多個animation, Sequence 內的weight 代表權重,例如第一個他的動畫時間就是 總時間* 10/100;
    // 而更下面 Interval(0.6,1.0) 的意思是 “我這個動畫從 動畫總時間*0.6 開始動,動到動畫總時最的最後”,
    // 用這樣的方式來組合各種動畫,所以動畫可以併排,也可以依序展示
    _containerSlideAnimation = TweenSequence<Offset>([
      TweenSequenceItem(
          tween: Tween(begin: Offset(-1.1, 0.0), end: Offset(0.2, 0.0)),
          weight: 3), //提示滑出來-1
      TweenSequenceItem(
          tween: Tween(begin: Offset(0.2, 0.0), end: Offset(0, 0.0)),
          weight: 2), //提示滑出來-2
      TweenSequenceItem(
          tween: ConstantTween<Offset>(Offset(0, 0.0)),
          weight: 90), // 總動畫時間* 40/100; 做別的動畫
      TweenSequenceItem(
          tween: Tween(begin: Offset(0.0, 0.0), end: Offset(0.2, 0.0)),
          weight: 2), //提示收起來 -1
      TweenSequenceItem(
          tween: Tween(begin: Offset(0.2, 0.0), end: Offset(-1.1, 0.0)),
          weight: 3), //提示收起來 -2
    ]).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    // Interval 可以依據controller來定義操作時間
    _flashSlideAnimation = Tween(begin: Offset(-1.0, 0.0), end: Offset(1.0, 0.0))
        .animate(CurveTween(curve: Interval(0.4, 0.6, curve: Curves.linear))
            .animate(_animationController));
    _widthAnimationOne = Tween(begin: 10.0, end: 30.0).animate(
        CurveTween(curve: Interval(0.4, 0.6, curve: Curves.linear))
            .animate(_animationController));
    _widthAnimationTwo = Tween(begin: 30.0, end: 10.0).animate(
        CurveTween(curve: Interval(0.4, 0.6, curve: Curves.linear))
            .animate(_animationController));

    _animationController.addStatusListener((status) {
      print(status);
      if (status == AnimationStatus.completed) {
        _animationController.reset(); // 完成後就把動畫拿掉
        Timer(Duration(seconds: 2), (() {
          _animationController.forward();
        }));
      }
    });

    Timer(Duration(seconds: 2), (() {
      _animationController.forward();
    }));

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Positioned(
            top: 5,
            left: 5,
            child: SlideTransition(
              position: _containerSlideAnimation,
              child: ClipRect(
                child: Container(
                  width: 150,
                  height: 20,
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
                                transform: Matrix4.skewX(-0.2),
                                child: Container(
                                  width: _widthAnimationOne.value,
                                  height: 20,
                                  color: Colors.white70,
                                ),
                              ),
                              Transform(
                                transform: Matrix4.skewX(-0.2),
                                child: Container(
                                  width: _widthAnimationTwo.value,
                                  height: 20,
                                  color: Colors.white70,
                                ),
                              ),
                              Transform(
                                transform: Matrix4.skewX(-0.2),
                                child: Container(
                                  width: _widthAnimationOne.value,
                                  height: 20,
                                  color: Colors.white70,
                                ),
                              ),
                              Transform(
                                transform: Matrix4.skewX(-0.2),
                                child: Container(
                                  width: _widthAnimationTwo.value,
                                  height: 20,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//Transform(
//transform: Matrix4.skewX(-0.1),
