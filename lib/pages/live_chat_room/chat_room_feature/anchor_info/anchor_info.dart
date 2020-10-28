import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_live_stream/core/controllers/live_chat_room_controller.dart';
import 'package:flutter_live_stream/core/services/service_module.dart';

class AnchorInfo extends StatefulWidget {
  @override
  _AnchorInfoState createState() => _AnchorInfoState();
}

class _AnchorInfoState extends State<AnchorInfo> {
  final ctr = Get.find<LiveChatRoomController>();
  final systemInfoService = Get.find<SystemInfoService>();
  final configService = Get.find<ConfigService>();

  var _anchorInfoPageController; // 在線人數,人氣值,輪播控制器
  Timer _switchInfoTimer; // 切換在線人數,人氣值的timer
  int _infoPageIndex = 0; // 在線人數 = 0, 人氣值 = 1

  Timer _anchorScrollTimer; // 主播名子太長 => 開始滾
  bool _animationScrollAnchorName = false; // 開始滾動名稱
  double _scrollOffset = 0; // 計算後需要滾動的距離
  GlobalKey _keyAnchorName = GlobalKey(); //目的:方便取得空間寬度

  @override
  void initState() {
    _pageControllerSetUp();
    _timerSetUp();
    _listenAnchorLobbyInfo();
    super.initState();
  }

  @override
  void dispose() {
    _anchorInfoPageController.dispose();
    _switchInfoTimer.cancel();
    _anchorScrollTimer.cancel();
    super.dispose();
  }

  /// 在線人數,人氣值,輪播控制器 設置
  void _pageControllerSetUp() {
    _anchorInfoPageController = PageController(
        initialPage: _infoPageIndex, keepPage: true, viewportFraction: 1);
  }

  /// 切換在線人數,人氣值的timer 設置
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

  ///監聽主播資訊
  void _listenAnchorLobbyInfo() {
    ctr.anchorNickName.listen((anchorNickName) {
      _computedScrollNameNeeded(name: anchorNickName);
    });
  }

  /// 計算是否主播名稱太長,讓他滾動
  void _computedScrollNameNeeded({@required String name}) {
    final RenderBox renderAnchorNameBox =
        _keyAnchorName.currentContext.findRenderObject();
    final sizeName = renderAnchorNameBox.size;
    final fontSize = 13.0;
    final maxFittedStringLength = (sizeName.width / fontSize).truncate();

    if (name.length > maxFittedStringLength) {
      print('名字需要滾動');
      _scrollOffset = ((name.length - maxFittedStringLength) * fontSize)
          .toDouble(); // 每個字大小14
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
      return;
    }
    print('名字不需滾動');
  }

  @override
  Widget build(BuildContext context) {
    final maxWidth = systemInfoService.screenMaxWidth;
    const containerHeight = 45.0;
    const paddingValue = 4.0; // 整個主播資訊容器的padding
    const borderRadiusValue = 12.0; // 邊框圓角
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(left: 8.0, top: 8.0),
      child: Container(
        padding: const EdgeInsets.all(paddingValue),
        width: maxWidth * 0.45,
        height: containerHeight,
        decoration: BoxDecoration(
            color: Colors.black45,
            borderRadius: BorderRadius.circular(borderRadiusValue)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: containerHeight - paddingValue * 2,
              width: containerHeight - paddingValue * 2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(borderRadiusValue),
                child: Obx(
                  () => ctr.anchorName.value != ''
                      ? FadeInImage.assetNetwork(
                          placeholder: 'assets/images/default-avator.jpg',
                          image:
                              '${configService.cdnUrl}${ctr.anchorName.value}_m.jpg',
                        )
                      : Image.asset('assets/images/default-avator.jpg'),
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 2.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        key: _keyAnchorName,
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(left: 2.0),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            AnimatedPositioned(
                                duration: Duration(milliseconds: 1000),
                                left: _animationScrollAnchorName
                                    ? -_scrollOffset
                                    : 0,
                                child: Obx(
                                  () => Text(
                                    ctr.anchorNickName.value,
                                    softWrap: false,
                                    style: TextStyle(
                                        fontSize: 12.0, color: Colors.white),
                                  ),
                                ))
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
              child: Obx(() => ctr.anchorCanLike.value
                  ? FollowButton(
                      borderRadius: borderRadiusValue,
                      title: '关注',
                      onTap: () {
                        // 關注主播
                        ctr.sendLikeAnchor();
                      },
                    )
                  : FollowButton(
                      borderRadius: borderRadiusValue,
                      title: '取消',
                      onTap: () {
                        // 關注主播
                        ctr.sendUnlikeAnchor();
                      },
                    )),
            ),
          ],
        ),
      ),
    );
  }
}

// 線上人數
class OnlineUser extends StatelessWidget {
  final ctr = Get.find<LiveChatRoomController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Icon(
            Icons.person,
            color: Colors.yellowAccent,
            size: 12,
          ),
          SizedBox(width: 5.0),
          Expanded(
            child: Obx(
              () => Text(
                '${ctr.anchorFollowCount.value}',
                softWrap: false,
                style: TextStyle(
                    fontSize: 10.0, color: Colors.white, letterSpacing: 1.0),
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
  final ctr = Get.find<LiveChatRoomController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Icon(
            Icons.stars,
            color: Colors.redAccent,
            size: 12,
          ),
          SizedBox(width: 5.0),
          Expanded(
            child: Obx(
              () => Text(
                '${ctr.anchorStarValue.value}',
                softWrap: false,
                style: TextStyle(
                    fontSize: 10.0, color: Colors.white, letterSpacing: 1.0),
              ),
            ),
          )
        ],
      ),
    );
  }
}

/// 關注 or 取消關注按鈕
class FollowButton extends StatelessWidget {
  final double borderRadius;
  final String title;
  final Function onTap;

  FollowButton(
      {@required this.borderRadius,
      @required this.title,
      @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Text(
          title,
          style: TextStyle(
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w700,
              fontSize: 12.0),
        ),
      ),
    );
  }
}
