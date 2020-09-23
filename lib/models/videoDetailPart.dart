import 'package:json_annotation/json_annotation.dart';

part 'videoDetailPart.g.dart';

@JsonSerializable()
class VideoDetailPart {
    VideoDetailPart();

    String Flv;
    String Hls;
    num Priority;
    
    factory VideoDetailPart.fromJson(Map<String,dynamic> json) => _$VideoDetailPartFromJson(json);
    Map<String, dynamic> toJson() => _$VideoDetailPartToJson(this);
}
