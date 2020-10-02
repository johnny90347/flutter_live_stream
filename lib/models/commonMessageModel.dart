import 'package:json_annotation/json_annotation.dart';

part 'commonMessageModel.g.dart';

@JsonSerializable()
class CommonMessageModel {
    CommonMessageModel();

    String MessageId;
    String NickName;
    String Id;
    num Level;
    String Body;
    bool IsAnchor;
    String CorrelationId;
    num GiftId;
    num StarValue;
    String GiftUrl;
    String GiftName;
    
    factory CommonMessageModel.fromJson(Map<String,dynamic> json) => _$CommonMessageModelFromJson(json);
    Map<String, dynamic> toJson() => _$CommonMessageModelToJson(this);
}
