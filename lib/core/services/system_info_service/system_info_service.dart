// 套件
import 'package:get/get.dart';

class SystemInfoService extends GetxService{

  /// 系統資料
  double screenMaxHeight;// 螢幕最大高度-直立
  double screenMaxWidth; // 螢幕最大寬度-直立
  double statusBarHeight; // statusBar的高
  double rightPanelDiameter;// 右側按鈕的直徑


  /// service 初始化
  Future<SystemInfoService> init() async {
    return this;
  }
}