import 'package:json_annotation/json_annotation.dart';

part 'anchorLobbyInfoDetailPart.g.dart';

@JsonSerializable()
class AnchorLobbyInfoDetailPart {
    AnchorLobbyInfoDetailPart();

    bool CanLike;
    num FollowCount;
    num LikeCount;
    String Name;
    String NickName;
    num StarValue;
    
    factory AnchorLobbyInfoDetailPart.fromJson(Map<String,dynamic> json) => _$AnchorLobbyInfoDetailPartFromJson(json);
    Map<String, dynamic> toJson() => _$AnchorLobbyInfoDetailPartToJson(this);
}
