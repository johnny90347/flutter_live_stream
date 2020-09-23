// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'giftDetailPart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GiftDetailPart _$GiftDetailPartFromJson(Map<String, dynamic> json) {
  return GiftDetailPart()
    ..Id = json['Id'] as num
    ..Name = json['Name'] as String
    ..Icon = json['Icon'] as String
    ..Mov = json['Mov'] as String
    ..Value = json['Value'] as num
    ..Priority = json['Priority'] as num;
}

Map<String, dynamic> _$GiftDetailPartToJson(GiftDetailPart instance) =>
    <String, dynamic>{
      'Id': instance.Id,
      'Name': instance.Name,
      'Icon': instance.Icon,
      'Mov': instance.Mov,
      'Value': instance.Value,
      'Priority': instance.Priority
    };
