import 'package:flutter/material.dart';
import 'package:flutter_live_stream/core/controllers/live_chat_room_controller.dart';
import 'package:flutter_live_stream/core/services/service_module.dart';
import 'package:flutter_live_stream/pages/live_chat_room/chat_room_feature/center_area/animation_layer/child/normal_gift_container.dart';
import 'child/special_notice.dart';
import 'child/normal_gift_animation.dart';

class AnimationLayer extends StatelessWidget {
  final systemInfoService = Get.find<SystemInfoService>();
  final ctr = Get.find<LiveChatRoomController>();
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        child: Stack(
          children: [
            Positioned(
              top: 5,
              left: 5,
              child: SpecialNotice(), // 特殊通知
            ),
            Positioned(
              left: 0,
              bottom: constraints.maxHeight / 2 - 50, // 50是一般動畫空間的一半
              child: NormalGiftView(), // 一般禮物-動畫
            )
          ],
        ),
      );
    });
  }
}
