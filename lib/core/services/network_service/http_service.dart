//匯入
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_live_stream/core/services/service_module.dart';

class HttpService extends GetxService {
  //初始設定
  Dio dio = Dio(BaseOptions(
    //TODO: baseUrl根據不同的電腦要替換(APP不懂localhost)
    baseUrl: ROUTE_PATH,
    connectTimeout: 15000,
    receiveTimeout: 15000,
//    headers: {
//      Headers.contentLengthHeader: 2
//    }
  ));

  Future httpGet({@required String url}) async {
    try {
      Response resp = await dio.get(url);
      final jsonResp = json.decode(resp.toString());
      return jsonResp;
    } on DioError catch (e) {

      print('錯誤的 statusCode: ${e.response.statusCode}');
      print('錯誤 data: ${e.response.data}'); //ex:{Code: 101503, Message: Dev only => :LSG....
      print('HEADER: ${dio.options.headers}');
      //自己做一個 訊息 return 出去
      final errorMsg = e.response.data;

      return errorMsg;
    }
  }

  /// service 初始化
  Future<HttpService> init() async {
    return this;
  }
}

// http://localhost:8002/api/games/fish/demo/HTTW01
