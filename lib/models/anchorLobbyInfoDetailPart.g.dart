// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anchorLobbyInfoDetailPart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnchorLobbyInfoDetailPart _$AnchorLobbyInfoDetailPartFromJson(
    Map<String, dynamic> json) {
  return AnchorLobbyInfoDetailPart()
    ..CanLike = json['CanLike'] as bool
    ..FollowCount = json['FollowCount'] as num
    ..LikeCount = json['LikeCount'] as num
    ..Name = json['Name'] as String
    ..NickName = json['NickName'] as String
    ..StarValue = json['StarValue'] as num;
}

Map<String, dynamic> _$AnchorLobbyInfoDetailPartToJson(
        AnchorLobbyInfoDetailPart instance) =>
    <String, dynamic>{
      'CanLike': instance.CanLike,
      'FollowCount': instance.FollowCount,
      'LikeCount': instance.LikeCount,
      'Name': instance.Name,
      'NickName': instance.NickName,
      'StarValue': instance.StarValue
    };
