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
  final systemInfoService = Get.find<SystemInfoService>();

  @override
  void initState() {
    super.initState();
    globalController.initAllRequire();
  }

  ///賦予系統資訊數值
  _getSystemInfo() {
    if (systemInfoService.screenMaxWidth == null &&
        systemInfoService.screenMaxHeight == null &&
        systemInfoService.statusBarHeight == null) {
      systemInfoService.screenMaxWidth = MediaQuery.of(context).size.width;
      systemInfoService.screenMaxHeight = MediaQuery.of(context).size.height;
      systemInfoService.statusBarHeight = MediaQuery.of(context).padding.top;
      systemInfoService.rightPanelDiameter = systemInfoService.screenMaxWidth * 0.08;
      systemInfoService.bottomSafeRetain = 10;//FIXME:到時候一照手機型號,要有不同的數值
    }
  }

  @override
  Widget build(BuildContext context) {
    _getSystemInfo();
    return Scaffold(
      appBar: AppBar(
        title: Text('Splash'),
      ),
      body: Center(
        child: Column(
          children: [
            Obx(() => Text('${globalController.loadingState.value}')),
            RaisedButton(child: Text('拿資料'), onPressed: () {}),
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
