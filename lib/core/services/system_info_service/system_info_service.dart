// 套件
import 'package:get/get.dart';

class SystemInfoService extends GetxService{

  /// 系統資料
  double screenMaxHeight;// 螢幕最大高度-直立
  double screenMaxWidth; // 螢幕最大寬度-直立
  double bottomPanelHeight; // 底部按鈕面版的高
  double statusBarHeight; // statusBar的高


  /// service 初始化
  Future<SystemInfoService> init() async {
    return this;
  }
}