import 'dart:async';

import 'package:flutter/material.dart';

class AnchorInfo extends StatefulWidget {
  @override
  _AnchorInfoState createState() => _AnchorInfoState();
}

class _AnchorInfoState extends State<AnchorInfo> {
  var _anchorInfoPageController; // 在線人數,人氣值,輪播控制器
  Timer _switchInfoTimer; // 切換在線人數,人氣值的timer
  int _infoPageIndex = 0; // 在線人數 = 0, 人氣值 = 1

  Timer _anchorScrollTimer; // 主播名子太長 => 開始滾
  bool _animationScrollAnchorName = false;
  double _scrollOffset = 0;
  GlobalKey _keyAnchorName = GlobalKey();
  final _anchorName = '來試試看名字太長會不會滾呢';

  @override
  void initState() {
    _pageControllerSetUp();
    _timerSetUp();
    _computedScrollNameNeeded();
    super.initState();
  }

  @override
  void dispose() {
    _anchorInfoPageController.dispose();
    _switchInfoTimer.cancel();
    _anchorScrollTimer.cancel();
    super.dispose();
  }

  // 在線人數,人氣值,輪播控制器 設置
  void _pageControllerSetUp() {
    _anchorInfoPageController = PageController(
        initialPage: _infoPageIndex, keepPage: true, viewportFraction: 1);
  }

  // 切換在線人數,人氣值的timer 設置
  void _timerSetUp() {
    // 目前設置每X秒切換一次
    _switchInfoTimer =
        Timer.periodic(const Duration(seconds: 12), (Timer timer) {
      if (_infoPageIndex == 0) {
        _infoPageIndex = 1;
        _anchorInfoPageController.animateToPage(1,
            curve: Curves.easeIn, duration: Duration(milliseconds: 800));
      } else if (_infoPageIndex == 1) {
        _infoPageIndex = 2;
        _anchorInfoPageController.animateToPage(2,
            curve: Curves.easeIn, duration: Duration(milliseconds: 800));
        Timer(Duration(milliseconds: 1200), () {
          _infoPageIndex = 0;
          _anchorInfoPageController.jumpToPage(0);
        });
      }
    });
  }

  // 計算是否主播名稱太長,讓他滾動
  void _computedScrollNameNeeded() {
    Timer(Duration(seconds: 5), () {
      _getSizesDetect();
    });
  }

  // 取得
  void _getSizesDetect() {
    final RenderBox renderAnchorNameBox =
        _keyAnchorName.currentContext.findRenderObject();
    final sizeName = renderAnchorNameBox.size;
    final fontSize = 12.0;
    final maxFittedStringLength = (sizeName.width / fontSize).truncate();

    if (_anchorName.length > maxFittedStringLength) {
      _scrollOffset = ((_anchorName.length - maxFittedStringLength) * 12)
          .toDouble(); // 每個字大小12
      _anchorScrollTimer =
          Timer.periodic(const Duration(seconds: 18), (Timer timer) {
        setState(() {
          _animationScrollAnchorName = !_animationScrollAnchorName;
        });
        // 五秒後滑回來
        Timer(Duration(seconds: 5), () {
          setState(() {
            _animationScrollAnchorName = !_animationScrollAnchorName;
          });
        });
      });
    }
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
                            key: _keyAnchorName,
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 2.0),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                AnimatedPositioned(
                                  duration: Duration(milliseconds: 1000),
                                  left: _animationScrollAnchorName
                                      ? -_scrollOffset
                                      : 0,
                                  child: Text(
                                    _anchorName,
                                    softWrap: false,
                                    style: TextStyle(
                                        fontSize: 12.0, color: Colors.white),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: PageView(
                            scrollDirection: Axis.vertical,
                            controller: _anchorInfoPageController,
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
