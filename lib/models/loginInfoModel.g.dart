// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loginInfoModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginInfoModel _$LoginInfoModelFromJson(Map<String, dynamic> json) {
  return LoginInfoModel()
    ..AnchorId = json['AnchorId'] as String
    ..Code = json['Code'] as num
    ..Currency = json['Currency'] as String
    ..Lang = json['Lang'] as String
    ..Level = json['Level'] as num
    ..Pid = json['Pid'] as String
    ..Token = json['Token'] as String
    ..UserFlag = json['UserFlag'] as num
    ..SrcPlatform = json['SrcPlatform'] as String
    ..Origin = json['Origin'] as String;
}

Map<String, dynamic> _$LoginInfoModelToJson(LoginInfoModel instance) =>
    <String, dynamic>{
      'AnchorId': instance.AnchorId,
      'Code': instance.Code,
      'Currency': instance.Currency,
      'Lang': instance.Lang,
      'Level': instance.Level,
      'Pid': instance.Pid,
      'Token': instance.Token,
      'UserFlag': instance.UserFlag,
      'SrcPlatform': instance.SrcPlatform,
      'Origin': instance.Origin
    };
