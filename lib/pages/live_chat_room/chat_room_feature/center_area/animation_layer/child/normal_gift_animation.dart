import 'package:flutter/material.dart';

class NormalGiftAnimation extends StatefulWidget {
  @override
  _NormalGiftAnimationState createState() => _NormalGiftAnimationState();
}

class _NormalGiftAnimationState extends State<NormalGiftAnimation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          // 主播背景漸層色
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Color.fromRGBO(254, 148, 189, 1),Color.fromRGBO(94, 231, 223, .9),Colors.transparent],
            stops: [0.0, 0.4,0.8]),
      ),
      width: 200,
      height: 50,
      child: Stack(
        children: [
          Positioned(//上方白色漸層Border
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 2.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  // 主播背景漸層色
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Colors.white,Colors.white10,Colors.transparent],
                    stops: [0.3,0.6,1.0]),
              ),
            ),
          ),
          Positioned(//下方白色漸層Border
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 2.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  // 主播背景漸層色
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Colors.white,Colors.white10,Colors.transparent],
                    stops: [0.3,0.6,1.0]),
              ),
            ),
          )
        ],
      ),
    );
  }
}
