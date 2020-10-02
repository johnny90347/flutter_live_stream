import 'package:flutter/material.dart';
import 'package:flutter_live_stream/pages/splash/splash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_live_stream/pages/live_chat_room/live_chat_room.dart';
import 'package:flutter_live_stream/core/bindings/global_binding.dart';
import 'package:flutter_live_stream/core/services/service_module.dart';
import 'package:get/get.dart';

//APP啟動點
void main() async  {
  // setupLocator();
  await initServices();
  runApp(MyApp());
}

Future<void> initServices() async {
  print('starting services ...');
  await Get.putAsync(() => RouterService().init());
  await Get.putAsync(() => HttpService().init());
  await Get.putAsync(() => ConfigService().init());
  await Get.putAsync(() => SignalRService().init());
  await Get.putAsync(() => ChatRoomService().init());
  await Get.putAsync(() => LiveStreamService().init());
  print('All services started...');
}

//   locator.registerSingleton(RouterService());
//   locator.registerSingleton(HttpService());
//   locator.registerSingleton(ConfigService());
//   locator.registerSingleton(SignalRService());
//   locator.registerSingleton(ChatRoomService());
//   locator.registerSingleton(LiveStreamService());



class MyApp extends StatelessWidget {
  // final router = locator<RouterService>();
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