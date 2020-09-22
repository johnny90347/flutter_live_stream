import 'package:flutter_live_stream/core/services/network_service/signalr_service.dart';
import 'package:get_it/get_it.dart';
// 匯入
import 'package:flutter_live_stream/core/services/config_service/config_service.dart';
import 'package:flutter_live_stream/core/services/router_service/router_service.dart';
import 'package:flutter_live_stream/core/services/network_service/http_service.dart';

// 匯出
export 'package:flutter_live_stream/core/services/config_service/config_service.dart';
export 'package:flutter_live_stream/core/services/router_service/router_service.dart';
export 'package:flutter_live_stream/core/services/network_service/http_service.dart';

//先寫死
final ROUTE_PATH = 'http://172.24.10.63:8002/';
final USER_NAME = 'HTTW08';

// 全局的GetIt實體
GetIt locator = GetIt.instance;

// 註冊service
void setupLocator() {
  locator.registerSingleton(ConfigService());
  locator.registerSingleton(RouterService());
  locator.registerSingleton(HttpService());
  locator.registerSingleton(SignalRService());
}
