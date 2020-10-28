import 'package:flutter/material.dart';
import 'package:flutter_live_stream/core/services/service_module.dart';

/// 通用的 dialog
class CommonDialogContent extends StatelessWidget {
  final systemInfoService = Get.find<SystemInfoService>();
  final String content;

  CommonDialogContent({@required this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          content,
          style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w700,
              color: Colors.black87),
        )
      ],
    );
  }
}
