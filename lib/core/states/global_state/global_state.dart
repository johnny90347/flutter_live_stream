import 'dart:convert';

import 'package:flutter_live_stream/core/services/service_module.dart';
import 'package:flutter_live_stream/models/index.dart';

class GlobalState {
  int _myNumber = 0;

  int get getNumber => _myNumber;

  void addNumber() {
    _myNumber++;
    print(_myNumber);
  }


  // 取得玩家登入資訊(第一步)
  void getLoginInfo() async{
    final httpService = locator<HttpService>();
    final userName = 'HTTW08';
    
    try {
      Response resp = await httpService.dio.get('api/games/fish/demo/$userName');
      final jsonResp = json.decode(resp.toString());
     final result = LoginInfoModel.fromJson(jsonResp);
     print(result.AnchorId);
     print(result.Token);
    } catch (e) {
      print(e);
    }
  }
}
