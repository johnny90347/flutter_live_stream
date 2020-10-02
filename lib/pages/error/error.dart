import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Error extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 取得傳過來的參數
    final errorMsg = Get.arguments;
    return Scaffold(
        appBar: AppBar(title: Text('錯誤頁'),),
        body: Container(
          child: Text('$errorMsg'),
        ));
  }
}
