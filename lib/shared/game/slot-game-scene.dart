//
//import 'package:flame/components/component.dart';
//import 'package:flame/gestures.dart';
//import 'package:flutter/material.dart';
//import 'package:flame/game.dart';
//import 'package:flame/position.dart';
//import 'package:flame/text_config.dart';
//class SlotGameScene extends BaseGame with TapDetector {
//
//  Size screenSize; // 螢幕寬高
//  final fpsTextConfig = TextConfig(color: const Color(0xFFFFFFFF));
//
//  RectContainer rectContainer ;
//
//  SlotGameScene(){
//
//    rectContainer = RectContainer();
//  add(rectContainer);
//  }
//
//  @override
//  bool debugMode() => true;
//
//  @override
//  bool recordFps() => true;
//
//  @override
//  Color backgroundColor() {
//    return Colors.purple;
//  }
//
//  @override
//  void resize(Size size) {
//    screenSize = size;
//    super.resize(size);
//  }
//
//  @override
//  void render(Canvas canvas) {
//    super.render(canvas);
//    if (debugMode()) { // 出現fps數值
//      fpsTextConfig.render(canvas, fps(120).toString(), Position(0, 50));
//    }
//  }
//
////  @override
////  void render(Canvas canvas) {
////
////
//////   print('螢幕的中央座標${screenSize.width / 2 - 100},${screenSize.height / 2}');
//////   print('方塊的中央座標${rect.center.dx},${rect.center.dy}');
////  }
////
////  @override
////  void update(double t) {
////
////  }
//
// @override
//  void onTapDown(TapDownDetails details) {
//    super.onTapDown(details);
//  }
//
//}
//
//
//class RectContainer extends PositionComponent{
//
//  RectContainer(){
//    print("初始化");
//  }
//
//  Rect rect;
//  @override
//  void render(Canvas canvas) {
//
//    print('畫出來');
//    // TODO: implement render
//    rect = Rect.fromLTWH(10, 10, 200, 200);
//    Paint paint = Paint();
//    paint.color = Color(0xffd7de68);
//    canvas.drawRect(rect, paint);
//
//
//  var newRect = Rect.fromLTWH(50, 400, 100, 100);
//
//  canvas.clipRect(rect);
//
//
//
//  }
//
//}
