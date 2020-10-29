import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_live_stream/core/controllers/live_chat_room_controller.dart';
import 'package:flutter_live_stream/core/services/system_info_service/system_info_service.dart';
import 'package:flutter_live_stream/shared/widgets/common_dialog_content.dart';
import 'package:flutter_live_stream/shared/widgets/gift_bottom_sheet.dart';

class RightPanel extends StatefulWidget {
  @override
  _RightPanelState createState() => _RightPanelState();
}

class _RightPanelState extends State<RightPanel> {
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
  _getBottomPanelSize() {
    Timer(Duration(milliseconds: 1000), () {
      final RenderBox object =
          _bottomPanelKey.currentContext.findRenderObject();
    });
  }

  //TODO : 可針對不同機種 加入margin bottom (避免被遮住)
  @override
  Widget build(BuildContext context) {
    final circleHeight = systemInfoService.screenMaxWidth * 0.08;
    return Container(
      key: _bottomPanelKey,
      alignment: Alignment.topCenter,
      padding:
          const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0, top: 5.0),
      child:
          Container(
            // 左邊區域 聊天,切換分流,重整,音效
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircleButton(
                  icon: Icons.textsms,
                  diameter: circleHeight,
                  onTap: () {
                    ctr.inputFocusNode.requestFocus();
                  },
                ),
                SizedBox(
                  height: circleHeight * 0.3,
                ),
                CircleButton(
                  icon: Icons.wifi,
                  diameter: circleHeight,
                  onTap: () {},
                ),
                SizedBox(
                  height: circleHeight * 0.3,
                ),
                CircleButton(
                  icon: Icons.refresh,
                  diameter: circleHeight,
                  onTap: () {},
                ),
                SizedBox(
                  height: circleHeight * 0.3,
                ),
               Obx(()=> CircleButton(
                  icon: ctr.currentVideoVolume.value != 0 ? Icons.volume_up : Icons.volume_mute,
                  diameter: circleHeight,
                  onTap: () {
                    if(ctr.currentVideoVolume.value == 0){
                      ctr.currentVideoVolume.value = 0.5;
                    }else{
                      ctr.currentVideoVolume.value = 0;
                    }
                  },
                ),),
                SizedBox(
                  height: circleHeight * 0.3,
                ),
                CircleButton(
                  icon: Icons.close,
                  diameter: circleHeight,
                  onTap: () {
                    /// 測試code
                    ctr.textNumber += 1;
                  },
                ),
                SizedBox(
                  height: circleHeight * 0.3,
                ),
                CircleButton(
                    icon: Icons.card_giftcard,
                    diameter: circleHeight,
                    btnGradientColor: pickGradient,
                    onTap: () {
                      if (ctr.gifts != null) {
                        // 禮物有內容才可以打開
                        Get.bottomSheet(GiftBottomSheet());
                      }
                    }),
              ],
            ),
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
