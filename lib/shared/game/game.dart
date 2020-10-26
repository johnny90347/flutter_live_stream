//
//import 'dart:math' as math;
//import 'package:flame/box2d/box2d_component.dart';
//import 'package:flame/box2d/box2d_game.dart';
//import 'package:flame/box2d/contact_callbacks.dart';
//
//import 'package:flame/gestures.dart';
//import 'package:flame/palette.dart';
//import 'package:flutter/material.dart';
//import 'package:box2d_flame/box2d.dart';
//import 'package:box2d_flame/box2d.dart';
//import 'package:flame/box2d/box2d_component.dart';
//import 'package:flame/box2d/viewport.dart';
//import 'package:flame/palette.dart';
//
//class Ball extends BodyComponent {
//  Paint originalPaint, currentPaint;
//  bool giveNudge = false;
//
//  Ball(Vector2 position, Box2DComponent box) : super(box) {
//    originalPaint = _randomPaint();
//    currentPaint = originalPaint;
//    final worldPosition = viewport.getScreenToWorld(position);
//    _createBody(5.0, worldPosition);
//  }
//
//  Paint _randomPaint() {
//    final rng = math.Random();
//    return PaletteEntry(
//      Color.fromARGB(
//        100 + rng.nextInt(155),
//        100 + rng.nextInt(155),
//        100 + rng.nextInt(155),
//        255,
//      ),
//    ).paint;
//  }
//
//  void _createBody(double radius, Vector2 position) {
//    final CircleShape shape = CircleShape();
//    shape.radius = radius;
//
//    final fixtureDef = FixtureDef()
//      ..shape = shape
//      ..restitution = 1.0
//      ..density = 0.0
//      ..friction = 0.0
//      ..isSensor = true; // 如果它設為true了話,它就只會產生接觸的callback,但不會產生碰撞;
//
//    final bodyDef = BodyDef()
//    // To be able to determine object in collision
//      ..setUserData(this)
//      ..position = position
//      ..type = BodyType.DYNAMIC
//      ..linearVelocity =  Vector2(0,1000); // 給body設置速度,x = 正為右,負為左,y =正為上,負為下;
//
//      body = world.createBody(bodyDef)..createFixtureFromFixtureDef(fixtureDef);
//  }
//
//  @override
//  bool destroy() {
//    // Implement your logic for when the component should be removed
//    return false;
//  }
//
//  @override
//  void renderCircle(Canvas c, Offset p, double radius) {
//    final blue = const PaletteEntry(Colors.blue).paint;
//    c.drawCircle(p, radius, currentPaint);
//
//    final angle = body.getAngle();
//    final lineRotation =
//    Offset(math.sin(angle) * radius, math.cos(angle) * radius);
//    c.drawLine(p, p + lineRotation, blue);
//  }
//
//  @override
//  void update(double t) {
//    super.update(t);
////    if (giveNudge) {
////      body.applyLinearImpulse(Vector2(0, 10000), body.getLocalCenter(), true);
////      giveNudge = false;
////    }
//  }
//}
//
//class WhiteBall extends Ball {
//  WhiteBall(Vector2 position, Box2DComponent box) : super(position, box) {
//    originalPaint = BasicPalette.white.paint;
//    currentPaint = originalPaint;
//  }
//}
//// 定義Ball 跟 Ball 的對撞 ,begin 是剛撞到時會觸發,end是離開時觸發
//class BallContactCallback extends ContactCallback<Ball, Ball> {
//  @override
//  void begin(Ball ball1, Ball ball2, Contact contact) {
////    if (ball1 is WhiteBall || ball2 is WhiteBall) {
////      return;
////    }
////    if (ball1.currentPaint != ball1.originalPaint) {
////      ball1.currentPaint = ball2.currentPaint;
////    } else {
////      ball2.currentPaint = ball1.currentPaint;
////    }
//  print("begin");
//  }
//
//  @override
//  void end(Ball ball1, Ball ball2, Contact contact) {
//    print("end");
//  }
//}
//
//class WhiteBallContactCallback extends ContactCallback<Ball, WhiteBall> {
//  @override
//  void begin(Ball ball, WhiteBall whiteBall, Contact contact) {
//    ball.giveNudge = true;
//  }
//
//  @override
//  void end(Ball ball, WhiteBall whiteBall, Contact contact) {
//  }
//}
//
//class BallWallContactCallback extends ContactCallback<Ball, Wall> {
//  @override
//  void begin(Ball ball, Wall wall, Contact contact) {
//    wall.paint = ball.currentPaint;
//  }
//
//  @override
//  void end(Ball ball1, Wall wall, Contact contact) {
//  }
//}
//
//class MyGame extends Box2DGame with TapDetector {
//  MyGame(Box2DComponent box) : super(box) {
//    final boundaries = createBoundaries(box);
//    boundaries.forEach(add);
//    addContactCallback(BallContactCallback());
//    addContactCallback(BallWallContactCallback());
//    addContactCallback(WhiteBallContactCallback());
//  }
//
//  @override
//  void onTapDown(TapDownDetails details) {
//    super.onTapDown(details);
//    final Vector2 position =
//    Vector2(details.globalPosition.dx, details.globalPosition.dy);
//    if (math.Random().nextInt(10) < 2) {
//      add(WhiteBall(position, box));
//    } else {
//      add(Ball(position, box));
//    }
//  }
//}
//
//class MyBox2D extends Box2DComponent {
//  MyBox2D() : super(scale: 4.0, gravity: 0.0); // scale 縮放,gravity:重力,負的是向下,正的向上
//
//  @override
//  void initializeWorld() {}
//}
//
//
//List<Wall> createBoundaries(Box2DComponent box) {
//  var viewport = box.viewport;
//  final Vector2 screenSize = Vector2(viewport.width, viewport.height);
//  final Vector2 topLeft = (screenSize / 2) * -1;
//  final Vector2 bottomRight = screenSize / 2;
//  final Vector2 topRight = Vector2(bottomRight.x, topLeft.y);
//  final Vector2 bottomLeft = Vector2(topLeft.x, bottomRight.y);
//
//  return [
//    Wall(topLeft, topRight, box),
//    Wall(topRight, bottomRight, box),
//    Wall(bottomRight, bottomLeft, box),
//    Wall(bottomLeft, topLeft, box),
//  ];
//}
//
//class Wall extends BodyComponent {
//  Paint paint = BasicPalette.white.paint;
//  final Vector2 start;
//  final Vector2 end;
//
//  Wall(this.start, this.end, Box2DComponent box) : super(box) {
//    _createBody(start, end);
//  }
//
//  @override
//  void renderPolygon(Canvas canvas, List<Offset> coordinates) {
//    final start = coordinates[0];
//    final end = coordinates[1];
//    canvas.drawLine(start, end, paint);
//  }
//
//  void _createBody(Vector2 start, Vector2 end) {
//    final PolygonShape shape = PolygonShape();
//    shape.setAsEdge(start, end);
//
//    final fixtureDef = FixtureDef()
//      ..shape = shape
//      ..restitution = 0.0
//      ..friction = 0.1;
//
//    final bodyDef = BodyDef()
//      ..setUserData(this) // To be able to determine object in collision
//      ..position = Vector2.zero()
//      ..type = BodyType.STATIC;
//
//    body = world.createBody(bodyDef)..createFixtureFromFixtureDef(fixtureDef);
//  }
//}
//
