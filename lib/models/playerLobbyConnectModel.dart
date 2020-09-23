import 'package:json_annotation/json_annotation.dart';
import "videoDetailPart.dart";
import "giftDetailPart.dart";
import "anchorLobbyInfoDetailPart.dart";
part 'playerLobbyConnectModel.g.dart';

@JsonSerializable()
class PlayerLobbyConnectModel {
    PlayerLobbyConnectModel();

    String RoomId;
    List<VideoDetailPart> Videos;
    num GiftCount;
    String Currency;
    List<GiftDetailPart> Gifts;
    AnchorLobbyInfoDetailPart AnchorLobbyInfo;
    String Id;
    String NickName;
    String MessageId;
    num Code;
    String CorrelationId;
    
    factory PlayerLobbyConnectModel.fromJson(Map<String,dynamic> json) => _$PlayerLobbyConnectModelFromJson(json);
    Map<String, dynamic> toJson() => _$PlayerLobbyConnectModelToJson(this);
}
