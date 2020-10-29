import 'package:json_annotation/json_annotation.dart';

part 'playerSendGiftModel.g.dart';

@JsonSerializable()
class PlayerSendGiftModel {
    PlayerSendGiftModel();

    String Id;
    String NickName;
    String MessageId;
    num Code;
    String CorrelationId;
    num GiftId;
    num StarValue;
    String GiftUrl;
    String GiftName;
    
    factory PlayerSendGiftModel.fromJson(Map<String,dynamic> json) => _$PlayerSendGiftModelFromJson(json);
    Map<String, dynamic> toJson() => _$PlayerSendGiftModelToJson(this);
}
