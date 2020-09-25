import 'package:flutter/material.dart';

class BottomPanel extends StatelessWidget {
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
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            // 左邊區域 切換分流,重整,音效
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleButton(icon: Icons.wifi, diameter: maxHeight * 0.7),
                SizedBox(
                  width: maxHeight * 0.7 * 0.5,
                ),
                CircleButton(icon: Icons.refresh, diameter: maxHeight * 0.7),
                SizedBox(
                  width: maxHeight * 0.7 * 0.5,
                ),
                CircleButton(icon: Icons.volume_up, diameter: maxHeight * 0.7),
              ],
            ),
          ),
          Container(
            // 右邊區域 目前只有禮物
            child: Row(
              children: [
                CircleButton(
                  icon: Icons.card_giftcard,
                  diameter: maxHeight * 0.7,
                  btnGradientColor: pickGradient,
                ),
              ],
            ),
          )
        ],
      );
    });
  }
}

// 圓形icon按鈕 - 共用
class CircleButton extends StatelessWidget {
  final IconData icon; // icon 圖示
  final double diameter;// 直徑
  final Gradient btnGradientColor; // icon 背景漸層
  final Color iconColor ;

  static const Gradient whiteGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFFFFFFF), Color(0xFFFCFCFC)],
  );

  CircleButton(
      {@required this.icon,
      @required this.diameter,
      this.btnGradientColor = whiteGradient,
      this.iconColor = Colors.white
      });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('object');
      },
      child: Container(
        width: diameter,
        height: diameter,
        decoration: new BoxDecoration(
            shape: BoxShape.circle, gradient: btnGradientColor),
        child: Icon(
          icon,
          size: diameter / 2,
        ),
      ),
    );
  }
}
