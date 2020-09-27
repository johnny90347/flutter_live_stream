import 'package:flutter/material.dart';


class ChatInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 80,
          child: TextField(
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
    );
  }
}
