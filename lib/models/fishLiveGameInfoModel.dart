import 'package:json_annotation/json_annotation.dart';

part 'fishLiveGameInfoModel.g.dart';

@JsonSerializable()
class FishLiveGameInfoModel {
    FishLiveGameInfoModel();

    String Token;
    String AnchorId;
    String LobbyUrl;
    String GameUrl;
    num Code;
    
    factory FishLiveGameInfoModel.fromJson(Map<String,dynamic> json) => _$FishLiveGameInfoModelFromJson(json);
    Map<String, dynamic> toJson() => _$FishLiveGameInfoModelToJson(this);
}
