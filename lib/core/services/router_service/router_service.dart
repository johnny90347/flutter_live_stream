// 套件
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:flutter_live_stream/pages/error/error.dart';
import 'package:flutter_live_stream/pages/home/home.dart';
import 'package:flutter_live_stream/pages/live_chat_room/live_chat_room.dart';
import 'package:flutter_live_stream/pages/splash/splash.dart';
import 'package:flutter_live_stream/core/bindings/live_chat_room_binding.dart';

// 路由名
const String homePath = "/home";
const String splashPath = '/splash';
const String liveChatRoomPath = '/liveChatRoom';
const String errorPath = '/error';

class RouterService extends GetxService{

  // 註冊路由
  final generateRoute = [
    GetPage(name: homePath, page: () => Home()),
    GetPage(name: splashPath, page: () => Splash()),
    GetPage(name: liveChatRoomPath, page: () => LiveChatRoom(),binding: LiveChatRoomBinding()),
    GetPage(name: errorPath,page: ()=>Error())

  ];

  // 跳轉方法
  void goToPage({@required String path,dynamic argument}) {
    switch (path) {
      case homePath:
        Get.offAllNamed(homePath,arguments: argument);
        break;
      case splashPath:
        Get.toNamed(splashPath,arguments: argument);
        break;
      case liveChatRoomPath:
        Get.toNamed(liveChatRoomPath,arguments: argument);
        break;
      case errorPath:
        Get.offAllNamed(errorPath,arguments: argument);
        break;
      default:
        break;
    }
  }

  /// service 初始化
  Future<RouterService> init() async {
    return this;
  }
}
