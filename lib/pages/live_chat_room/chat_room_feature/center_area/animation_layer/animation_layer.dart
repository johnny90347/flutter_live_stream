import 'dart:async';

import 'package:flutter/material.dart';

class AnimationLayer extends StatefulWidget {
  @override
  _AnimationLayerState createState() => _AnimationLayerState();
}

class _AnimationLayerState extends State<AnimationLayer>
    with TickerProviderStateMixin {
  //滑動動畫控制
  AnimationController _slideController;
  var _slideAnimation;

  //閃光動畫
  var _flashAnimation;

  @override
  void initState() {
    _slideController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );

    // 同一個controller 可以,同時控制很多個animation, Sequence 內的weight 代表權重,例如第一個他的動畫時間就是 總時間* 35/100;
    // 而更下面 Interval(0.6,1.0) 的意思是 “我這個動畫從 動畫總時間*0.6 開始動,動到動畫總時最的最後”,
    // 用這樣的方式來組合各種動畫,所以動畫可以併排,也可以依序展示
    _slideAnimation = TweenSequence<Offset>([
    TweenSequenceItem(tween: Tween(begin: Offset(-1, 0.0),end: Offset(0.2, 0.0)), weight: 10),
      TweenSequenceItem(tween: Tween(begin: Offset(0.2, 0.0),end: Offset(0, 0.0)), weight: 5),
      TweenSequenceItem(tween: ConstantTween<Offset>(Offset(0, 0.0)), weight: 70), // 總動畫時間* 40/100; 做別的動畫
      TweenSequenceItem(tween: Tween(begin: Offset(0.0, 0.0),end: Offset(0.2, 0.0)), weight: 5),
      TweenSequenceItem(tween: Tween(begin: Offset(0.2, 0.0),end: Offset(-1, 0.0)), weight: 10),
    ]).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeInOut,
    ));

     // Interval 可以依據controller來定義操作時間
//    _slideAnimation = Tween(begin: Offset(-1, 0.0),end: Offset(0.0, 0.0)).animate(CurveTween(curve:Interval(0.0, 0.5,curve: Curves.easeInOut)).animate(_slideController));
    _flashAnimation = Tween(begin: Offset(0.0, 0.0),end: Offset(10.0, 0.0)).animate(CurveTween(curve:Interval(0.4, 0.5,curve: Curves.linear)).animate(_slideController));

    _slideController.addStatusListener((status) {
      print(status);
      if(status == AnimationStatus.completed){
        _slideController.reset();// 完成後就把動畫拿掉
        Timer(Duration(seconds: 2),((){
          _slideController.forward();
        }));
      }
    });

    Timer(Duration(seconds: 2),((){
      _slideController.forward();
    }));


    super.initState();
  }

  @override
  void dispose() {
   _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Positioned(
            top: 5,
            left: 0,
            child: SlideTransition(
              position: _slideAnimation,
              child: ClipRect(
                child: Container(
                  margin: const EdgeInsets.only(left: 10.0),
                  width: 150,
                  height: 30,
                  color: Colors.red,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        bottom: 0,
                        child: SlideTransition(
                          position: _flashAnimation,
                          child: Container(
                            width: 15,
                            height: 30,
                            color: Colors.green,
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
