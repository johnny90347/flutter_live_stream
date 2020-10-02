// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commonMessageModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommonMessageModel _$CommonMessageModelFromJson(Map<String, dynamic> json) {
  return CommonMessageModel()
    ..MessageId = json['MessageId'] as String
    ..NickName = json['NickName'] as String
    ..Id = json['Id'] as String
    ..Level = json['Level'] as num
    ..Body = json['Body'] as String
    ..IsAnchor = json['IsAnchor'] as bool
    ..CorrelationId = json['CorrelationId'] as String
    ..GiftId = json['GiftId'] as num
    ..StarValue = json['StarValue'] as num
    ..GiftUrl = json['GiftUrl'] as String
    ..GiftName = json['GiftName'] as String;
}

Map<String, dynamic> _$CommonMessageModelToJson(CommonMessageModel instance) =>
    <String, dynamic>{
      'MessageId': instance.MessageId,
      'NickName': instance.NickName,
      'Id': instance.Id,
      'Level': instance.Level,
      'Body': instance.Body,
      'IsAnchor': instance.IsAnchor,
      'CorrelationId': instance.CorrelationId,
      'GiftId': instance.GiftId,
      'StarValue': instance.StarValue,
      'GiftUrl': instance.GiftUrl,
      'GiftName': instance.GiftName
    };
