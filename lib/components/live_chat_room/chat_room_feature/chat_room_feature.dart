import 'package:flutter/material.dart';

class ChatRoomFeature extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //取得statusBar的高,避開
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: statusBarHeight,
          ),
          Text('123'),
          Text('123'),
          Text('123'),
          Text('123'),
          Text('123'),
          Text('123'),
        ],
      ),
    );
  }
}
