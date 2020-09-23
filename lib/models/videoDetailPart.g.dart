// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'videoDetailPart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoDetailPart _$VideoDetailPartFromJson(Map<String, dynamic> json) {
  return VideoDetailPart()
    ..Flv = json['Flv'] as String
    ..Hls = json['Hls'] as String
    ..Priority = json['Priority'] as num;
}

Map<String, dynamic> _$VideoDetailPartToJson(VideoDetailPart instance) =>
    <String, dynamic>{
      'Flv': instance.Flv,
      'Hls': instance.Hls,
      'Priority': instance.Priority
    };
