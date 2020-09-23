// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playerLobbyConnectModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayerLobbyConnectModel _$PlayerLobbyConnectModelFromJson(
    Map<String, dynamic> json) {
  return PlayerLobbyConnectModel()
    ..RoomId = json['RoomId'] as String
    ..Videos = (json['Videos'] as List)
        ?.map((e) => e == null
            ? null
            : VideoDetailPart.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..GiftCount = json['GiftCount'] as num
    ..Currency = json['Currency'] as String
    ..Gifts = (json['Gifts'] as List)
        ?.map((e) => e == null
            ? null
            : GiftDetailPart.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..AnchorLobbyInfo = json['AnchorLobbyInfo'] == null
        ? null
        : AnchorLobbyInfoDetailPart.fromJson(
            json['AnchorLobbyInfo'] as Map<String, dynamic>)
    ..Id = json['Id'] as String
    ..NickName = json['NickName'] as String
    ..MessageId = json['MessageId'] as String
    ..Code = json['Code'] as num
    ..CorrelationId = json['CorrelationId'] as String;
}

Map<String, dynamic> _$PlayerLobbyConnectModelToJson(
        PlayerLobbyConnectModel instance) =>
    <String, dynamic>{
      'RoomId': instance.RoomId,
      'Videos': instance.Videos,
      'GiftCount': instance.GiftCount,
      'Currency': instance.Currency,
      'Gifts': instance.Gifts,
      'AnchorLobbyInfo': instance.AnchorLobbyInfo,
      'Id': instance.Id,
      'NickName': instance.NickName,
      'MessageId': instance.MessageId,
      'Code': instance.Code,
      'CorrelationId': instance.CorrelationId
    };
