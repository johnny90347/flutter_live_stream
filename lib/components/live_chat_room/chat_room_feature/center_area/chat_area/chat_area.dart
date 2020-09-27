import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_live_stream/components/live_chat_room/chat_room_feature/center_area/chat_area/chat_input/chat_input.dart';

class ChatArea extends StatefulWidget {
  @override
  _ChatAreaState createState() => _ChatAreaState();
}

class _ChatAreaState extends State<ChatArea> {

  FocusNode inputFocusNode; // 輸入框的聚焦

  @override
  void initState() {
    inputFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    inputFocusNode.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context,constraints){
      final maxWidth = constraints.maxWidth; // 父層寬
      final maxHeight = constraints.maxHeight; // 父層高
      return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: (){
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          height: maxHeight,
          width: maxWidth,
          child: Column(
            children: [
              Expanded(
                flex: 10,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey
                  ),
                  child: RaisedButton(
                    onPressed: (){
                      inputFocusNode.requestFocus();

                      Timer(Duration(milliseconds: 300), () {
                        final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
                        print(keyboardHeight);
                      });

                    },
                    child: Text('測試'),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.tealAccent
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.blue
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                    children: [
                      Expanded(
                        flex: 80,
                        child: TextField(
                          focusNode: inputFocusNode,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 4.0),
                              fillColor: Colors.white,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color:  Colors.grey.shade300, width: 2.5))
                          ),

                        ),
                      )
                    ],
                ),
              )],
          ),
        ),
      );
    });
  }
}
