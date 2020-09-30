import 'package:flutter/material.dart';



class QuickMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.0,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          MessageItem(text: '初次见面 😀',),
          MessageItem(text: '早安',),
          MessageItem(text: '主播今天特别帅 🥰',),
          MessageItem(text: '主播今天特别美',),
          MessageItem(text: '好久不见',),
          MessageItem(text: '我來幫你加油! ❤️',),
        ],
      ),
    );
  }
}


class MessageItem extends StatelessWidget {

  final text;

  MessageItem({@required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(right: 4.0),
          padding: EdgeInsets.symmetric(vertical: 3.0,horizontal: 8.0),
          decoration: BoxDecoration(
            color: Colors.black38,
            borderRadius: BorderRadius.circular(6.0)
          ),
          child: Text(text,style: TextStyle(
            fontSize: 10.0,
            color: Colors.white,
          ),),
        ),
      ],
    );
  }
}

