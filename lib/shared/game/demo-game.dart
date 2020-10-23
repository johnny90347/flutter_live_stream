import 'dart:ui';
import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'dart:math';
import 'package:flame/sprite.dart';

import 'package:flame/gestures.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_live_stream/pages/home/home.dart'; // 取隨機數

enum View { home, playing, lost }

class DemoGame extends Game with TapDetector {
  // 當DemoGame被實體畫時,
  // constructor先會被執行
  // 接著執行resize (讓遊戲知道畫面大小)
  // game loop 開始
  // update被呼叫
  // render 被呼叫
  // game loop 一次結束 > 再繼續 game loop 開始...

  Size screenSize; // 螢幕大小
  double tileSize; // 一個小片的大小

  List<Fly> flies; // 裝fly的容器
  Random random; //隨機實體

  Backyard background; // 背景

  View activeView = View.home; //目前在哪一個頁面
  HomeView homeView; //首頁
  StartButton startButton; //開始按鈕

  bool isHandled = false; //避免按下開始按鈕，又正好點到蒼蠅

  DemoGame() {
    // 由於 constructor 不能async,所以init必須拉出來寫,使他resize後在執行init
    initialize();
  }

  void initialize() async {
    flies = List<Fly>(); // 給他一個空陣列
    random = Random(); // 隨機
    // initialDimensions 會返回一個Future<Size>,
    // 意思是等到resize後,在執行我們要的初始化代碼
    resize(await Flame.util.initialDimensions());

    background = Backyard(this);
    homeView = HomeView(this);
    startButton = StartButton(this);
    spawnFly();
  }

  // 產生fly
  void spawnFly() {
    // nextDouble 隨機產生 0~1的double
    double x = random.nextDouble() * (screenSize.width - tileSize);
    double y = random.nextDouble() * (screenSize.height - tileSize);

    // 目前有兩種蒼蠅,所以我們隨機加入蒼蠅
    switch (random.nextInt(1)) {
      case 0:
        flies.add(HouseFly(this, x, y));
        break;
      case 1:
        flies.add(DroolerFly(this, x, y));
        break;
    }
  }

  @override
  void render(Canvas canvas) {
    // TODO: implement render
    background.render(canvas); //別忘了要把canvas

    //方形
    final Rect bgRect =
        Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    final Paint bgPaint = Paint(); //畫筆
    bgPaint.color = Color(0xff576574); //畫筆顏色
//    canvas.drawRect(bgRect, bgPaint); // 畫出矩形

    // 把放在files內的每個fly 都拿出來執行render(也就是會畫出一隻Fly)
    flies.forEach((Fly fly) => fly.render(canvas));

    // 如果現在的view 是HomeView => 顯示homeView
    if (activeView == View.home) {
      homeView.render(canvas);
    }

    // view 是 homeView 或者 輸掉,都要顯示開始按鈕
    if(activeView == View.home || activeView == View.lost){
      startButton.render(canvas);
    }


  }

  // game loop
  @override
  void update(double t) {
    // TODO: implement update

    // 把放在files內的每個fly 都拿出來執行update
    flies.forEach((Fly fly) => fly.update(t));

    // removeWhere 如果是return true 的,會被刪掉
    flies.removeWhere((Fly fly) => fly.isOffscreen);
  }

  // 每當螢幕寬高改變時會呼叫
  @override
  void resize(Size size) {
    screenSize = size; // 螢幕大小
    tileSize = screenSize.width / 9;
    super.resize(size);
  }

  // 按下
  @override
  void onTapDown(TapDownDetails details) {
    // 如果點擊到的位置,是有包括這個fly了話,執行onTapDown
    if(!isHandled){
      flies.forEach((Fly fly) {
        if (fly.flyRect.contains(details.globalPosition)) {
          fly.onTapDown();
          isHandled = true;
        }
      });
    }

    if(!isHandled && startButton.rect.contains(details.globalPosition)){
      if(activeView == View.home || activeView == View.lost){
        startButton.onTapDown();
        isHandled = true;
      }
    }


    super.onTapDown(details);
  }
}

// 蒼蠅super元件
class Fly {
  Rect flyRect; // 由於建立一個物件需要x,y,width,height,為了不用創立四個變數,所以用Rect 可以一次滿足
  final DemoGame game; // 遊戲的參考,之後用BaseGame應該就不需要這個東東
  Paint flyPaint;
  bool isDead = false; //死掉了
  bool isOffscreen = false; //超出螢幕了

  List<Sprite> flyingSprite;
  Sprite deadSprite;
  double flyingSpriteIndex = 0;

  double get speed => game.tileSize * 3; // 初始速度大約設定是兩秒多可飛過螢幕
  Offset targetLocation; // 設置一個目標,讓蒼蠅飛到目標後,可以換方向

  Fly(this.game) {
    // rect paint 拿到最上面,是因為要在render裡面畫
//    flyRect = Rect.fromLTWH(x, y, game.tileSize, game.tileSize);
    // 我們知道要畫出一個方形,必須要有畫筆
//    flyPaint = Paint();
//    flyPaint.color = Color(0xff6ab04c);

    setTargetLocation();
  }

