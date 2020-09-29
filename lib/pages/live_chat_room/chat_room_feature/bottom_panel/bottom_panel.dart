import 'package:flutter/material.dart';
import 'package:flutter_live_stream/core/controllers/live_chat_room_controller.dart';
class BottomPanel extends StatelessWidget {

  final ctr = Get.find<LiveChatRoomController>();

  // 粉色
  static const Gradient pickGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color.fromARGB(255, 203, 50, 168),
      Color.fromARGB(
        255,
        224,
        112,
        91,
      )
    ],
  );
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final maxHeight = constraints.maxHeight;
      final circleHeight = maxHeight * 0.6;
      ctr.bottomPanelHeight = maxHeight;
      return Container(
        padding: EdgeInsets.only(left: 8.0,right: 8.0,bottom: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              // 左邊區域 聊天,切換分流,重整,音效
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleButton(
                    icon: Icons.textsms,
                    diameter: circleHeight,
                    onTap: () {
                      ctr.openChatInput.value = true;
                    },
                  ),
                  SizedBox(
                    width: circleHeight * 0.3,
                  ),
                  CircleButton(
                    icon: Icons.wifi,
                    diameter: circleHeight,
                    onTap: () {},
                  ),
                  SizedBox(
                    width: circleHeight * 0.3,
                  ),
                  CircleButton(
                    icon: Icons.refresh,
                    diameter: circleHeight,
                    onTap: () {},
                  ),
                  SizedBox(
                    width: circleHeight * 0.3,
                  ),
                  CircleButton(
                    icon: Icons.volume_up,
                    diameter: circleHeight,
                    onTap: () {},
                  ),
                  SizedBox(
                    width: circleHeight * 0.3,
                  ),
                  CircleButton(
                    icon: Icons.center_focus_strong,
                    diameter: circleHeight,
                    onTap: () {
                      ctr.listItems.add('item');
                    },
                  ),
                ],
              ),
            ),
            Container(
              // 右邊區域 目前只有禮物
              child: Row(
                children: [
                  CircleButton(
                      icon: Icons.card_giftcard,
                      diameter: circleHeight,
                      btnGradientColor: pickGradient,
                      onTap: () {}),
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}

// 圓形icon按鈕 - 共用
class CircleButton extends StatelessWidget {
  final IconData icon; // icon 圖示
  final double diameter; // 直徑
  final Gradient btnGradientColor; // icon 背景漸層
  final Color iconColor;
  final Function onTap;

  static const Gradient whiteGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFFFFFFF), Color(0xFFFCFCFC)],
  );

  CircleButton(
      {@required this.icon,
      @required this.diameter,
      @required this.onTap,
      this.btnGradientColor = whiteGradient,
      this.iconColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: diameter,
        height: diameter,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: btnGradientColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 0.5,
                blurRadius: 0.5,
                offset: Offset(0.5, 0.5),
              )
            ]),
        child: Icon(
          icon,
          size: diameter / 2,
        ),
      ),
    );
  }
}
