/// 送禮回應code
class SendGiftRespCode {
  static const int success = 0;
  static const int noBalance = 204500;
  static const int noAnchor = 201500;
  static const int playerCanNotSendGift = 203401;
}
/// 禮物命令
class GiftCommand{
  static const String toShow = 'toShow'; //展示
  static const String toHidden = 'toHidden';//隱藏
}
/// 禮物視窗狀態
class GiftViewState{
  static const String show = 'show'; //展示
  static const String hidden = 'hidden';//隱藏
  static const String onProcess = 'onProcess';//處理中
}