import 'package:flutter_live_stream/core/services/service_module.dart';

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
      Response response = await httpService.dio.get('api/games/fish/demo/$userName');
      print(response);
    } catch (e) {
      print(e);
    }
  }
}
