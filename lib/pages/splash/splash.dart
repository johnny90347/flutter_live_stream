import 'package:flutter/material.dart';
import 'package:flutter_live_stream/core/controllers/global_controller.dart';
import 'package:flutter_live_stream/core/services/service_module.dart';
// 套件
// import 'package:get/get.dart';

class Splash extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<Splash> {
  final routerService = Get.find<RouterService>();
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
            Obx(() => Text('${globalController.loadingState.value}')),
            RaisedButton(
                child: Text('拿資料'),
                onPressed: () {
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
