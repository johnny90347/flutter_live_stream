import 'package:flutter_live_stream/core/services/service_module.dart';
import 'package:flutter_live_stream/models/index.dart';
//套件
import 'package:get/get.dart';
// 用到這個的,都需要用到套件
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
  final httpService = locator<HttpService>();
  final signalRService = locator<SignalRService>();
  final configService = locator<ConfigService>();
  final liveStreamService = locator<LiveStreamService>();
  final chatRoomService = locator<ChatRoomService>();

  /// 屬性
  List<GiftDetailPart> gifts;
  List<VideoDetailPart> videos;
  AnchorLobbyInfoDetailPart anchorLobbyInfo;

  /// 方法
  //初始化所有需要的資料,連線
  void initAllRequire() async{
    await configService.initConfig();
    await liveStreamService.initLiveStreamConnection();
    await chatRoomService.initChatConnection();
    setupPlayerLobbyConnectListener();
    setupChatMessageListener();
    getAnchorInfo();
  }


  //建立PlayerLobby 監聽 獲得主播資訊
  void setupPlayerLobbyConnectListener(){
    liveStreamService.setupPlayerLobbyConnectListener(callback: (msg){
      // 這裡回來的msg都是list包著
      final resultMsg = PlayerLobbyConnectModel.fromJson(msg[0]);
      gifts = resultMsg.Gifts;
      videos = resultMsg.Videos;
      anchorLobbyInfo = resultMsg.AnchorLobbyInfo;
    });
  }

  // 建立聊天監聽
  void setupChatMessageListener(){
    chatRoomService.setupChatMessageListener(callBack: (msg){
      print(msg);

    });
  }

  // 取得主播資訊
  void getAnchorInfo(){
    liveStreamService.getAnchorInfo();
  }

}
