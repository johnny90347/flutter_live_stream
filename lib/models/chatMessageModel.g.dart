// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chatMessageModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatMessageModel _$ChatMessageModelFromJson(Map<String, dynamic> json) {
  return ChatMessageModel()
    ..MessageId = json['MessageId'] as String
    ..NickName = json['NickName'] as String
    ..Id = json['Id'] as String
    ..Level = json['Level'] as num
    ..Body = json['Body'] as String
    ..IsAnchor = json['IsAnchor'] as bool
    ..CorrelationId = json['CorrelationId'] as String;
}

Map<String, dynamic> _$ChatMessageModelToJson(ChatMessageModel instance) =>
    <String, dynamic>{
      'MessageId': instance.MessageId,
      'NickName': instance.NickName,
      'Id': instance.Id,
      'Level': instance.Level,
      'Body': instance.Body,
      'IsAnchor': instance.IsAnchor,
      'CorrelationId': instance.CorrelationId
    };
