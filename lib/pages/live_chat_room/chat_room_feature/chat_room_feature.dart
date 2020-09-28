import 'package:flutter/material.dart';
import './anchor_info/anchor_info.dart';
import './bottom_panel/bottom_panel.dart';
import './center_area/center_area.dart';

class ChatRoomFeature extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //取得statusBar的高,避開
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return Container(
      padding: EdgeInsets.all(4.0),
      child: Column(
        children: [
          SizedBox(
            height: statusBarHeight,// statusBar高
          ),
          Expanded(
            flex: 1,
            child: AnchorInfo(),// 主播資訊
          ),
          Expanded(
            flex: 14,
            child: CenterArea(),  // 中央區域 (動畫層 & 聊天區)
          ),
          Expanded(
            flex: 1, // 底部功能按鈕
            child: BottomPanel(),
          )
        ],
      ),
    );
  }
}
