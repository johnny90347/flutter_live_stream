// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fishLiveGameInfoModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FishLiveGameInfoModel _$FishLiveGameInfoModelFromJson(
    Map<String, dynamic> json) {
  return FishLiveGameInfoModel()
    ..Token = json['Token'] as String
    ..AnchorId = json['AnchorId'] as String
    ..LobbyUrl = json['LobbyUrl'] as String
    ..GameUrl = json['GameUrl'] as String
    ..Code = json['Code'] as num
    ..AllowSendGift = json['AllowSendGift'] as bool;
}

Map<String, dynamic> _$FishLiveGameInfoModelToJson(
        FishLiveGameInfoModel instance) =>
    <String, dynamic>{
      'Token': instance.Token,
      'AnchorId': instance.AnchorId,
      'LobbyUrl': instance.LobbyUrl,
      'GameUrl': instance.GameUrl,
      'Code': instance.Code,
      'AllowSendGift': instance.AllowSendGift
    };
