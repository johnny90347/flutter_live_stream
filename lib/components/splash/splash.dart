import 'package:flutter/material.dart';
import 'package:flutter_live_stream/components/home/home.dart';
import 'package:flutter_live_stream/core/controllers/global_controller.dart';
import 'package:flutter_live_stream/core/services/service_module.dart';
// 套件
import 'package:get/get.dart';

class Splash extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<Splash> {
  final routerService = locator<RouterService>();
  final globalController = Get.find<GlobalController>();


  @override
  void initState() {
    super.initState();
    globalController.initAllRequire();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Splash'),
      ),
      body: Center(
        child: Column(
          children: [
            GetBuilder<GlobalController>(
              init: GlobalController(),
              builder: (_) {
                return Column(
                  children: [
                    Text('${_.myNumber}'),
//                    Text('${_.chatMsg}')
                    Obx(() => Text('${_.getObsNumber}')),
                  ],
                );
              },
            ),
            Obx(() => Text('${globalController.test.value.AnchorId}')),
            RaisedButton(
                child: Text('拿資料'),
                onPressed: () {
                  Get.find<GlobalController>().addNumber();
                  Get.find<GlobalController>().addObsNumber();
                }),
            RaisedButton(
                child: Text('去直播'),
                onPressed: () {
                  routerService.goToPage(path: liveChatRoomPath);
                })
          ],
        ),
      ),
    );
  }
}

//class Splash extends StatefulWidget {
//  @override
//  _SplashPageState createState() => _SplashPageState();
//}
//
//class _SplashPageState extends State<Splash> {
//  @override
//  void initState() {
//    super.initState();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text('Splash'),
//      ),
//      body: Center(
//        child: Column(
//          children: [
//            WhenRebuilder<GlobalState>(
//              observe: () => RM.get<GlobalState>(),
//              onSetState: (context, globalRM) {
//                globalRM.whenConnectionState(
//                    onIdle: () => print('Idle'),
//                    onWaiting: () => print('onWaiting'),
//                    onData: (data) => print('onData'),
//                    onError: (error) => (data) => print('onData'));
//              },
//              onIdle: () => Text('啟動頁'),
//              onWaiting: () => Text('處理中..'),
//              onData: (data) => Text('拿到了'),
//              onError: (error) => Text('...'),
//            ),
//            RaisedButton(
//                child: Text('去首頁'),
//                onPressed: () {
//                  // final routerService = locator<RouterService>();
//                  // routerService.goToPage(
//                  //     context: context, routeName: homeRoute);
//                  // 使用此方法配合"WhenRebuilder",而且必須手動按下function
//                  RM.get<GlobalState>().setState((s) => s.getLiveStreamInitInfo(), shouldAwait: true);                })
//          ],
//        ),
//      ),
//    );
//  }
//}
