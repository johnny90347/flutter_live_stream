import 'package:flutter/material.dart';
import 'package:flutter_live_stream/core/services/service_module.dart';
import 'child/special_notice.dart';
import 'child/normal_gift_animation.dart';

class AnimationLayer extends StatelessWidget {
  final systemInfoService = Get.find<SystemInfoService>();
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
              top: constraints.maxHeight / 2,
              child: NormalGiftAnimation(), // 一般禮物-動畫
            )
          ],
        ),
      );
    });
  }
}
