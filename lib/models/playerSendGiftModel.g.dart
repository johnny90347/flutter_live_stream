// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playerSendGiftModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayerSendGiftModel _$PlayerSendGiftModelFromJson(Map<String, dynamic> json) {
  return PlayerSendGiftModel()
    ..Id = json['Id'] as String
    ..NickName = json['NickName'] as String
    ..MessageId = json['MessageId'] as String
    ..Code = json['Code'] as num
    ..CorrelationId = json['CorrelationId'] as String
    ..GiftId = json['GiftId'] as num
    ..StarValue = json['StarValue'] as num
    ..GiftUrl = json['GiftUrl'] as String
    ..GiftName = json['GiftName'] as String;
}

Map<String, dynamic> _$PlayerSendGiftModelToJson(
        PlayerSendGiftModel instance) =>
    <String, dynamic>{
      'Id': instance.Id,
      'NickName': instance.NickName,
      'MessageId': instance.MessageId,
      'Code': instance.Code,
      'CorrelationId': instance.CorrelationId,
      'GiftId': instance.GiftId,
      'StarValue': instance.StarValue,
      'GiftUrl': instance.GiftUrl,
      'GiftName': instance.GiftName
    };
