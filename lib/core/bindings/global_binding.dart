import 'package:flutter_live_stream/core/controllers/global_controller.dart';
import 'package:flutter_live_stream/core/controllers/live_chat_room_controller.dart';

import 'package:get/get.dart';

// 依照綁定到不同的Route,如果route從Stack中被移除,被綁定中的所有controller內的變數,實體..等 都會重記憶體中被拿掉
// https://pub.dev/packages/get/versions/3.4.2

class GlobalBidding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<GlobalController>(() => GlobalController());

    // 等到開發完這頁,就要刪掉這行
    Get.lazyPut<LiveChatRoomController>(() => LiveChatRoomController());
  }
}