import 'package:flutter/material.dart';
import 'package:flutter_live_stream/core/controllers/live_chat_room_controller.dart';
import 'package:flutter_live_stream/models/index.dart';

/// 使用 Get.bottomSheet() 開啟
class GiftBottomSheet extends StatefulWidget {
  @override
  _GiftBottomSheetState createState() => _GiftBottomSheetState();
}

class _GiftBottomSheetState extends State<GiftBottomSheet> {
  final ctr = Get.find<LiveChatRoomController>();
  GiftDetailPart _selectedItem; // 是否有選取到



  @override
  Widget build(BuildContext context) {
    final screenMaxHeight = MediaQuery.of(context).size.height;
    final screenMaxWidth = MediaQuery.of(context).size.width;
    final giftBoxWidth = screenMaxWidth / 4; // 一排放四個禮物
    return Container(
      height: screenMaxHeight * 0.5,
      width: screenMaxWidth,
      child: Column(
        children: [
          Container(
            // 跑馬燈
            height: 25.0,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: Colors.white70),
            child: Text(
              '送礼物给你喜欢的主播吧〜',
              style: TextStyle(
                  fontSize: 10.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey.shade700),
            ),
          ),
          Expanded(
            // 禮物選單
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                width: screenMaxWidth,
                decoration: BoxDecoration(color: Colors.grey.shade100),
                child: Wrap(
                  children: ctr.gifts
                      .map((item) => InkWell(
                            onTap: () {
                              _selectedItem = item;
                              setState(() {});
                            },
                            child: Container(
                                width: giftBoxWidth,
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(bottom: 10.0),
                                child: Column(
                                  children: [
                                    Container(
                                      width: giftBoxWidth * 0.6,
                                      height: giftBoxWidth * 0.6,
                                      padding:
                                          EdgeInsets.all(giftBoxWidth * 0.05),
                                      child: Image.asset('assets/images/${item.Icon}'),
                                      decoration: _selectedItem == item // 是否有選取到
                                          ? BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.redAccent,
                                                  width: 2.0),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      giftBoxWidth * 0.6 * 0.1))
                                          : null,
                                    ),
                                    Text(
                                      item.Name,
                                      style: TextStyle(
                                          color: Colors.grey.shade700,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 12.0),
                                    ),
                                    Text(
                                      '${item.Value}',
                                      style: TextStyle(
                                          color: Color(0xffFFBC42),
                                          fontWeight: FontWeight.w700,
                                          fontSize: 12.0),
                                    ),
                                  ],
                                )),
                          ))
                      .toList(),
                ),
              ),
            ),
          ),
          Container(
            // 底部送出按鈕
            height: 60.0,
            width: screenMaxWidth,
            decoration: BoxDecoration(color: Colors.white),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 10.0),
                  height:30.0,
                  width: 60.0,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: FlatButton(
                    highlightColor: Colors.blue[700],
                    colorBrightness: Brightness.dark,
                    splashColor: Colors.grey,
                      disabledColor: Colors.grey,
                    disabledTextColor: Colors.white,
                    child: Text("送礼"),
                    shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    onPressed:_selectedItem != null ? (){
                          print(_selectedItem.Name);
                    }:null
                  ),
                )
              ],
            )
          ),
        ],
      ),
    );
  }
}
