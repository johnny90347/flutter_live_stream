//匯入
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_live_stream/core/services/service_module.dart';

//匯出
export 'package:dio/dio.dart';


// 似乎用不到
class HttpService {
  //初始設定
  Dio dio = Dio(BaseOptions(
    //TODO: baseUrl根據不同的電腦要替換(APP不懂localhost)
    baseUrl: ROUTE_PATH,
    connectTimeout: 15000,
    receiveTimeout: 15000,
  ));

  Future httpGet({@required String url}) async {
    try {
      Response resp = await dio.get(url);
      final jsonResp = json.decode(resp.toString());
      return jsonResp;
    } on DioError catch (e) {
      print(e);
    }
  }
}

// http://localhost:8002/api/games/fish/demo/HTTW01
