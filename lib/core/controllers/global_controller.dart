import 'package:flutter_live_stream/core/services/service_module.dart';
import 'package:flutter_live_stream/models/index.dart';
//套件
import 'package:get/get.dart';
export 'package:get/get.dart';

class GlobalController extends GetxController {
  // 測試用資料
  int myNumber = 0;
  RxString obsNumber = 'johnny'.obs;
  var chatMsg = '還沒收到'.obs;
  Rx<LoginInfoModel> test = LoginInfoModel().obs; //自定義就這樣寫
  get getObsNumber => obsNumber;

  void addNumber() {
    myNumber++;
    update();
  }

  void addObsNumber(){
   obsNumber.value = 'lhlhlh';
  }


  // 測試用資料


  /// 注入服務
  final httpService = Get.find<HttpService>();
  final signalRService = Get.find<SignalRService>();
  final configService = Get.find<ConfigService>();
  final liveStreamService = Get.find<LiveStreamService>();
  final chatRoomService = Get.find<ChatRoomService>();



  /// 方法
  //初始化所有需要的資料,連線
  void initAllRequire() async{
    final result = await configService.initConfig();

    if(result == 'success'){
      print('config資料拿完了');
    }
  }




}
