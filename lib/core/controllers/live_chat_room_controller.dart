//套件
import 'package:get/get.dart';
export 'package:get/get.dart';



class LiveChatRoomController extends GetxController {


  /// 系統資料
  double bottomPanelHeight; // 底部按鈕的高

  /// 屬性
  RxBool openChatInput  = false.obs;


  ///測試資料
  RxList<String> listItems = [
    '這是開頭',
    '主播好',
    '主播棒',
    '安安安安',
    '早安',
    '晚安',
    '吃飯沒',
    '主播好主播好主播好主播好主播好主播好主播好主播好主播好主播好主播好主播好主播好主播好主播好主播好主播好主播好',
    '主播棒',
    '安安安安',
    '早安',
    '晚安',
    '吃飯沒',
    '這是結尾'
  ].obs;

}