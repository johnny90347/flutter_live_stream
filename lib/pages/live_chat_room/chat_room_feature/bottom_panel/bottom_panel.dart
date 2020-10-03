import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_live_stream/core/controllers/live_chat_room_controller.dart';
import 'package:flutter_live_stream/core/services/system_info_service/system_info_service.dart';
import 'package:flutter_live_stream/shared/widgets/gift_bottom_sheet.dart';
class BottomPanel extends StatefulWidget {

  @override
  _BottomPanelState createState() => _BottomPanelState();
}

class _BottomPanelState extends State<BottomPanel> {

  final Gradient pickGradient = LinearGradient(
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

  final ctr = Get.find<LiveChatRoomController>();
  final systemInfoService = Get.find<SystemInfoService>();
  final GlobalKey _bottomPanelKey = GlobalKey();
  var testNumber = 0;

  @override
  void initState() {
    _getBottomPanelSize();
    super.initState();
  }
  // 底部選單的高度 給到全域
  _getBottomPanelSize(){
    Timer(Duration(milliseconds: 1000), () {
      final RenderBox  object = _bottomPanelKey.currentContext.findRenderObject();
      systemInfoService.bottomPanelHeight = object.size.height;
    });
  }

  //TODO : 可針對不同機種 加入margin bottom (避免被遮住)
  @override
  Widget build(BuildContext context) {
    final circleHeight = systemInfoService.screenMaxWidth * 0.08;
    return Container(
      key: _bottomPanelKey,
      alignment: Alignment.topCenter,
        padding: const EdgeInsets.only(left: 8.0,right: 8.0,bottom: 5.0,top: 5.0),
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
                      ctr.listItems.add('item ${testNumber+=1}');
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
                      onTap: () {
                        Get.bottomSheet(
                            GiftBottomSheet()
                        );
                      }),
                ],
              ),
            )
          ],
        ),
      );
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
