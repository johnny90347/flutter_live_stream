//匯入
import 'package:dio/dio.dart';
//匯出
export 'package:dio/dio.dart';

// 似乎用不到
class HttpService {
  //初始設定
  Dio dio = Dio(BaseOptions(
    //TODO: baseUrl根據不同的電腦要替換(APP不懂localhost)
    baseUrl: 'http://192.168.1.105:8002/',
    connectTimeout: 15000,
    receiveTimeout: 15000,
  ));
}

// http://localhost:8002/api/games/fish/demo/HTTW01
