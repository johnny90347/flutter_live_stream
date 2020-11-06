//套件
import 'package:get/get.dart';
export 'package:get/get.dart';
// 匯入
import 'package:flutter_live_stream/core/services/config_service/config_service.dart';
import 'package:flutter_live_stream/core/services/router_service/router_service.dart';
import 'package:flutter_live_stream/core/services/network_service/http_service.dart';
import 'package:flutter_live_stream/core/services/network_service/signalr_service.dart';
import 'package:flutter_live_stream/core/services/chat_room_service/chat_room_service.dart';
import 'package:flutter_live_stream/core/services/live_stream_service/live_stream_service.dart';
import 'package:flutter_live_stream/core/services/system_info_service/system_info_service.dart';
// 匯出
export 'package:flutter_live_stream/core/services/config_service/config_service.dart';
export 'package:flutter_live_stream/core/services/router_service/router_service.dart';
export 'package:flutter_live_stream/core/services/network_service/http_service.dart';
export 'package:flutter_live_stream/core/services/network_service/signalr_service.dart';
export 'package:flutter_live_stream/core/services/chat_room_service/chat_room_service.dart';
export 'package:flutter_live_stream/core/services/live_stream_service/live_stream_service.dart';
export 'package:flutter_live_stream/core/services/system_info_service/system_info_service.dart';

//先寫死
final ROUTE_PATH = 'http://172.24.90.101:8002/';
final USER_NAME = 'HTTW02';

// 全部Service 初始化
Future<void> initServices() async {
  await Get.putAsync(() => SystemInfoService().init());
  await Get.putAsync(() => RouterService().init());
  await Get.putAsync(() => HttpService().init());
  await Get.putAsync(() => ConfigService().init());
  await Get.putAsync(() => SignalRService().init());
  await Get.putAsync(() => ChatRoomService().init());
  await Get.putAsync(() => LiveStreamService().init());
}