import 'package:flutter/material.dart';
import './anchor_info/anchor_info.dart';
import './right_panel/right_panel.dart';
import './center_area/center_area.dart';
import 'package:flutter_live_stream/core/services/service_module.dart';

class ChatRoomFeature extends StatelessWidget {

  final systemService = Get.find<SystemInfoService>();

  @override
  Widget build(BuildContext context) {
    //避開 statusBar 的高度
    double statusBarHeight = systemService.statusBarHeight;
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              SizedBox(
                height: statusBarHeight,
              ),
              AnchorInfo(),
              Expanded(
                flex: 10,
                child: CenterArea(),  // 中央區域 (動畫層 & 聊天區)
              ),

            ],
          ),
        ),
                      RightPanel(),// 底部按鈕
      ],
    );
  }
}
