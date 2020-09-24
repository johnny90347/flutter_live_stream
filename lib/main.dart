import 'package:flutter/material.dart';
import 'package:flutter_live_stream/components/live_chat_room/live_chat_room.dart';
import 'package:flutter_live_stream/components/splash/splash.dart';
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
      initialBinding: GlobalBidding(),
      home: Splash(),
      getPages: router.generateRoute,
    );
  }
}

//class MyApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//   final router =  locator<RouterService>();
//    return Injector(
//        inject: [Inject(() => GlobalState())],
//        builder: (context) {
//          return MaterialApp(
//            //配置路由
//            onGenerateRoute:router.generateRoute ,
//            initialRoute: splash,
//          );
//        });
//  }
//}
//
//class HomePage extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return StateBuilder<GlobalState>(
//      observe: () => RM.get<GlobalState>(),
//      builder: (context, globalState) {
//        return Scaffold(
//          body: SafeArea(
//            child: Column(
//              children: [
//                Container(
//                  child: Text('${globalState.state.getNumber}'),
//                ),
//                RaisedButton(
//                  onPressed: () => globalState.setState((s) => s.addNumber()),
//                  child: Text('按我'),
//                )
//              ],
//            ),
//          ),
//        );
//      },
//    );
//  }
//}
