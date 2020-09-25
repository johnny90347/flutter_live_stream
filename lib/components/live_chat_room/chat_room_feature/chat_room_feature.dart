import 'package:flutter/material.dart';
import './childs/anchor_info/anchor_info.dart';
import './childs/bottom_panel/bottom_panel.dart';

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
            flex: 9,// 中央活動
            child: Container(
              decoration: BoxDecoration(color: Colors.greenAccent),
            ),
          ),
          Expanded(
            flex: 3, // 聊天內容
            child: Container(
              decoration: BoxDecoration(color: Colors.lightBlue),
            ),
          ),
          Expanded(
            flex: 1, //對話輸入框
            child: Container(
              decoration: BoxDecoration(color: Colors.cyan),
            ),
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
