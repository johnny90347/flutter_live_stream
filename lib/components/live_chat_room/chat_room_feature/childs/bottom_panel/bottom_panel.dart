import 'package:flutter/material.dart';

class BottomPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder:  (context, constraints) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('123'),
        Text('456')
        ],
      );
      }
    );
  }
}
