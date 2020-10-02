import 'package:json_annotation/json_annotation.dart';

part 'chatMessageModel.g.dart';

@JsonSerializable()
class ChatMessageModel {
    ChatMessageModel();

    String MessageId;
    String NickName;
    String Id;
    num Level;
    String Body;
    bool IsAnchor;
    String CorrelationId;
    
    factory ChatMessageModel.fromJson(Map<String,dynamic> json) => _$ChatMessageModelFromJson(json);
    Map<String, dynamic> toJson() => _$ChatMessageModelToJson(this);
}