  void render(Canvas c) {
//    c.drawRect(flyRect, flyPaint);
    if (isDead) {
      deadSprite.renderRect(c, flyRect.inflate(2)); // 畫出來的蒼蠅,要比rect 從中央膨漲兩倍
    } else {
      flyingSprite[flyingSpriteIndex.toInt()].renderRect(c, flyRect.inflate(2));
      // 這裡要不停地選染0,1幀,來製造動畫的效果,如何讓他一直切換0-1 是靠update去一直改變他的數字
    }
  }

  // t = 0.01666..
  void update(double t) {
    // 如果死掉了
    if (isDead) {
      // 因為Rect 是 immutable,所以不能直接更改他的x,y座標,
      // 但可以藉由translate做到
      flyRect = flyRect.translate(0, game.tileSize * 12 * t);
    } else {
      // 文黨說,此變量在患染過程會變轉int,並用此值,去渲染要顯示的楨
      flyingSpriteIndex += 30 * t;
      if (flyingSpriteIndex >= 2) {
        flyingSpriteIndex -= 2;
      }

      double stepDistance = speed * t; // 我每幀可以跑多少距離
      Offset toTarget =
          targetLocation - Offset(flyRect.left, flyRect.top); // 目標跟蒼蠅的Offset
      if (stepDistance < toTarget.distance) {
        // 代表還沒到這個offset
        Offset stepToTarget =
            Offset.fromDirection(toTarget.direction, stepDistance);
        flyRect = flyRect.shift(stepToTarget);
      } else {
        flyRect = flyRect.shift(toTarget); //抵達了
        setTargetLocation(); // 再生一個目標給他飛
      }
    }

    // 如果超出螢幕
    if (flyRect.top > game.screenSize.height) {
      isOffscreen = true;
    }
  }

  void setTargetLocation() {
    double x =
        game.random.nextDouble() * (game.screenSize.width - game.tileSize);
    double y =
        game.random.nextDouble() * (game.screenSize.height - game.tileSize);
    targetLocation = Offset(x, y);
    // 為什麼要用Offset,文件上說,因為Offset有些好用的 方法ex:calculating the direction, distance, scaling, and subtracting.
  }

  // 被滑鼠點到
  void onTapDown() {
    flyPaint.color = Color(0xffff4757);
    isDead = true;
    game.spawnFly();
  }
}

//蒼蠅subClass -1
class HouseFly extends Fly {
  // super 的意思是 跑superClass的constructor
  HouseFly(DemoGame game, double x, double y) : super(game) {
    flyingSprite = List<Sprite>(); // 由於是subClass,所以當然可以使用super的屬性跟方法
    flyingSprite.add(Sprite('games/flies/house-fly-1.png'));
    flyingSprite.add(Sprite('games/flies/house-fly-2.png'));
    deadSprite = Sprite('games/flies/house-fly-dead.png');

    // 把本來在fly實作的 rect 搬來這做,這樣可以做不同大小的蒼蠅
    flyRect = Rect.fromLTWH(x, y, game.tileSize, game.tileSize);
  }
}

//蒼蠅subClass -2
class DroolerFly extends Fly {
  DroolerFly(DemoGame game, double x, double y) : super(game) {
    flyingSprite = List<Sprite>();
    flyingSprite.add(Sprite('games/flies/drooler-fly-1.png'));
    flyingSprite.add(Sprite('games/flies/drooler-fly-2.png'));
    deadSprite = Sprite('games/flies/drooler-fly-dead.png');
    // 把本來在fly實作的 rect 搬來這做,可以做不同大小的蒼蠅 (如果你需要了話)
    flyRect = Rect.fromLTWH(x, y, game.tileSize, game.tileSize);
  }
}

// 背景元件
class Backyard {
  final DemoGame game;
  Sprite bgSprite;
  Rect bgRect;

  Backyard(this.game) {
    bgSprite = Sprite('games/bg/backyard.png');
    bgRect = Rect.fromLTWH(
        0,
        game.screenSize.height - (game.tileSize * 23), //由下往上算23個tile
        game.tileSize * 9,
        game.tileSize * 23);
// 因為這張bg是1080*2760
//    1080 pixels ÷ 9 tiles = 120 pixels per tile
//    2760 pixels ÷ 120 pixels per tile = 23 tiles
  }

  void render(Canvas c) {
    //然後把bgSprite render在這個rect上
    bgSprite.renderRect(c, bgRect);
  }

  void update(double t) {}
}

class HomeView {
  final DemoGame game;
  Rect titleRect;
  Sprite titleSprite;
  HomeView(this.game) {
    titleRect = Rect.fromLTWH(
        game.tileSize,
        (game.screenSize.height / 2) - (game.tileSize * 4),
        game.tileSize * 7,
        game.tileSize * 4);
    titleSprite = Sprite('games/branding/title.png');
  }
  void render(Canvas c) {
    titleSprite.renderRect(c, titleRect);
  }

  void update(double t) {}
}

//開始按鈕
class StartButton {
  final DemoGame game;
  Rect rect;
  Sprite sprite;

  StartButton(this.game) {
    rect = Rect.fromLTWH(
        game.tileSize * 1.5,
        (game.screenSize.height * .75) - (game.tileSize * 1.5),
        game.tileSize * 6,
        game.tileSize * 3);
    sprite = Sprite('games/ui/start-button.png');
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);
  }
  void update(double t) {}
  void onTapDown() {
    game.activeView = View.playing;
  }
}
