import 'dart:ui';
import 'package:flame/game.dart';
import 'package:flame/flame.dart';

class DemoGame extends Game{

  // 當DemoGame被實體畫時,
  // constructor先會被執行
  // 接著執行resize (讓遊戲知道畫面大小)
  // game loop 開始
  // update被呼叫
  // render 被呼叫
  // game loop 一次結束 > 再繼續 game loop 開始...

  Size screenSize; // 螢幕大小
  double tileSize; // 一個小片的大小

  List<Fly> flies;



  DemoGame(){
    // 由於 constructor 不能async,所以init必須拉出來寫,使他resize後在執行init
    initialize();
  }

  void initialize() async {

    flies = List<Fly>(); // 給他一個空陣列

    // initialDimensions 會返回一個Future<Size>,
    // 意思是等到resize後,在執行我們要的初始化代碼
    resize(await Flame.util.initialDimensions());

    print(flies);
    print(screenSize);
  }


  // 產生fly
  void spawnFly(){
    flies.add(Fly(this,50,50));
  }

  @override
  void render(Canvas canvas) {
    // TODO: implement render

    //方形
    final Rect bgRect =  Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    final Paint bgPaint = Paint();//畫筆
    bgPaint.color = Color(0xff576574);//畫筆顏色
    canvas.drawRect(bgRect, bgPaint); // 畫出矩形

    // 把放在files內的每個fly 都拿出來執行render(也就是會畫出一隻Fly)
    flies.forEach((Fly fly) => fly.render(canvas));

  }

 // game loop
  @override
  void update(double t) {
    // TODO: implement update

    // 把放在files內的每個fly 都拿出來執行update
    flies.forEach((Fly fly) => fly.update(t));
  }

  // 每當螢幕寬高改變時會呼叫
  @override
  void resize(Size size) {
    screenSize = size; // 螢幕大小
    tileSize = screenSize.width/9;
    super.resize(size);
  }

}

//元件
class Fly{

  Rect flyRect; // 由於建立一個物件需要x,y,width,height,為了不用創立四個變數,所以用Rect 可以一次滿足
  final DemoGame game; // 遊戲的參考,之後用BaseGame應該就不需要這個東東
  Paint flyPaint;
  Fly(this.game,double x, double y){
    // rect paint 拿到最上面,是因為要在render裡面畫
    flyRect = Rect.fromLTWH(x, y, game.tileSize, game.tileSize);
    // 我們知道要畫出一個方形,必須要有畫筆
    flyPaint = Paint();
    flyPaint.color = Color(0xff6ab04c);
  }

  void render(Canvas c){
    c.drawRect(flyRect, flyPaint);
  }

  void update(double t){

  }
}