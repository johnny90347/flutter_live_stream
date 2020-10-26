// 套件
import 'package:flutter/services.dart';
import 'package:flutter_live_stream/shared/game/demo-game.dart';
import 'package:flutter_live_stream/shared/game/game.dart';
import 'package:flutter_live_stream/shared/game/simpleGame.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
//import 'package:flame/util.dart';
//import 'package:flame/flame.dart';

import 'package:flutter/material.dart';
import 'package:flutter_live_stream/pages/splash/splash.dart';
import 'package:flutter_live_stream/pages/live_chat_room/live_chat_room.dart';
import 'package:flutter_live_stream/core/bindings/global_binding.dart';
import 'package:flutter_live_stream/core/services/service_module.dart';
import 'package:flutter_live_stream/shared/game/slot-game-scene.dart';
import 'package:flutter_live_stream/shared/game/simpleGame.dart';


//APP啟動點
void main() async  {
  // 初始化所有Service
  await initServices();
  // 遊戲

//  WidgetsFlutterBinding.ensureInitialized();
//   Util flameUtil = Util();
//   await flameUtil.fullScreen();
//   await flameUtil.setOrientation(DeviceOrientation.portraitUp);
//  final DemoGame game = DemoGame();

  //預載入資源
//  Flame.images.loadAll(<String>[
//    'games/bg/backyard.png',
//    'games/flies/agile-fly-1.png',
//    'games/flies/agile-fly-2.png',
//    'games/flies/agile-fly-dead.png',
//    'games/flies/drooler-fly-1.png',
//    'games/flies/drooler-fly-2.png',
//    'games/flies/drooler-fly-dead.png',
//    'games/flies/house-fly-1.png',
//    'games/flies/house-fly-2.png',
//    'games/flies/house-fly-dead.png',
//    'games/flies/hungry-fly-1.png',
//    'games/flies/hungry-fly-2.png',
//    'games/flies/hungry-fly-dead.png',
//    'games/flies/macho-fly-1.png',
//    'games/flies/macho-fly-2.png',
//    'games/flies/macho-fly-dead.png',
//    'games/bg/lose-splash.png',
//    'games/branding/title.png',
//    'games/ui/dialog-credits.png',
//    'games/ui/dialog-help.png',
//    'games/ui/icon-credits.png',
//    'games/ui/icon-help.png',
//    'games/ui/start-button.png',
//  ]);

//  runApp(game.widget);
  runApp(MyApp());

}


class MyApp extends StatelessWidget {
  final router = Get.find<RouterService>();
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        theme: ThemeData(// 設定預設字體
          textTheme: GoogleFonts.notoSansTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        initialBinding: GlobalBidding(),
        defaultTransition: Transition.native,
        home: Splash(),
        getPages: router.generateRoute,
        builder: (context, child) {
          //讓字體不受外部影響
          return MediaQuery(
            child: child,
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          );
        });
  }
}