import 'package:flutter_live_stream/core/controllers/live_chat_room_controller.dart';
import 'package:get/get.dart';

class LiveChatRoomBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<LiveChatRoomController>(() => LiveChatRoomController());
  }
}