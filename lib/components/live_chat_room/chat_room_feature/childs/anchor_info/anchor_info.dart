import 'dart:async';

import 'package:flutter/material.dart';

class AnchorInfo extends StatefulWidget {
  @override
  _AnchorInfoState createState() => _AnchorInfoState();
}

class _AnchorInfoState extends State<AnchorInfo> {

  var anchorInfoPageController; // 在線人數,人氣值,輪播控制器
  var _switchInfoTimer; // 切換在線人數,人氣值的timer
  int infoPageIndex = 0; // 在線人數 = 0, 人氣值 = 1

  @override
  void initState() {
    _pageControllerSetUp();
    _timerSetUp();
    super.initState();
  }

  // 在線人數,人氣值,輪播控制器 設置
  void _pageControllerSetUp() {
    anchorInfoPageController = PageController(
        initialPage: infoPageIndex, keepPage: true, viewportFraction: 1);
  }

  // 切換在線人數,人氣值的timer 設置
  void _timerSetUp() {
    // 目前設置每五秒切換一次
    _switchInfoTimer =
        Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (infoPageIndex == 0) {
        infoPageIndex = 1;
        anchorInfoPageController.animateToPage(1,
            curve: Curves.easeIn, duration: Duration(milliseconds: 1000));
      } else if (infoPageIndex == 1) {
        infoPageIndex = 2;
        anchorInfoPageController.animateToPage(2,
            curve: Curves.easeIn, duration: Duration(milliseconds: 1000));
      } else if (infoPageIndex == 2) {
        infoPageIndex = 0;
        anchorInfoPageController.jumpToPage(0);
      }
    });
  }

  @override
  void dispose() {
    anchorInfoPageController.dispose();
    _switchInfoTimer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth; // 父層寬
        final maxHeight = constraints.maxHeight; // 父層高

        const paddingValue = 2.0; // 整個主播資訊容器的padding
        const borderRadiusValue = 8.0; // 邊框圓角

        return Container(
          alignment: Alignment.centerLeft,
          child: Container(
            padding: EdgeInsets.all(paddingValue),
            width: maxWidth * 0.5,
            height: maxHeight,
            decoration: BoxDecoration(
                color: Color.fromARGB(150, 0, 0, 0),
                borderRadius: BorderRadius.circular(borderRadiusValue)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: maxHeight - paddingValue * 2,
                  width: maxHeight - paddingValue * 2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(borderRadiusValue),
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/loading.png',
                      image:
                          'https://img.zcool.cn/community/01379d567f8f126ac7251bb624a6d5.jpg@1280w_1l_2o_100sh.jpg',
                    ),
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 2.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 2.0),
                            child: FittedBox(
                              child: Text(
                                'NINI',
                                softWrap: false,
                                style: TextStyle(
                                    fontSize: 12.0, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: PageView(
                            scrollDirection: Axis.vertical,
                            controller: anchorInfoPageController,
                            children: [
                              OnlineUser(),
                              StartValue(),
                              OnlineUser(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: InkWell(
                    onTap: () {
                      print('訂閱');
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(borderRadiusValue),
                      ),
                      child: Text(
                        '关注',
                        style: TextStyle(
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w700,
                            fontSize: 12.0),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

// 線上人數
class OnlineUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Icon(
            Icons.person,
            color: Colors.yellowAccent,
            size: 15,
          ),
          SizedBox(width: 5.0),
          Expanded(
            child: Text(
              '666',
              softWrap: false,
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}

// 主播人氣
class StartValue extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Icon(
            Icons.stars,
            color: Colors.redAccent,
            size: 15,
          ),
          SizedBox(width: 5.0),
          Expanded(
            child: Text(
              '666',
              softWrap: false,
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
