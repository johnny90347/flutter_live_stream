import 'package:flutter/material.dart';



class DialogDisplay extends StatelessWidget {

  final List<String> listItems = [
    '這是開頭',
    '主播好',
    '主播棒',
    '安安安安',
    '早安',
    '晚安',
    '吃飯沒',
    '主播好主播好主播好主播好主播好主播好主播好主播好主播好主播好主播好主播好主播好主播好主播好主播好主播好主播好',
    '主播棒',
    '安安安安',
    '早安',
    '晚安',
    '吃飯沒',
    '這是結尾'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 5.0),
      child: ListView.builder(
        reverse: true,
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        itemCount: listItems.length,
          itemBuilder: (context,index){
        return Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.record_voice_over),
              Expanded(child: Text('${listItems[index]}')),
            ],
          ),
        );
      }),
    );
  }
}

