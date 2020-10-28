import 'package:json_annotation/json_annotation.dart';

part 'playerLikeModel.g.dart';

@JsonSerializable()
class PlayerLikeModel {
    PlayerLikeModel();

    num LikeCount;
    num StarValue;
    bool IsLike;
    num Level;
    String Id;
    String NickName;
    String MessageId;
    num Code;
    String CorrelationId;
    
    factory PlayerLikeModel.fromJson(Map<String,dynamic> json) => _$PlayerLikeModelFromJson(json);
    Map<String, dynamic> toJson() => _$PlayerLikeModelToJson(this);
}
