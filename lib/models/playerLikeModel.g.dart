// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playerLikeModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayerLikeModel _$PlayerLikeModelFromJson(Map<String, dynamic> json) {
  return PlayerLikeModel()
    ..LikeCount = json['LikeCount'] as num
    ..StarValue = json['StarValue'] as num
    ..IsLike = json['IsLike'] as bool
    ..Level = json['Level'] as num
    ..Id = json['Id'] as String
    ..NickName = json['NickName'] as String
    ..MessageId = json['MessageId'] as String
    ..Code = json['Code'] as num
    ..CorrelationId = json['CorrelationId'] as String;
}

Map<String, dynamic> _$PlayerLikeModelToJson(PlayerLikeModel instance) =>
    <String, dynamic>{
      'LikeCount': instance.LikeCount,
      'StarValue': instance.StarValue,
      'IsLike': instance.IsLike,
      'Level': instance.Level,
      'Id': instance.Id,
      'NickName': instance.NickName,
      'MessageId': instance.MessageId,
      'Code': instance.Code,
      'CorrelationId': instance.CorrelationId
    };
