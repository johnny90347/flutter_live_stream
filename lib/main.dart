import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_live_stream/components/live_chat_room/live_chat_room.dart';
import 'package:flutter_live_stream/core/bindings/global_binding.dart';
import 'package:flutter_live_stream/core/services/service_module.dart';
import 'package:get/get.dart';

//APP啟動點
void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final router = locator<RouterService>();
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        theme: ThemeData(// 設定預設字體
          textTheme: GoogleFonts.zcoolXiaoWeiTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        initialBinding: GlobalBidding(),
        home: LiveChatRoom(),
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